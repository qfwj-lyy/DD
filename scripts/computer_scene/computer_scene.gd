extends CanvasLayer
class_name ComputerScene


@onready var property_manager: Node = $PropertyManager
@onready var browser_scene: Node = $BrowserScene

func _ready() -> void:
	print("这是测试版，正式版需要修改computer scene的_ready的visible修改")
	visible = true

func _on_open_setting_pressed() -> void:
	var setting_scene = load("res://scenes/setting_scene.tscn").instantiate()
	G.M.change_main_scene(setting_scene , false , false , true)
