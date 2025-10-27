extends Panel

@onready var project_panel: Panel = $MainScrollContainer/MainVBox/MainControl/ProjectPanel
@onready var supplier_project_0: Button = $MainScrollContainer/MainVBox/MainControl/ProjectPanel/SupplierIcon0/SupplierProject0
@onready var main_scroll_container: ScrollContainer = $MainScrollContainer


func _ready() -> void:
	visible = false


func _on_url_edit_text_submitted(_new_text: String) -> void:
	pass


@onready var browser_self_anim: AnimationPlayer = $BrowserSelfAnim

func _on_exit_browser_pressed() -> void:
	#visible = false
	browser_self_anim.play("close")

func set_mandatory_project(p : Project):
	project_panel.set_mandatory_project(p)

func _on_close_requested() -> void:
	visible = false

var is_first_scroll := true
func _physics_process(_delta: float) -> void:
	if is_first_scroll:
		if main_scroll_container.scroll_vertical >= 300:
			is_first_scroll = false
			var button = G.M.current_scene.browser_scene.supplier_project_0
			G.M.current_scene.mandatory_guide.set_small_input_area(button.size.x , button.size.y , button.global_position.x , button.global_position.y )
			G.D.display_sentence("好，那就打个飞机")
	
	match window_operation_status:
		"move":
			var relative_mouse_position = get_relative_mouse_position(false , false)
			global_position += relative_mouse_position
	

#region 窗口大小与位置的鼠标拖动设置，以及z_index管理
var window_operation_status : String
var mp : Vector2 # mouse_position
func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("LeftMouseDown"):
		G.M.computer_window_max_z_index += 1
		z_index = G.M.computer_window_max_z_index
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

		#"up":
			#var relative_mouse_position = get_relative_mouse_position(false , false)
			#global_position.y += relative_mouse_position.y
			#size.y -= relative_mouse_position.y
		#"down":
			#var relative_mouse_position = get_relative_mouse_position(true , true)
			#size.y += relative_mouse_position.y
		#"left":
			#var relative_mouse_position = get_relative_mouse_position(false , false)
			#global_position.x += relative_mouse_position.x
			#size.x -= relative_mouse_position.x
		#"right":
			#var relative_mouse_position = get_relative_mouse_position(true , true)
			#size.x += relative_mouse_position.x
		#"top left":
			#var relative_mouse_position = get_relative_mouse_position(false , false)
			#global_position += relative_mouse_position
			#size -= relative_mouse_position
		#"top right":
			#var relative_mouse_position = get_relative_mouse_position(true , false)
			#global_position.y += relative_mouse_position.y
			#size.x += relative_mouse_position.x
			#size.y -= relative_mouse_position.y
		#"bottom left":
			#var relative_mouse_position = get_relative_mouse_position(false , true)
			#global_position.x += relative_mouse_position.x
			#size.x -= relative_mouse_position.x
			#size.y += relative_mouse_position.y
		#"bottom right":
			#var relative_mouse_position = get_relative_mouse_position(true , true)
			#size += relative_mouse_position
