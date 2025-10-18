extends Control
class_name Employee

@export var joining_expenditure : int
@export var severance_pay : int
@export var wage : int
@export var pay_interval_days : int


@export_multiline var description : String


@onready var buffs: Node = $Buffs
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
			print("点击到商店里的应聘者")
			if G.M.current_scene.company_scene.current_staff_amount >= G.M.current_scene.company_scene.staff_amount_limit:
				print("员工数量达到上限")
				return
			if property.use_money(joining_expenditure):
				G.M.current_scene.company_scene.get_staff(self)
				condition = Condition.at_company
				execute()
			else:
				print("没钱呢")
				pass
				pass
				return
				
		elif condition == Condition.at_company:
			G.M.current_scene.company_scene.select_employee(self)

func be_fired():
	G.M.current_scene.property_manager.add_money( - severance_pay)
	queue_free()
