extends Buff

func execute():
	G.M.current_scene.property_manager.is_stop_mood_increase = true
	
func die():
	G.M.current_scene.property_manager.is_stop_mood_increase = false
	super.die()
