extends Node

@onready var music_manager: Node = $MusicManager
@onready var sound_manager: Node = $SoundManager

var a := 100: 
	set(i):
		a = i
func _ready() -> void:
	a += 10
	print(a)
