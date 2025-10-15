extends Buff

var property : PropertyManager = G.M.current_scene.property_manager

func execute():
	property.add_mood(-1)
	property.add_skill(3)
