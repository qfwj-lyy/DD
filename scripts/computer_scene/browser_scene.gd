extends Window

@onready var project_v_box: VBoxContainer = $ProjectVBox

func _ready() -> void:
	visible = false

func _on_url_edit_text_submitted(new_text: String) -> void:
	pass
	
func browse_web(web_name : String):
	project_v_box.browse_web(web_name)
func _on_button_pressed() -> void:
	browse_web("project_web_0")
	

func _on_exit_browser_pressed() -> void:
	for p in project_v_box.get_children():
		p.queue_free()
	visible = false



func _on_close_requested() -> void:
	visible = false
