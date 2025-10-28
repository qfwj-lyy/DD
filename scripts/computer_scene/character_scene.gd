extends Panel
@export var deposit_label : Node

func _ready() -> void:
	hide()
	
	
#region 窗口大小与位置的鼠标拖动设置，以及z_index管理
func _physics_process(_delta: float) -> void:
	match window_operation_status:
		"move":
			var relative_mouse_position = get_relative_mouse_position(false , false)
			global_position += relative_mouse_position
	
var window_operation_status : String
var mp : Vector2 # mouse_position
func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("LeftMouseDown"):
		G.M.set_top_window(self)
		mp = get_local_mouse_position()
		if(mp.y >= 50):
			return
		else:
			window_operation_status = "move"
		#elif(mp.x >= margin and mp.x <= size.x - margin and mp.y <= margin):
			#window_operation_status = "up"
		#elif(mp.x >= margin and mp.x <= size.x - margin):
			#window_operation_status = "down"
		#elif(mp.x <= margin and mp.y >= margin and mp.y <= size.y - margin):
			#window_operation_status = "left"
		#elif(mp.x >= size.x - margin and mp.y >= margin and mp.y <= size.y - margin):
			#window_operation_status = "right"
		#elif(mp.x <= margin and mp.y <= margin):
			#window_operation_status = "top left"
		#elif(mp.y <= margin):
			#window_operation_status = "top right"
		#elif(mp.x <= margin):
			#window_operation_status = "bottom left"
		#else:
			#window_operation_status = "bottom right"
		#be_clicked()
func get_relative_mouse_position(set_mp_x : bool , set_mp_y : bool):
	var new_mp = get_local_mouse_position()
	var old_mp = mp
	if set_mp_x:
		mp.x = new_mp.x
	if set_mp_y:
		mp.y = new_mp.y
	return new_mp - old_mp
func _input(event: InputEvent) -> void:
	if event.is_action_released("LeftMouseDown"):
		window_operation_status = ""
#endregion


func _on_texture_rect_gui_input(event: InputEvent) -> void:
	if event.is_action_released("LeftMouseDown"):
		visible = false
