extends CanvasLayer
class_name ComputerScene

@onready var store_scene: Control = $StoreScene
@onready var property_manager: Node = $PropertyManager
@onready var browser_scene: Node = $BrowserScene
@export var unused_hand : Node
@export var debug_hand: Node
@export var activity_hand : Node
@export var calendar_scene : Node

func _ready() -> void:
	print("这是测试版，正式版需要修改computer scene的_ready的visible修改")
	visible = true
