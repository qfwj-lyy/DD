extends Window

@export var computer_scene: ComputerScene
@export var debug_hand: Node
@export var activity_hand: Node
@export var unused_hand: Node
@onready var buff_manager: Node = $"../PropertyManager/BuffManager"

func _ready() -> void:
	visible = false


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
		
		#----------这里写员工计算工资相关方法----------
		
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
					debug_hand.get_child(debug_current_card_flag).execute()
					debug_current_card_flag += 1
		
		#activity卡顺序执行
		var activity_cal_time_sum : int = 0
		for cal_time in activity_time_flag_array:
			activity_cal_time_sum += cal_time
			if current_time == activity_cal_time_sum :
				if activity_hand.get_child(activity_current_card_flag) is Card:
					activity_hand.get_child(activity_current_card_flag).execute()
					activity_current_card_flag += 1
		
		current_time += 1
		
		#----------这里写商店时钟相关方法----------
		G.M.current_scene.store_scene.time_goes_by(1)
		#----------单位时间结束
		#----------这里执行"每单位时间"相关buff----------
		for buff in buff_manager.each_time.get_children():
			buff.execute()
		#-----单位时间buff的持续时间结算
		var buffs = buff_manager.get_all_buffs()
		for buff in buffs:
			if buff.duration >= 2:
				buff.duration -= 1
			elif buff.duration == 1:
				buff.queue_free()

		#----------回合结束
		if current_time == max_time :
			#----------这里执行"每回合结束时"相关buff----------
			for buff in buff_manager.each_round_over.get_children():
				buff.execute()
			#-----回合结束，清除“仅本回合生效的buff”
			buffs = buff_manager.get_all_buffs()
			for buff in buffs:
				if buff.duration == -9:
					buff.queue_free()

			
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
