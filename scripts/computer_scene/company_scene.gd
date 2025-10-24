extends Panel

var staff_amount_limit := 3
var current_staff_amount := 0
var selected_employee : Employee

var employee_content : EmployeeContent


@onready var company_description_label: Label = $CompanyDescription/CompanyDescriptionLabel


func _ready() -> void:
	visible = false
	employee_content = load("res://data/employ_content/employ_content_0.tres")
	
	
func select_employee(e : Employee):
	selected_employee = e
	company_description_label.text = e.description

func get_staff(e : Employee):
	for i in 3:
		var staff_node = get_node("Staff" + str(i))
		if staff_node.get_child_count():
			continue
		e.reparent(staff_node)
		e.position = Vector2(0 , 0)
		e.joining_date = G.M.current_scene.current_date
		current_staff_amount += 1
		break
	
	
func load_employee(e_name : String):
	var path = "res://scenes/computer_scene/employees/" + e_name + ".tscn"
	var e = load(path).instantiate()
	for i in 5:
		var e_node = get_node("Employee" + str(i))
		if e_node.get_child_count():
			continue
		e_node.add_child(e)
		break
	

func refresh_employees():
	for i in 5:
		var e_node = get_node("Employee" + str(i))
		for j in e_node.get_children():
			j.free()
	var employee_amount := 0
	while(1):
		var weight_sum := 0
		for e : EmployeeParameter in employee_content.normal_employees:
			weight_sum += e.weight
		var rand_weight_position = randi_range(1 , weight_sum)
		var current_weight_sum := 0
		for e : EmployeeParameter in employee_content.normal_employees:
			current_weight_sum += e.weight
			if current_weight_sum >= rand_weight_position:
				load_employee(e.name)
				if e.is_unique:
					employee_content.erase(e)
				break
		employee_amount += 1
		if employee_amount >= 5:
			break


#func _on_exit_company_pressed() -> void:
#	visible = false


#func _on_refresh_employee_pressed() -> void:
#	pass
#	pass
#	refresh_employees()


func inspect_wage():
	for i in 3:
		var staff_node = get_node("Staff" + str(i))
		if staff_node.get_child_count():
			var staff = staff_node.get_child(0)
			if staff:
				if (G.M.current_scene.current_date - staff.joining_date) % staff.pay_interval_days == 0:
					if not G.M.current_scene.property_manager.use_money(staff.wage):
						staff.be_fired()


@onready var company_self_anim: AnimationPlayer = $CompanySelfAnim

#region 退出

@onready var exit_company_anim: AnimationPlayer = $ExitCompany/ExitCompanyAnim

func _on_exit_company_button_down() -> void:
	exit_company_anim.play("button_down")


func _on_exit_company_button_up() -> void:
	exit_company_anim.play("button_up")
	company_self_anim.play("close")

#endregion

#region 刷新

@onready var refresh_anim: AnimationPlayer = $RefreshEmployee/refreshAnim

func _on_refresh_employee_button_down() -> void:
	refresh_anim.play("button_down")

func _on_refresh_employee_button_up() -> void:
	refresh_anim.play("button_up")
	if G.P.use_money(3):
		refresh_employees()
	else:
		G.play_sound("illegal_operation")
		G.D.display_sentence("需要3资金来刷新人才市场")

#endregion

#region 解雇

@onready var fire_anim: AnimationPlayer = $FireStaff/FireAnim

func _on_fire_staff_button_down() -> void:
	fire_anim.play("button_down")

func _on_fire_staff_button_up() -> void:
	fire_anim.play("button_up")
	if selected_employee:
		if selected_employee.condition == Employee.Condition.at_store:
			G.play_sound("illegal_operation")
			G.D.display_sentence("不能开除还没有入职的员工")
			return
		if G.P.money_amount >= selected_employee.severance_pay:
			selected_employee.be_fired()
			current_staff_amount -= 1
			pass
			pass
		else:
			G.play_sound("illegal_operation")
			G.D.display_sentence("没钱支付离职金")
	else:
		G.play_sound("illegal_operation")
		G.D.display_sentence("请先选中一个员工")

#endregion
