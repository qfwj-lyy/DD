extends Buff

func execute():
	G.M.current_scene.calendar_scene.connect("an_activity_card_used" , increase_project_progress)

func die():
	G.M.current_scene.calendar_scene.disconnect("an_activity_card_used" , increase_project_progress)
	super.die()

func increase_project_progress():
	G.P.add_project_progress(1)
