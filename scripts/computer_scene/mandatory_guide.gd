extends Control
@onready var full_screen_input_stop: Control = $FullScreenInputStop
@onready var small_input_area: Control = $FullScreenInputStop/SmallInputArea

func set_small_input_area(area_size_x , area_size_y , area_position_x , area_position_y):
	#full_screen_input_stop.visible = true
	full_screen_input_stop.is_open = true
	small_input_area.size = Vector2(area_size_x , area_size_y)
	small_input_area.position = Vector2(area_position_x , area_position_y)
	
	
func clear():
	full_screen_input_stop.clear()
	#full_screen_input_stop.visible = false
