extends Node

# 音量大小参数
var global_volume : float = 0.3
var has_music : bool = true


# 默认的随机音乐播放器所使用的参数
var music_names = [
	"a"
]
var last_music_name : String

# 无输入时，仅更新音乐音量。可输入settings的参数。
func update_volume(parameter = 0) -> void:
	# 设置music参数
	if parameter is bool:
		has_music = parameter
	elif parameter is float:
		global_volume = parameter
	# 更新所有music的volume
	for i in get_children():
		if not has_music:
			i.volume_linear = 0.0
		else:
			i.volume_linear = global_volume
	
	
func play_music(music_name : String , from_position : float = 0 , volume_db : float = 0):
	var audio = AudioStreamPlayer.new()
	audio.stream = load("res://assets/music/"+music_name+".mp3")
	if not audio.stream:
		printerr("错误！导入音乐"+music_name+"失败")
	if not has_music:
		audio.volume_linear = 0.0
	else:
		audio.volume_db = volume_db
		var linear = audio.volume_linear
		linear = global_volume * linear
		audio.volume_linear = linear
	add_child(audio)
	audio.play(from_position)
	return audio

func random_music_player():
	var random_name
	while(1):
		if get_child_count() != 0:
			for i in get_children():
				if i.playing == false:
					i.free()
		else:
			while(1):
				random_name = music_names[randi_range(0,music_names.size()-1)]
				if random_name != last_music_name:
					break
			play_music(random_name)
			last_music_name = random_name
		await get_tree().create_timer(1).timeout
		
var current_volume : float
func initialize() -> void:
	await get_tree().create_timer(3).timeout
	var music = play_music("b")
	music.volume_linear = 0
	for i in 350:
		await get_tree().create_timer(0.01).timeout
		if has_music:
			music.volume_linear = (1.0 / 349 * i) * global_volume
	random_music_player()
	
