extends Node

@onready var music_manager: Node = $MusicManager
@onready var sound_manager: Node = $SoundManager

func _ready() -> void:
	pass
	#get_tree().root.content_scale_size = Vector2(1,1)
	DisplayServer.window_set_size(Vector2(1280 , 800))
	DisplayServer.window_set_position(Vector2(640 , 400))
