extends Panel

var staff_amount_limit := 3
var current_staff_amount := 0
var selected_employee : Employee

var employee_content : EmployeeContent




func _ready() -> void:
	visible = false
	employee_content = load("res://data/employ_content/employ_content_0.tres")
	
	
func select_employee(e : Employee):
	selected_employee = e

func get_staff(e : Employee):
	for i in 3:
		var staff_node = get_node("Staff" + str(i))
		if staff_node.get_child_count():
			continue
		e.reparent(staff_node)
		e.position = Vector2(0 , 0)
		e.joining_date = G.M.current_scene.current_date
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
			j.queue_free()
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

func _on_fire_staff_pressed() -> void:
	if selected_employee:
		if G.M.current_scene.property_manager.use_money(selected_employee.severance_pay):
			selected_employee.queue_free()
			pass
			pass
		else:
			print("没钱支付离职金")
	else:
		print("请先选中一个员工")

func _on_exit_company_pressed() -> void:
	visible = false


func _on_refresh_employee_pressed() -> void:
	pass
	pass
	refresh_employees()


func inspect_wage():
	for i in 3:
		var staff_node = get_node("Staff" + str(i))
		if staff_node.get_child_count():
			var staff = staff_node.get_child(0)
			if staff:
				if (G.M.current_scene.current_date - staff.joining_date) % staff.pay_interval_days == 0:
					if not G.M.current_scene.property_manager.use_money(staff.wage):
						staff.be_fired()
