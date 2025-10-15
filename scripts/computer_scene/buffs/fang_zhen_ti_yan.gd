extends Buff

func execute():
	var m : PropertyManager = G.M.current_scene.property_manager
	if m.bug_amount < m.bug_amount_limit * 0.8:
		printerr("获得额外50%存款来源于project的仿真体验buff")
