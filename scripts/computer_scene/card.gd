extends Control
class_name Card

@export var money : int = -1
@export var mood : int = -1
@export var time : int = -1 
@export var progress : int = -1 
@export var bug : int = -1
@export var skill : int = -1

var property : PropertyManager = G.M.current_scene.property_manager

func execute():
	property.add_money(money)
	property.add_mood(mood)
	property.add_time(time)
	property.add_project_progress(progress)
	property.add_bug_amount(bug)
	property.add_skill(skill)
	
	execute_effect()

func execute_effect():
	pass
