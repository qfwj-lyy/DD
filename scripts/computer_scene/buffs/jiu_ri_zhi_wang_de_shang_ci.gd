extends Buff

func execute():
	var pp : int = G.M.current_scene.property_manager.project_progress
	G.M.current_scene.property_manager.add_money(ceil(pp * 0.2))
