extends Panel

func _ready() -> void:
	browse_web("project_web_0")

func clear():
	for supplier in get_children():
		supplier.clear()

func browse_web(web_name : String):
	clear()
	var web : ProjectWeb = load("res://assets/project_webs/" + web_name + ".tres")
	var array = Array()
	array.resize( web.suppliers.size() )
	array.fill(false)
	var t := 0
	while(1):
		var r = randi_range(0 , web.suppliers.size() - 1)
		if array[r]:
			continue
		array[r] = true
		t += 1
		if t >= 3:
			break
	var s_name := "SupplierIcon"
	for i in 3:
		var index := 0
		for j in array:
			if array[j]:
				array[j] = false
				index = j
				break
		s_name += str(i)
		get_node(s_name).browse_supplier(web.suppliers[index])
