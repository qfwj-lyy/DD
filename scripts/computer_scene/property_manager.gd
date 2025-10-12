extends Panel
class_name PropertyManager

var current_project : Project

var money_amount : float
var mood_amount : float
var skill_amount : float

@export var money_label: Node
@export var mood_label: Node
@export var skill_label: Node
@export var project_progress_bar: Node
@export var bug_amount_bar: Node
@export var global_buffs: Node



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
func add_project_progress(n):
	pass
	pass
	project_progress_bar.value += n
func add_bug_amount(n):
	pass
	pass
	bug_amount_bar.value += n
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
	project_progress_bar.value = n
func set_bug_amount(n):
	pass
	pass
	bug_amount_bar.value = n
func set_current_project(p : Project):
	current_project = p
#endregion

func time_goes_by(time : int):
	global_buffs.time_goes_by(time)
