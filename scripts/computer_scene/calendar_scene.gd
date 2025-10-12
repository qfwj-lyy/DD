extends Control

@export var computer_scene: ComputerScene
@export var debug_hand: Control
@export var activity_hand: Control


func execute_plan():
	computer_scene.property_manager.add_project_progress(5)
	computer_scene.property_manager.add_bug_number(5)
	computer_scene.property_manager.add_money(5)
	
	for card in debug_hand.get_children():
		card.execute()
	for card in activity_hand.get_children():
		card.execute()
	
	
	
func _on_execute_plan_button_pressed() -> void:
	pass
	pass
	execute_plan()
