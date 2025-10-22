extends CanvasLayer
class_name ComputerScene

@onready var store_scene: Control = $StoreScene
@onready var property_manager: Node = $PropertyManager
@onready var browser_scene: Node = $BrowserScene
@export var unused_hand : Node
@export var debug_hand: Node
@export var activity_hand : Node
@export var calendar_scene : Calender
@export var company_scene : Node
@export var mandatory_guide : Node


var current_date := 0

func _ready() -> void:
	visible = true

func time_goes_by(n : int):
	current_date += n
	
func choose_project(p_node : Node):
	if property_manager.current_project:
		p_node.queue_free()
		pass
		pass
		return
	var p = p_node.displayed_project
	property_manager.set_current_project(p)
	property_manager.set_money(p.initial_money)
	property_manager.set_mood(p.initial_mood)
	property_manager.set_skill(p.initial_skill)
	property_manager.set_project_progress(p.initial_progress)
	property_manager.set_bug_amount(p.initial_bug_amount)
	
	for buff_resource in p.initial_buffs:
		var buff_node = buff_resource.instantiate()
		add_child(buff_node)
		buff_node.reparent_to_buff_manager()
		
	p_node.queue_free()
