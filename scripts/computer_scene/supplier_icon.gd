extends Panel

var s : ProjectSupplier

func _ready() -> void:
	pass

#region 设置project
var mandatory_projects := []
func set_mandatory_project(p : Project):
	mandatory_projects.append(p)
	
var display_project_limit := 3
func browse_supplier(ps : ProjectSupplier):
	s = ps
	var display_project_amount := 0
	while(1):
		var p
		if mandatory_projects.size():
			p = mandatory_projects[0]
			mandatory_projects.pop_front()
		else:
			while (1):
				p = s.projects[randi_range(0 , s.projects.size() - 1)]
				s.projects.erase(p)
				var flag := false
				for i in 3:
					if get_node("SupplierProject" + str(i)).project:
						if get_node("SupplierProject" + str(i)).project.project_name == p.project_name:
							flag = true
							break
				if flag == false:
					break
		
		var p_node = get_node("SupplierProject" + str(display_project_amount))
		p_node.set_project(p , s.project_level)
		
		display_project_amount += 1
		if s.projects.size() <= 0:
			break
		if display_project_amount >= display_project_limit:
			break
#endregion
	
func clear():
	for i in 3:
		var p_name = "SupplierProject" + str(i)
		get_node(p_name).clear()
