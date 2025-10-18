extends CanvasLayer
class_name ComputerScene

@onready var store_scene: Control = $StoreScene
@onready var property_manager: Node = $PropertyManager
@onready var browser_scene: Node = $BrowserScene
@export var unused_hand : Node
@export var debug_hand: Node
@export var activity_hand : Node
@export var calendar_scene : Node
@export var company_scene : Node


var current_date := 0

func _ready() -> void:
	print("这是测试版，正式版需要修改computer scene的_ready的visible修改")
	visible = true

func time_goes_by(n : int):
	current_date += n
	
