extends Buff
class_name PropertyBuff

@export var money : int
@export var mood : int
@export var skill : int
@export var project_progress : int
@export var bug_amount : int

func execute():
	var p : PropertyManager = G.M.current_scene.property_manager
	p.add_money(money)
	p.add_mood(mood)
	p.add_skill(skill)
	p.add_project_progress(project_progress)
	p.add_bug_amount(bug_amount)
	
