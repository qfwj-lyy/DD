extends Node

var M : GameManager
var P : PropertyManager
var D : DialogueManager

#region 声音管理
func play_music(music_name : String , volume_db : float = 0 , from_position : float = 0 ):
	M.music_manager.play_music(music_name , from_position , volume_db)
func play_sound(sound_name : String , volume_db : float = 0 , from_position : float = 0 ):
	M.sound_manager.play_sound(sound_name , from_position , volume_db)
func kill_sound(sound_name : String):
	M.sound_manager.kill_sound(sound_name)
#endregion

#region settings文件的读写
# res仅供测试，正式版路径user://data/settings.json
const SETTINGS_PATH := "res://settings.json"
func write_setting_data(setting : String, condition) -> void:
	var file = FileAccess.open(SETTINGS_PATH,FileAccess.READ)
	var string = file.get_as_text()
	file.close()
	var dictionary_datas = JSON.parse_string(string)
	
	if not dictionary_datas:
		printerr("数据文件损坏! error in G")
		print("尝试自动修复")
		M.inspect_data_file()
		return
	dictionary_datas[setting] = condition
	string = JSON.stringify(dictionary_datas)
	file = FileAccess.open(SETTINGS_PATH,FileAccess.WRITE)
	file.store_string(string)
	file.close()
	
func read_setting_data(setting : String):
	var file = FileAccess.open(SETTINGS_PATH,FileAccess.READ)
	var string = file.get_as_text()
	file.close()
	var dictionary_datas = JSON.parse_string(string)

	if dictionary_datas == null:
		printerr("数据文件损坏! error in G")
		print("尝试自动修复")
		M.inspect_data_file()
		
		
		return null
	if dictionary_datas.has(setting):
		return dictionary_datas[setting]
	else:
		printerr("数据文件损坏! error in G")
		print("尝试自动修复")
		M.inspect_data_file()
		
		return null
#endregion
