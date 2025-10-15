extends Control

@onready var cards: HBoxContainer = $Cards

var store_content : StoreContent
var store_cards : Array
var refresh_time_flag := 3

func load_card(card_name : String):
	var path = "res://scenes/computer_scene/cards/" + card_name + ".tscn"
	var card = load(path).instantiate()
	cards.add_child(card)
	card.position = Vector2(100,0)
	
func _ready() -> void:
	await get_tree().create_timer(1).timeout
	
	store_content = load("res://data/store_content/normal_store_content.tres")
	store_cards = store_content.normal_cards
	
	#refresh_cards()
	
func refresh_cards():
	for c in cards.get_children():
		c.free()
	var card_amount := 0
	while(1):
		var weight_sum := 0
		for c : StoreCardParameter in store_cards:
			weight_sum += c.weight
		var rand_weight_position = randi_range(1 , weight_sum)
		var current_weight_sum := 0
		for c : StoreCardParameter in store_cards:
			current_weight_sum += c.weight
			if current_weight_sum >= rand_weight_position:
				load_card(c.name)
				if c.is_unique:
					store_cards.erase(c)
				break
		card_amount += 1
		if card_amount >= 3:
			break
		
func _on_refresh_cards_pressed() -> void:
	# 需要花钱
	if G.M.current_scene.property_manager.money_amount >= 3:
		G.M.current_scene.property_manager.money_amount -= 3
		refresh_cards()
	else:
		pass
		pass
	
func time_goes_by(t : int):
	refresh_time_flag -= t
	if refresh_time_flag <= 0:
		refresh_time_flag = 3
		refresh_cards()
