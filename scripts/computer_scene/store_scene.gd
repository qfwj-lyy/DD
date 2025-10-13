extends Control

@onready var cards: HBoxContainer = $Cards


func load_card(card_name : String):
	var path = "res://scenes/computer_scene/cards/" + card_name + ".tscn"
	var card = load(path).instantiate()
	cards.add_child(card)
	card.position = Vector2(100,0)
	
func _ready() -> void:
	await get_tree().create_timer(1).timeout
	load_card("code")
