extends Node

func time_goes_by(time : int):
	for buff in get_children():
		buff.time_goes_by(time)
		
