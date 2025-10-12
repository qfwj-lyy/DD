extends CanvasLayer

@onready var computer_scene: ComputerScene = $"../ComputerScene"

func _on_open_setting_pressed() -> void:
	var setting_scene = load("res://scenes/setting_scene.tscn").instantiate()
	G.M.change_main_scene(setting_scene , false , false , true)

func _on_begin_game_pressed() -> void:
	G.M.change_main_scene(computer_scene , true , true , false)


func _on_exit_game_pressed() -> void:
	get_tree().quit()
