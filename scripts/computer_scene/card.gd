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

signal execute_over

func execute() -> Signal :
	G.play_sound("execute", 10 ,0)
	property.add_mood(mood)
	property.add_time(time)
	property.add_project_progress(progress)
	property.add_bug_amount(bug)
	property.add_skill(skill)
	
	execute_effect()
	
	for buff : Buff in buffs.get_children():
		buff.reparent_to_buff_manager()
	
	if time != 0:
		for i in range(time):
			card_anim.play("execute")
			await card_anim.animation_finished
	
	execute_over.emit()
	return execute_over

func execute_effect():
	pass



func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("LeftMouseDown"):
		if condition == Condition.at_store:
			if G.M.current_scene.calendar_scene.get_hand_cards_amount() >= G.P.hand_card_amount_limit:
				G.play_sound("illegal_operation")
				G.D.display_sentence("手牌数量超出手牌上限了")
				return
			if property.use_money(money):
				reparent(G.M.current_scene.unused_hand)
				condition = Condition.at_unused_hand
			else:
				G.play_sound("illegal_operation")
				G.D.display_sentence("钱不够")
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


#region 悬停动画区

@onready var card_anim: AnimationPlayer = $CardAnim
@onready var border: TextureRect = $Border

var mouse_in : bool = false

func _on_area_2d_mouse_entered() -> void:
	mouse_in = true
	card_anim.play("hover")
	border.visible = true
	

func _on_area_2d_mouse_exited() -> void:
	mouse_in = false
	card_anim.play("hover_over")
	border.visible = false

#endregion
