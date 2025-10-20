extends Buff


func execute():
	G.M.current_scene.calendar_scene.connect("a_debug_card_used" , decrease_bug_amount)

func die():
	G.M.current_scene.calendar_scene.disconnect("a_debug_card_used" , decrease_bug_amount)
	super.die()

func decrease_bug_amount():
	G.P.add_bug_amount(-2)
