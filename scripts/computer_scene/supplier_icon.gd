extends Panel



func _ready() -> void:
	pass

var display_project_limit := 3
func browse_supplier(s : ProjectSupplier):
	var display_project_amount := 0
	while(1):
		var rand_project = s.projects[randi_range(0 , s.projects.size() - 1)]
		var p_node = get_node("SupplierProject" + str(display_project_amount))
		p_node.set_project(rand_project)
		s.projects.erase(rand_project)
		display_project_amount += 1
		if s.projects.size() <= 0:
			break
		if display_project_amount >= display_project_limit:
			break

	
func clear():
	pass
