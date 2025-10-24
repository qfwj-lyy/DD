extends Panel


func _ready() -> void:
	var p = load("res://data/projects/quan_min_da_fei_ji_you_xi_kai_fa.tres")
	set_mandatory_project(p)
	browse_web("project_web_0")

func clear():
	for supplier in get_children():
		supplier.clear()

func set_mandatory_project(p : Project):
	get_node("SupplierIcon0").set_mandatory_project(p)
	

#var mandatory_projects := []
func browse_web(web_name : String):
	clear()
	var web : ProjectWeb = load("res://data/project_webs/" + web_name + ".tres")
	#var array = Array()
	#array.resize( web.suppliers.size() )
	#array.fill(false)
	#var t := mandatory_projects.size()
	#while(1):
		#var r = randi_range(0 , web.suppliers.size() - 1)
		#if array[r]:
			#continue
		#array[r] = true
		#t += 1
		#if t >= 3:
			#break
	#
	#for i in 3:
		#var s_name := "SupplierIcon"
		#var index := -1
		#s_name += str(i)
		#for p_name in mandatory_projects:
			#load()
			#get_node(s_name).browse_supplier()
		#for j in array.size():
			#if array[j]:
				#array[j] = false
				#index = j
				#break
		#
		#get_node(s_name).browse_supplier(web.suppliers[index])
	for i in 3:
		var s_name := "SupplierIcon"
		s_name += str(i)
		get_node(s_name).browse_supplier(web.suppliers[i])
