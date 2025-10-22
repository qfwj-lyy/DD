extends CanvasLayer

var global_effect_manager : Node

@export var music_scroll_bar : HScrollBar
@export var sound_scroll_bar : HScrollBar
@export var music_check_button : CheckButton
@export var sound_check_button : CheckButton


# 读取目前内存的设置状态，以修正初始显示
func _read_global_effect_manager() -> void:
	music_scroll_bar.value = global_effect_manager.music_manager.global_volume * 100
	sound_scroll_bar.value = global_effect_manager.sound_manager.global_volume * 100
	music_check_button.set_pressed_no_signal(global_effect_manager.music_manager.has_music)
	sound_check_button.set_pressed_no_signal(global_effect_manager.sound_manager.has_sound)
	
func _ready() -> void:
	global_effect_manager = G.M.global_effect_manager
	_read_global_effect_manager()
	
func _on_music_scroll_bar_value_changed(value: float) -> void:
	global_effect_manager.music_manager.update_volume(value / 100)
func _on_sound_scroll_bar_value_changed(value: float) -> void:
	global_effect_manager.sound_manager.update_volume(value / 100)
func _on_sound_check_button_toggled(toggled_on: bool) -> void:
	global_effect_manager.sound_manager.update_volume(toggled_on)
func _on_music_check_button_toggled(toggled_on: bool) -> void:
	global_effect_manager.music_manager.update_volume(toggled_on)


#region 按下返回按钮，保存设置，智能执行返回
func write_settings():
	G.write_setting_data("music_volume",music_scroll_bar.value / 100)
	G.write_setting_data("sound_volume",sound_scroll_bar.value / 100)
	G.write_setting_data("has_music",music_check_button.button_pressed)
	G.write_setting_data("has_sound",sound_check_button.button_pressed)
	
#endregion


func _on_full_screen_check_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		

func _on_close_texture_gui_input(event: InputEvent) -> void:
	if event.is_action_released("LeftMouseDown"):
		write_settings()
		queue_free()
