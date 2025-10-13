extends Control

@export var computer_scene: ComputerScene
@export var debug_hand: Node
@export var activity_hand: Node
@export var unused_hand: Node

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
			pass
			
			#----------这里执行"每回合开始时"相关buff----------
			
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
		
		if current_time == max_time :
			pass
			
			#----------这里执行"每回合结束时"相关buff----------
			
		#----------这里执行"每单位时间"相关buff----------
		
	#endregion
	#for card in debug_hand.get_children():
		#card.execute()
	#for card in activity_hand.get_children():
		#card.execute()

func _on_execute_plan_button_pressed() -> void:
	pass
	pass
	execute_plan()
