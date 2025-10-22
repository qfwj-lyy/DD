extends Panel

@onready var project_panel: Panel = $MainScrollContainer/MainVBox/MainControl/ProjectPanel


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
