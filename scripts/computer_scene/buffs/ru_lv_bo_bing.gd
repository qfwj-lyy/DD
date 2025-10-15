extends Buff

func execute():
	var random_number = randi_range(-5,5)
	G.M.current_scene.property_manager.add_project_progress(random_number)
	pass
