extends Button

@onready var project_name_label : Label = $ProjectNameLabel

var project : Project


func _ready() -> void:
	connect("pressed" , _on_pressed)

	
func _on_pressed():
	open_project_detail()

func open_project_detail():
	var project_detail_scene = load("res://scenes/computer_scene/browser_scene/project_detail_scene.tscn").instantiate()
	project_detail_scene.set_project_information(project)
	G.M.current_scene.add_child(project_detail_scene)

func set_project(p : Project):
	project_name_label.text = p.project_name
	project = p

func clear():
	project_name_label.text = ""
	project = null
	
