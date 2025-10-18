extends Panel

func _ready() -> void:
	visible = false


func _on_url_edit_text_submitted(_new_text: String) -> void:
	pass
	

func _on_exit_browser_pressed() -> void:
	visible = false



func _on_close_requested() -> void:
	visible = false
