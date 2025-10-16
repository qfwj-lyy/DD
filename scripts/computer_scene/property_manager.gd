extends Panel
class_name PropertyManager

var current_project : Project

var project_progress : float:
	set(i):
		project_progress = i
		project_progress_bar.value = i
var bug_amount : float:
	set(i):
		bug_amount = i
		bug_amount_bar.value = i
var bug_amount_limit : float:
	set(i):
		bug_amount_limit = i
		bug_amount_bar.max = i
var money_amount : float
var mood_amount : float
var skill_amount : float
var time_amount : float # 时空穿越所需要，目前没有需求

var bug_rate : float
var bug_limit : float


@export var money_label: Node
@export var mood_label: Node
@export var skill_label: Node
@export var project_progress_bar: Node
@export var bug_amount_bar: Node
@export var global_buffs: Node

#----------还没有bug_rate对应的label----------
#----------还没有bug_limit对应的label----------

@onready var buff_manager: Node = $BuffManager


#region add_property
func add_money(n):
	money_amount += n
	pass
	pass
	money_label.text = "资金：" + str(money_amount)
func add_mood(n):
	mood_amount += n
	pass
	pass
	mood_label.text = "心情：" + str(mood_amount)
func add_skill(n):
	skill_amount += n
	pass
	pass
	skill_label.text = "技术：" + str(skill_amount)
# 已弃用函数
func add_time(t : int):
	time_amount += t
	pass
	pass
	pass
	
func add_project_progress(n):
	pass
	pass
	project_progress += n
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
	bug_limit += n
#endregion

#region set_property
func set_money(n):
	money_amount = n
	pass
	pass
	money_label.text = "资金：" + str(money_amount)
func set_mood(n):
	mood_amount = n
	pass
	pass
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
	
func set_bug_rate(n):
	bug_rate = n
func set_bug_limit(n):
	bug_limit = n
#endregion

func use_money(a) -> bool:
	if money_amount >= a:
		money_amount -= a
		money_label.text = "资金：" + str(money_amount)
		return true
	else:
		return false
