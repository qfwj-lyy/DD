extends CanvasLayer


func _on_open_setting_pressed() -> void:
	var setting_scene = load("res://scenes/setting_scene.tscn").instantiate()
	G.M.change_main_scene(setting_scene , false , false , true)

func _on_begin_game_pressed() -> void:
	var computer_scene = load("res://scenes/computer_scene/computer_scene.tscn").instantiate()
	G.M.change_main_scene(computer_scene , true , true , true)


func _on_exit_game_pressed() -> void:
	get_tree().quit()

func _ready() -> void:
	visible = true
