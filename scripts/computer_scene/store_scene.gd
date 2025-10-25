extends Control



var store_content : StoreContent
var store_card_content : Array
@export var store_cards : Node
var refresh_time_flag := 3
@export var description_label : Node

func load_card(card_name : String):
	var path = "res://scenes/computer_scene/cards/" + card_name + ".tscn"
	var card = load(path).instantiate()
	var card_sum = store_cards.get_child_count()
	card.position = Vector2(card_sum * 150 + (card_sum - 1) * 40 + 40 , 0)
	store_cards.add_child(card)
	
func _ready() -> void:
	visible = true
	
	
var can_get_ai_and_party := false
func refresh_cards():
	for c in store_cards.get_children():
		c.free()
	var card_amount := 0
	while(1):
		var weight_sum := 0
		for c : StoreCardParameter in store_card_content:
			weight_sum += c.weight
		var rand_weight_position = randi_range(1 , weight_sum)
		var current_weight_sum := 0
		var need_updating_rand := false
		for c : StoreCardParameter in store_card_content:
			current_weight_sum += c.weight
			if current_weight_sum >= rand_weight_position:
				if not can_get_ai_and_party:
					if c.is_ai_or_party:
						need_updating_rand = true
						break
				load_card(c.name)
				if c.is_unique:
					store_card_content.erase(c)
				break
		if need_updating_rand:
			continue
		card_amount += 1
		if card_amount >= 5:
			break
		
	
func time_goes_by(t : int):
	refresh_time_flag -= t
	if refresh_time_flag <= 0:
		refresh_time_flag = 3
		refresh_cards()


@onready var refresh_anim: AnimationPlayer = $RefreshCards/RefreshAnim

func _on_refresh_cards_button_down() -> void:
	refresh_anim.play("button_down")

func _on_refresh_cards_button_up() -> void:
	refresh_anim.play("button_up")
	# 需要花钱
	if G.P.use_money(3):
		refresh_cards()
	else:
		G.play_sound("illegal_operation")
		G.D.display_sentence("刷新商店需要3资金")

func show_card_description(d : String):
	description_label.text = d
	
