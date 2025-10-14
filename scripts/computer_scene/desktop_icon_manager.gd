extends Control

@export var calendar_scene: Node
@export var browser_scene: Node




func _on_open_setting_pressed() -> void:
	var setting_scene = load("res://scenes/setting_scene.tscn").instantiate()
	G.M.change_main_scene(setting_scene , false , false , true)


func _on_open_calendar_pressed() -> void:
	calendar_scene.visible = true
func _on_open_browser_pressed() -> void:
	browser_scene.visible = true
