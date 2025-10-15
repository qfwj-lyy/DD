extends Control
class_name Card

@export var money : int = 0
@export var mood : int = 0
@export var time : int = 0
@export var progress : int = 0
@export var bug : int = 0
@export var skill : int = 0

@export_multiline var description : String


@onready var buffs: Node = $Buffs

enum Condition{
	at_store,
	at_unused_hand,
	at_used_hand
}
var condition := Condition.at_store

var property : PropertyManager = G.M.current_scene.property_manager

func execute():
	property.add_mood(mood)
	property.add_time(time)
	property.add_project_progress(progress)
	property.add_bug_amount(bug)
	property.add_skill(skill)
	
	execute_effect()
	
	for buff : Buff in buffs.get_children():
		buff.reparent_to_buff_manager()

func execute_effect():
	pass



func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("LeftMouseDown"):
		if condition == Condition.at_store:
			if G.M.current_scene.calendar_scene.get_hand_cards_amount() >= 8:
				print("卡片超出手牌上限")
				return
			if property.use_money(money):
				reparent(G.M.current_scene.unused_hand)
				condition = Condition.at_unused_hand
			else:
				print("没钱呢")
				pass
				pass
				return
				
		elif condition == Condition.at_unused_hand:
			if self is DebugCard:
				reparent(G.M.current_scene.debug_hand)
			elif self is ActivityCard:
				reparent(G.M.current_scene.activity_hand)
			condition = Condition.at_used_hand
		elif condition == Condition.at_used_hand:
			reparent(G.M.current_scene.unused_hand)
			condition = Condition.at_unused_hand

#region 测试用
@onready var label: Label = $Label
func _ready() -> void:
	label.text = description
#endregion
