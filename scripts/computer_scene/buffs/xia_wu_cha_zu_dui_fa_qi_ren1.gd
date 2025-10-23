extends Buff

func execute():
	G.M.current_scene.calendar_scene.connect("a_debug_card_used" , increase_bug)

func die():
	G.M.current_scene.calendar_scene.disconnect("a_debug_card_used" , increase_bug)
	super.die()

func increase_bug():
	G.P.add_bug_amount(1)
