extends CanvasLayer
class_name ComputerScene


@onready var property_manager: Node = $PropertyManager
@onready var browser_scene: Control = $BrowserScene

func _ready() -> void:
	visible = false

func _on_open_setting_pressed() -> void:
	var setting_scene = load("res://scenes/setting_scene.tscn").instantiate()
	G.M.change_main_scene(setting_scene , false , false , true)
