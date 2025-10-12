extends VBoxContainer

@onready var property_manager: PropertyManager = $"../../PropertyManager"

var display_project_limit := 2
func browse_web(web_name : String):
	for p in get_children():
		p.queue_free()
	var web : ProjectWeb = load("res://assets/project_webs/" + web_name + ".tres")
	var display_project_amount := 0
	while(1):
		var project_scene = load("res://scenes/computer_scene/browser_scene/project_scene.tscn").instantiate()
		add_child(project_scene)
		var rand_project = web.projects[randi_range(0 , web.projects.size() - 1)]
		project_scene.set_project_information(rand_project)
		web.projects.erase(rand_project)
		display_project_amount += 1
		if web.projects.size() <= 0:
			break
		if display_project_amount >= display_project_limit:
			break

func choose_project(p : Project):
	if property_manager.current_project:
		pass
		pass
		return
	property_manager.set_current_project(p)
	property_manager.set_money(p.initial_money)
	property_manager.set_mood(p.initial_mood)
	property_manager.set_skill(p.initial_skill)
	property_manager.set_project_progress(p.initial_progress)
	property_manager.set_bug_amount(p.initial_bug_amount)
	
