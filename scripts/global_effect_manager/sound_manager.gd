extends Node

# 音量大小参数
var global_volume : float = 0.3
var has_sound : bool = true


# 音效降重效果所需要的参数
var last_last_time
var last_last_sound
var last_time
var last_sound


# 无输入时，仅更新音效音量。可输入settings的参数。
func update_volume(parameter = 0):
	# 设置music参数
	if parameter is bool:
		has_sound = parameter
	elif parameter is float:
		global_volume = parameter
	# 更新所有sound的volume
	for i in get_children():
		if not has_sound:
			i.volume_linear = 0.0
		else:
			i.volume_linear = global_volume
			
	
func play_sound(sound_name : String , from_position : float = 0 , volume_db : float = 0):
	var current_time = Time.get_ticks_msec()
	if last_last_sound == sound_name:
		if (current_time - last_last_time) < 3:
			return
	elif last_sound == sound_name:
		if (current_time - last_time) < 3:
			return
			
	var audio = AudioStreamPlayer.new()
	var path = "res://assets/sounds/"+sound_name+".mp3"
	if ResourceLoader.exists(path):
		audio.stream = load(path)
	else:
		printerr("错误！导入音效"+sound_name+"失败")
	if not has_sound:
		audio.volume_linear = 0.0
	else:
		audio.volume_db = volume_db
		var linear = audio.volume_linear
		linear = global_volume * linear
		audio.volume_linear = linear
	audio.connect("finished" , audio.queue_free)
	add_child(audio)
	audio.play(from_position)
	
	last_last_time = last_time
	last_last_sound = last_sound
	last_time = Time.get_ticks_msec()
	last_sound = sound_name
	
	
func get_all_sound_nodes():
	return get_children()
	
func kill_sound(sound_name : String):
	var s_s = load("res://assets/sounds/"+ sound_name +".mp3")
	for s_n:AudioStreamPlayer in get_all_sound_nodes():
		if is_instance_valid(s_n):
			if s_n.stream == s_s:
				s_n.queue_free()
	#print("warning：kill_sound() fail")
