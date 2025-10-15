extends Buff

func execute():
	var ba : int = G.M.current_scene.property_manager.bug_amount
	G.M.current_scene.property_manager.add_project_progress(floor(ba * 0.1))
