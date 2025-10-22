extends Panel

var card_count : int = 0

var card_width : float = 150
var self_width : float = 0

func _ready() -> void:
	self_width = self.size.x

func _on_child_entered_tree(node: Node) -> void:
	card_count += 1
	if card_width * card_count > self_width:
		call_deferred("reset_all_position")
	else:
		call_deferred("reset_card_position",node)


func _on_child_exiting_tree(node: Node) -> void:
	card_count -= 1
	if card_width * card_count > self_width:
		call_deferred("reset_all_position")
	else:
		call_deferred("leave_reset")

func reset_all_position():
	for i in range(card_count) :
		var current_card : Card = get_child(i)
		slide_to(current_card ,Vector2( global_position.x + i * self_width / card_count , self.global_position.y))
		#current_card.position.x = i * self_width / card_count
		#current_card.global_position.y = self.global_position.y

func reset_card_position(card : Card) :
	slide_to(card , Vector2(self.global_position.x + (card_count-1) * card_width , self.global_position.y) )
	#card.position.x = (card_count-1) * card_width
	#card.global_position.y = self.global_position.y

func leave_reset():
	for i in range(card_count) :
		var current_card : Card = get_child(i)
		slide_to(current_card , Vector2(self.global_position.x + i * card_width , self.global_position.y))
		#current_card.position.x = i * card_width
		#current_card.global_position.y = self.global_position.y

func slide_to(target : Card , end_position : Vector2) :
	var tween := target.create_tween()
	tween.tween_property(target,"global_position",end_position,0.2)\
	.set_trans(Tween.TRANS_QUAD)\
	.set_ease(Tween.EASE_OUT)
