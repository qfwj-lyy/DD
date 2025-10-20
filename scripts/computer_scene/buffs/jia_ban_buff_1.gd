extends Buff

func increase_money(project_progress):
	if project_progress > 0:
		G.M.current_scene.property_manager.add_money(project_progress * 2)

func execute():
	G.M.current_scene.property_manager.connect("project_progress_added" , increase_money)
	
func die():
	G.M.current_scene.property_manager.disconnect("project_progress_added" , increase_money)
	super.die()
	
