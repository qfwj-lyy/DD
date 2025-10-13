extends Node
class_name Buff

@export var duration : int 
# -9:round left time  -99:project left time

enum ExecutionTime {
	each_round_begin,
	each_time,
	this_round_over
}
@export var execution_time : ExecutionTime


# 当进入场景树时，即生效某效果
func _enter_tree() -> void:
	pass
	
func time_goes_by(_time : int):
	pass
	
func execute():
	pass
