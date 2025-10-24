extends Control
class_name Employee

@export var joining_expenditure : int
@export var severance_pay : int
@export var wage : int
@export var pay_interval_days : int


@export_multiline var description : String


@onready var buffs: Node = $Buffs

var self_buffs : Array[Buff]

var joining_date : int


enum Condition{
	at_store,
	at_company
}
var condition := Condition.at_store

var property : PropertyManager = G.M.current_scene.property_manager


func execute():
	execute_effect()
	
	for buff : Buff in buffs.get_children():
		self_buffs.append(buff)
		buff.reparent_to_buff_manager()

func execute_effect():
	pass


#region 测试用
@onready var label: Label = $Label
func _ready() -> void:
	label.text = description
#endregion


func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("LeftMouseDown"):
		if condition == Condition.at_store:
			if G.M.current_scene.company_scene.current_staff_amount >= G.M.current_scene.company_scene.staff_amount_limit:
				G.play_sound("illegal_operation")
				G.D.display_sentence("员工数量达到上限啦！")
				return
			if property.use_money(joining_expenditure):
				G.D.display_sentence("面相这么好，技术肯定不会差")
				G.M.current_scene.company_scene.get_staff(self)
				condition = Condition.at_company
				execute()
			else:
				G.play_sound("illegal_operation")
				G.D.display_sentence("没有足够的资金招募该员工")
				return
				
		elif condition == Condition.at_company:
			G.M.current_scene.company_scene.select_employee(self)

func be_fired():
	G.P.add_money( - severance_pay)
	for buff : Buff in self_buffs:
		if is_instance_valid(buff):
			buff.die()
	queue_free()
