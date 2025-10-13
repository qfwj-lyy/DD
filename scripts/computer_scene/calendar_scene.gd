extends Control

@export var computer_scene: ComputerScene
@export var debug_hand: Control
@export var activity_hand: Control


func execute_plan():
	for card in debug_hand.get_children():
		card.execute()
	for card in activity_hand.get_children():
		card.execute()
	
	
	
func _on_execute_plan_button_pressed() -> void:
	pass
	pass
	execute_plan()
