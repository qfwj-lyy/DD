extends Node
class_name Buff

@export var duration : int 
# -9:round left time  -9999:project left time
# -7:staff buff (over with staff)
# -8: forever

enum ExecutionTime {
	once,
	each_round_begin,
	each_round_over,
	each_time,
	each_project_delivery
}
@export var execution_time : ExecutionTime



@export_multiline var description : String

var buff_manager = G.P.buff_manager

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
			execute()
			if duration == 0:
				die()
		ExecutionTime.each_round_begin:
			reparent(buff_manager.each_round_begin)
		ExecutionTime.each_round_over:
			reparent(buff_manager.each_round_over)
		ExecutionTime.each_time:
			reparent(buff_manager.each_time)
		ExecutionTime.each_project_delivery:
			reparent(buff_manager.each_project_delivery)
		
			
func die():
	queue_free()
