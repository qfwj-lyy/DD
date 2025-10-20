extends Panel

@export var computer_scene: ComputerScene
@export var debug_hand: Node
@export var activity_hand: Node
@export var unused_hand: Node
@onready var buff_manager: Node = $"../PropertyManager/BuffManager"

func _ready() -> void:
	visible = false

signal a_debug_card_used()
signal a_activity_card_used()
func execute_plan():
	#region 时间结算架构
	var debug_time_flag_array : Array[int] #按顺序存储玩家放置的所有debug卡的时间
	var debug_current_card_flag : int = 0 #标识待执行debug卡
	var activity_time_flag_array : Array[int] #按顺序存储玩家放置的所有activity卡的时间
	var activity_current_card_flag : int = 0 #标识待执行debug卡
	var debug_time_sum : int = 0 #本回合debug卡时间总和
	var activity_time_sum : int = 0 #本回合activity卡时间总和
	
	#这里分别告诉计算机debug卡和activity卡的时间，并分别计算时间总和
	for card in debug_hand.get_children():
		if card is Card:
			debug_time_flag_array.append(card.time)
			debug_time_sum += card.time
	for card in activity_hand.get_children():
		if card is Card:
			activity_time_flag_array.append(card.time)
			activity_time_sum += card.time
	
	var max_time : int = max(debug_time_sum , activity_time_sum)
	var current_time : int = 0
	
	
	# 按单位时间推进日程安排
	while(current_time != max_time):
		G.M.current_scene.time_goes_by(1)
		#----------这里写员工计算工资相关方法----------
		G.M.current_scene.company_scene.inspect_wage()
		if current_time == 0:
			#----------这里执行"每回合开始时"相关buff----------
			for buff in buff_manager.each_round_begin.get_children():
				buff.execute()
			
		#debug卡顺序执行
		var debug_cal_time_sum : int = 0
		for cal_time in debug_time_flag_array:
			debug_cal_time_sum += cal_time
			if current_time == debug_cal_time_sum :
				if debug_hand.get_child(debug_current_card_flag) is Card:
					emit_signal("a_debug_card_used")
					debug_hand.get_child(debug_current_card_flag).execute()
					debug_current_card_flag += 1
		
		#activity卡顺序执行
		var activity_cal_time_sum : int = 0
		for cal_time in activity_time_flag_array:
			activity_cal_time_sum += cal_time
			if current_time == activity_cal_time_sum :
				if activity_hand.get_child(activity_current_card_flag) is Card:
					emit_signal("a_activity_card_used")
					activity_hand.get_child(activity_current_card_flag).execute()
					activity_current_card_flag += 1
		
		current_time += 1
		
		#----------这里写商店时钟相关方法----------
		G.M.current_scene.store_scene.time_goes_by(1)
		#----------单位时间结束
		
		#region 每单位时间固定收益
		if !G.M.current_scene.property_manager.is_stop_income:
			var bug_income_correction : float = ceil(G.M.current_scene.property_manager.bug_amount / G.M.current_scene.property_manager.bug_amount_limit * 5) * 0.5
			if bug_income_correction == 0:
				var income : int = G.M.current_scene.property_manager.project_progress * G.M.current_scene.property_manager.skill_amount / 1000
				if income <= 1:
					G.M.current_scene.property_manager.add_money(1)
				else :
					G.M.current_scene.property_manager.add_money(income)
			else :
				var income : int = G.M.current_scene.property_manager.project_progress * G.M.current_scene.property_manager.skill_amount / 1000 * bug_income_correction
				if income <= 1:
					G.M.current_scene.property_manager.add_money(1)
				else :
					G.M.current_scene.property_manager.add_money(income)
		
		#endregion
		
		#----------这里执行"每单位时间"相关buff----------
		
		for buff in buff_manager.each_time.get_children():
			buff.execute()
		#-----单位时间buff的持续时间结算
		var buffs = buff_manager.get_all_buffs()
		for buff in buffs:
			if buff.duration >= 2:
				buff.duration -= 1
			elif buff.duration == 1:
				buff.die()

		#----------回合结束
		if current_time == max_time :
			#region 回合结束时固定增长bug
			
			if !G.M.current_scene.property_manager.is_stop_bug_growth:
				G.M.current_scene.property_manager.add_bug_amount(G.M.current_scene.property_manager.project_progress * G.M.current_scene.property_manager.bug_rate)
				var project_stage_correction = ceil(G.M.current_scene.property_manager.project_progress / 20)
				var bug_rate_correction = ceil(G.M.current_scene.property_manager.project_progress / G.M.current_scene.property_manager.skill_amount) * project_stage_correction 
				G.M.current_scene.property_manager.add_bug_rate(bug_rate_correction)
			if G.M.current_scene.property_manager.is_stop_bug_growth:
				G.M.current_scene.property_manager.is_stop_bug_growth = false
				#清除阻止回合结束时增长的buff
			
			#endregion
			
			G.M.current_scene.property_manager.is_stop_income = false #回合结束时清除阻止固定收入的buff
			
			#----------这里执行"每回合结束时"相关buff----------
			for buff in buff_manager.each_round_over.get_children():
				buff.execute()
			#-----回合结束，清除“仅本回合生效的buff”
			buffs = buff_manager.get_all_buffs()
			for buff in buffs:
				if buff.duration == -9:
					buff.die()

			
	#------清除所有刚刚使用的牌
	for card in debug_hand.get_children():
		card.queue_free()
	for card in activity_hand.get_children():
		card.queue_free()
	#endregion
	
	#for card in debug_hand.get_children():
		#card.execute()
	#for card in activity_hand.get_children():
		#card.execute()

func _on_execute_plan_button_pressed() -> void:
	pass
	pass
	execute_plan()


func _on_close_requested() -> void:
	visible = false

func get_hand_cards_amount() -> int:
	var n : int = 0
	n += debug_hand.get_child_count()
	n += unused_hand.get_child_count()
	n += activity_hand.get_child_count()
	
	return n


func _on_calender_button_pressed() -> void:
	pass
	pass
	visible = false
