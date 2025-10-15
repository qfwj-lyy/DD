extends Buff


func execute():
	var pp = G.M.current_scene.property_manager.project_progress
	var ba = G.M.current_scene.property_manager.bug_amount
	G.M.current_scene.property_manager.add_money(clamp(pp-ba , 0 , 99999999))
	
	
