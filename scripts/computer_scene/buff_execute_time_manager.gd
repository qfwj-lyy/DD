extends Node

func _ready() -> void:
	connect("child_entered_tree" , get_parent().add_buff_icon)
	connect("child_exiting_tree" , get_parent().erase_buff_icon)
