extends ActivityCard

func execute_effect():
	var add_bug_limit = floor(G.M.current_scene.property_manager.bug_amount_limit * 0.1) 
	G.M.current_scene.property_manager.add_bug_amount_limit(add_bug_limit)
