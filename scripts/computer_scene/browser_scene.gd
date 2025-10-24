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
