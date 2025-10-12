extends Node
class_name Buff

var duration : int

# 当进入场景树时，即生效某效果
func _enter_tree() -> void:
	printerr("存在未创建_enter_tree()的Buff")
	
func time_goes_by(time : int):
	pass
