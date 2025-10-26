extends Panel
class_name PropertyManager

var current_project : Project
var has_project := false

@export var deliver_project_button : Button
var project_progress : float:
	set(i):
		project_progress = i
		project_progress_bar.value = i
		if i >= 100.0:
			if current_project:
				deliver_project_button.visible = true
			else:
				deliver_project_button.visible = false
		else:
			deliver_project_button.visible = false
var bug_amount : float:
	set(i):
		bug_amount = i
		bug_amount_bar.value = i
		if bug_amount > bug_amount_limit:
			project_fail()
var bug_amount_limit : float = 99999.0:
	set(i):
		bug_amount_limit = i
		bug_amount_bar.max_value = i
var money_amount : float:
	set(i):
		G.play_sound("money")
		money_amount = i
		money_label.text = "资金：" + str(int(i))
var mood_amount : float
var skill_amount : float



var bug_rate : float
var deposit_amount : float
var hand_card_amount_limit : int = 5

var overall_time_amount : float # 时空穿越所需要，目前没有需求
var round_time_amount : float = 1.0#已经使用

@export var money_label: Node
@export var mood_label: Node
@export var skill_label: Node
@export var project_progress_bar: Node
@export var bug_amount_bar: Node
@export var deliver_project : Node

var mood_buffs : Node
#----------还没有bug_rate对应的label----------

@onready var buff_manager: Node = $BuffManager

var is_stop_bug_growth : bool = false #标记本回合是否停止增长bug
var is_stop_income : bool = false #标记本回合是否停止固定收益

func inspect_mood_buffs():
	if mood_amount >= 20:
		if mood_buffs.mood_20_buff:
			mood_buffs.mood_20_buff.reparent_to_buff_manager()
			mood_buffs.mood_20_buff = null
	else:
		if not mood_buffs.mood_20_buff:
			var bf = buff_manager.buff_name_to_buff("Mood20Buff")
			bf.die()
	if mood_amount >= 50:
		if mood_buffs.mood_50_buff:
			mood_buffs.mood_50_buff.reparent_to_buff_manager()
			mood_buffs.mood_50_buff = null
	else:
		if not mood_buffs.mood_50_buff:
			var bf = buff_manager.buff_name_to_buff("Mood50Buff")
			bf.die()
	if mood_amount >= 60:
		if mood_buffs.mood_60_buff:
			mood_buffs.mood_60_buff.reparent_to_buff_manager()
			mood_buffs.mood_60_buff = null
	else:
		if not mood_buffs.mood_60_buff:
			var bf = buff_manager.buff_name_to_buff("Mood60Buff")
			bf.die()
	if mood_amount >= 90:
		if mood_buffs.mood_90_buff:
			mood_buffs.mood_90_buff.reparent_to_buff_manager()
			mood_buffs.mood_90_buff = null
	else:
		if not mood_buffs.mood_90_buff:
			var bf = buff_manager.buff_name_to_buff("Mood90Buff")
			bf.die()
	if mood_amount >= 100:
		if mood_buffs.mood_100_buff:
			mood_buffs.mood_100_buff.reparent_to_buff_manager()
			mood_buffs.mood_100_buff = null
	else:
		if not mood_buffs.mood_100_buff:
			var bf = buff_manager.buff_name_to_buff("Mood100Buff")
			bf.die()

#region add_property
func add_money(n):
	money_amount += n
var is_stop_mood_increase := false
func add_mood(n):
	if is_stop_mood_increase and n > 0:
		return
	mood_amount += n
	pass
	pass
	inspect_mood_buffs()
	mood_label.text = "心情：" + str(mood_amount)
func add_skill(n):
	skill_amount += n
	pass
	pass
	skill_label.text = "技术：" + str(skill_amount)
# 已弃用函数
func add_time(t : int):
	overall_time_amount += t
	pass
	pass
	pass
func add_round_time_amount(n : int):
	round_time_amount += n
signal project_progress_added(_n)
func add_project_progress(n):
	pass
	pass
	project_progress += n
	emit_signal("project_progress_added",n)
	
func add_bug_amount(n):
	pass
	pass
	bug_amount += n
	
func add_bug_rate(n):
	pass
	pass
	bug_rate += n

func add_bug_limit(n):
	pass
	pass
	bug_amount_limit += n
	
func add_deposit_amount(n):
	deposit_amount += n
	
func add_hand_card_amount_limit(n):
	hand_card_amount_limit += n
#endregion

#region set_property
func set_money(n):
	money_amount = n
func set_mood(n):
	if is_stop_mood_increase and n > mood_amount:
		return
	mood_amount = n
	pass
	pass
	inspect_mood_buffs()
	mood_label.text = "心情：" + str(mood_amount)
func set_skill(n):
	skill_amount = n
	pass
	pass
	skill_label.text = "技术：" + str(skill_amount)
func set_project_progress(n):
	pass
	pass
	project_progress = n
func set_bug_amount(n):
	pass
	pass
	bug_amount = n
func set_current_project(p : Project):
	current_project = p
	G.P.has_project = true
	
func set_bug_rate(n):
	bug_rate = n
func set_bug_limit(n):
	bug_amount_limit = n
	
func set_deposit_amount(n):
	deposit_amount = n
func set_hand_card_amount_limit(n):
	hand_card_amount_limit = n
#endregion

func use_money(a) -> bool:
	if money_amount >= a:
		money_amount -= a
		money_label.text = "资金：" + str(money_amount)
		G.play_sound("money")
		return true
	else:
		return false

func _ready() -> void:
	visible = true
	G.P = self
	get_parent().property_manager = self
	mood_buffs = load("res://scenes/computer_scene/mood_buffs.tscn").instantiate()
	add_child(mood_buffs)
	G.M.current_scene.store_scene.store_content = load("res://data/store_content/normal_store_content.tres")
	G.M.current_scene.store_scene.store_card_content = G.M.current_scene.store_scene.store_content.normal_cards
	G.M.current_scene.store_scene.refresh_cards()
	
	
	
func clear():
	set_bug_amount(0)
	set_bug_limit(100)
	set_bug_rate(0)
	set_money(0)
	set_mood(0)
	set_project_progress(0)
	set_skill(0)
	has_project = false
	G.M.current_scene.calendar_scene.clear()

func _on_deliver_project_button_pressed() -> void:
	if project_progress < 99.99:
		G.play_sound("illegal_operation")
		G.D.display_sentence("项目未完成无法提交")
		return
	G.play_sound("win_4_piano")
	for buff in buff_manager.each_project_delivery.get_children():
		buff.execute()
	var buffs = buff_manager.get_all_buffs()
	for buff : Buff in buffs:
		if buff.duration == -9999:
			buff.die()
	add_deposit_amount(current_project.deposit_reward)
	deliver_project.display()
	clear()

func project_fail():
	G.play_sound("close_computer")
	for buff in buff_manager.each_project_delivery.get_children():
		buff.execute()
	var buffs = buff_manager.get_all_buffs()
	for buff : Buff in buffs:
		if buff.duration == -9999:
			buff.die()
	add_deposit_amount(-current_project.initial_money)
	deliver_project.display_failure()
	clear()
