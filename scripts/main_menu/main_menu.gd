extends Control

@onready var begin_game_anim: AnimationPlayer = $BeginGame/BeginGameAnim
@onready var exit_game_anim: AnimationPlayer = $ExitGame/ExitGameAnim
@onready var settings_anim: AnimationPlayer = $OpenSetting/SettingsAnim
@onready var camera_2d: Camera2D = $Camera2D

#func _on_open_setting_pressed() -> void:
#	var setting_scene = load("res://scenes/setting_scene.tscn").instantiate()
#	G.M.change_main_scene(setting_scene , false , false , true)

#func _on_begin_game_pressed() -> void:
#	var computer_scene = load("res://scenes/computer_scene/computer_scene.tscn").instantiate()
#	G.M.change_main_scene(computer_scene , true , true , true)


#func _on_exit_game_pressed() -> void:
#	get_tree().quit()

func _ready() -> void:
	visible = true


func _on_begin_game_button_down() -> void:
	begin_game_anim.play("button_down")

func _on_begin_game_button_up() -> void:
	begin_game_anim.play("button_up")
	var computer_scene = load("res://scenes/computer_scene/computer_scene.tscn").instantiate()
	G.M.change_main_scene(computer_scene , true , true , true)


func _on_exit_game_button_down() -> void:
	exit_game_anim.play("button_down")


func _on_exit_game_button_up() -> void:
	exit_game_anim.play("button_up")
	get_tree().quit()


func _on_open_setting_button_down() -> void:
	settings_anim.play("button_down")


func _on_open_setting_button_up() -> void:
	settings_anim.play("button_up")
	var setting_scene = load("res://scenes/setting_scene.tscn").instantiate()
	G.M.add_child(setting_scene)

func _physics_process(_delta: float) -> void:
	camera_2d.position = (get_global_mouse_position() - Vector2(1280 , 800) ) * 0.1 + Vector2(1280 , 800)
