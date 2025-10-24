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
	
	var card : Card = load("res://scenes/computer_scene/cards/duan_dian_tiao_shi.tscn").instantiate()
	card.condition = Card.Condition.at_unused_hand
	unused_hand.add_child(card)
	
	card = load("res://scenes/computer_scene/cards/code.tscn").instantiate()
	card.condition = Card.Condition.at_unused_hand
	unused_hand.add_child(card)
	
	card = load("res://scenes/computer_scene/cards/hua_ya_sui_qian.tscn").instantiate()
	card.condition = Card.Condition.at_unused_hand
	unused_hand.add_child(card)
	
	card = load("res://scenes/computer_scene/cards/xian_zhi.tscn").instantiate()
	card.condition = Card.Condition.at_unused_hand
	unused_hand.add_child(card)
	
	await get_tree().create_timer(0.2).timeout
	unused_hand.reset_all_position()
	
	G.D.display_sentence("我应该去网上接个项目做...浏览器在哪里来着？")

func time_goes_by(n : int):
	current_date += n
	
