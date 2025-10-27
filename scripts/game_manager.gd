extends Node
class_name GameManager

@onready var global_effect_manager: Node = $GlobalEffectManager
@onready var music_manager: Node = $GlobalEffectManager/MusicManager
@onready var sound_manager: Node = $GlobalEffectManager/SoundManager
@onready var screen_manager: Node = $GlobalEffectManager/ScreenManager


var previous_scene
var current_scene

#region 整个游戏的参数初始化与检查
# 确保数据文件可用。软件开始运行时调用
func inspect_data_file() -> void:
	var standard_data_dictionary = {
		"has_music" : true ,
		"has_sound" : true ,
		"music_volume" : 0.3 , 
		"sound_volume" : 0.3 ,
		"is_full_screen" : true
	}
	# 首先确保文件存在，不存在则手动生成
	var file = FileAccess.open(G.SETTINGS_PATH,FileAccess.READ)
	if not file:
		file = FileAccess.open(G.SETTINGS_PATH,FileAccess.WRITE)
		var string = JSON.stringify(standard_data_dictionary)
		file.store_string(string)
		file.close()
		print("data文件缺失，已初始化data文件")
		return
	# 有文件存在，则检查参数是否存在，不存在就初始化文件
	for key in standard_data_dictionary:
		if G.read_setting_data(key) == null:
			file = FileAccess.open(G.SETTINGS_PATH,FileAccess.WRITE)
			var string = JSON.stringify(standard_data_dictionary)
			file.store_string(string)
			file.close()
			print("data文件损坏，已经强制初始化data文件")
			return
		
# 读取文件并将内存数据初始化
func read_data_file_and_initialize() -> void:
	music_manager.global_volume = G.read_setting_data("music_volume")
	sound_manager.global_volume = G.read_setting_data("sound_volume")
	music_manager.has_music = G.read_setting_data("has_music")
	sound_manager.has_sound = G.read_setting_data("has_sound")
	screen_manager.is_full_screen = G.read_setting_data("is_full_screen")
	
# 递归处理所有节点
func scale_all_nodes(node: Node):
	# 检查节点是否有position和size属性
	print(0)
	if node.has_method("get_position") and node.has_method("set_position"):
		print("1")
		var new_pos = node.get_position() * 2
		print(new_pos)
		node.set_position(new_pos)
	
	if node.has_method("get_size") and node.has_method("set_size"):
		var new_size = node.get_size() * 2
		node.set_size(new_size)
	
	# 处理子节点
	for child in node.get_children():
		scale_all_nodes(child)
# 整个软件的开始
func _ready() -> void:
	print("这是测试版。正式版需要修改存储地址")
	print("这是测试版。正式版需要修改初始的current_scene")
	print("测试开启了窗口置顶")
	#get_tree().root.content_scale_size = Vector2(1,1)

	DisplayServer.window_set_size(Vector2(1280 , 800))
	DisplayServer.window_set_position(Vector2(640 , 400))
	
	current_scene = $MainMenu
	G.M = self
	inspect_data_file()
	read_data_file_and_initialize()
	G.play_sound("open_computer")
	
	music_manager.initialize()
	
	#var root_node = get_tree().root.get_child(1)
	#scale_all_nodes(root_node)
	#print("所有节点已按2倍比例缩放")
#endregion

#region 场景切换管理器 场景复用
var temporary_visible_scene
func change_main_scene(new_scene , kill_last_scene : bool , change_M_scene_parameter : bool , need_adding_child : bool):
	# 修改可见度
	current_scene.visible = false
	new_scene.visible = true
	if kill_last_scene:
		if change_M_scene_parameter:
			previous_scene = null
		current_scene.queue_free()
	else:
		if change_M_scene_parameter:
			previous_scene = current_scene
	if change_M_scene_parameter:
		current_scene = new_scene
	else:
		temporary_visible_scene = new_scene
	if need_adding_child:
		add_child(new_scene)
		
func return_last_main_scene(kill_current_scene : bool , change_M_scene_parameter : bool):
	if temporary_visible_scene:
		temporary_visible_scene.visible = false
		current_scene.visible = true
		if kill_current_scene:
			temporary_visible_scene.queue_free()
			temporary_visible_scene = null
		return
	current_scene.visible = false
	previous_scene.visible = true
	if change_M_scene_parameter:
		var temp = current_scene
		current_scene = previous_scene
		previous_scene = temp
	if kill_current_scene:
		current_scene.queue_free()
	
func add_scene(_new_scene):
	pass
#endregion

#region ComputerWindow的z_index管理
var computer_window_max_z_index := 1 # 1-9999
func set_top_window(node : Node):
	node.z_index = computer_window_max_z_index
	computer_window_max_z_index += 1
