extends Node
class_name Buff

@export var duration : int 
# -9:round left time  -9999:project left time

enum ExecutionTime {
	once,
	each_round_begin,
	each_round_over,
	each_time,
	each_project_delivery
}
@export var execution_time : ExecutionTime

@export_multiline var description : String

var buff_manager = G.M.current_scene.property_manager.buff_manager

# 当进入场景树时，即生效某效果
func _enter_tree() -> void:
	pass
	
func time_goes_by(_time : int):
	pass
	
func execute():
	pass

func reparent_to_buff_manager():
	match execution_time:
		ExecutionTime.once:
			reparent(buff_manager.once)
		ExecutionTime.each_round_begin:
			reparent(buff_manager.each_round_begin)
		ExecutionTime.each_round_over:
			reparent(buff_manager.each_round_over)
		ExecutionTime.each_time:
			reparent(buff_manager.each_time)
		ExecutionTime.each_project_delivery:
			reparent(buff_manager.each_project_delivery)
	
