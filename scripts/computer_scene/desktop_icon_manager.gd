extends Control

@onready var computer_scene: ComputerScene = $".."


func _ready() -> void:
	visible = true
	


func _on_open_setting_pressed() -> void:
	var setting_scene = load("res://scenes/setting_scene.tscn").instantiate()
	G.M.change_main_scene(setting_scene , false , false , true)


func _on_open_calendar_pressed() -> void:
	computer_scene.calendar_scene.visible = true
func _on_open_browser_pressed() -> void:
	computer_scene.browser_scene.visible = true
func _on_open_company_pressed() -> void:
	computer_scene.company_scene.visible = true
	
