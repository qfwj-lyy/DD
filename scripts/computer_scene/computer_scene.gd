extends CanvasLayer
class_name ComputerScene


var property_manager : PropertyManager
@onready var browser_scene: Node = $BrowserScene
@export var unused_hand : Node
@export var debug_hand: Node
@export var activity_hand : Node
@export var calendar_scene : Calender
@export var company_scene : Node
@export var mandatory_guide : Node
@export var store_scene : Node

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
	var p : Project = p_node.displayed_project
	G.P.set_current_project(p)
	G.P.set_money(p.initial_money)
	G.P.set_mood(p.initial_mood)
	G.P.set_skill(p.initial_skill)
	G.P.set_project_progress(p.initial_progress)
	G.P.set_bug_amount(p.initial_bug_amount)
	G.P.set_bug_limit(p.bug_amount_limit)
	G.P.set_bug_rate(p.initial_bug_rate)
	
	
	for buff_resource in p.initial_buffs:
		var buff_node = buff_resource.instantiate()
		add_child(buff_node)
		buff_node.reparent_to_buff_manager()
		
	p_node.queue_free()
