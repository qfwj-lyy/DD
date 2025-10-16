extends DebugCard

func execute_effect():
	G.M.current_scene.property_manager.add_bug_rate(-0.1)
