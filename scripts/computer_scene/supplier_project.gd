extends Button

@onready var project_name_label : Label = $ProjectNameLabel

var project : Project

@export var project_border: TextureRect

@export var project_border_anim: AnimationPlayer

func _ready() -> void:
	#connect("pressed" , _on_pressed)
	connect("button_down" , _on_button_down )
	connect("button_up" , _on_button_up)
	if project_border :
		project_border.visible = false

	
#func _on_pressed():
	#open_project_detail()

func _on_button_down():
	if project_border_anim :
		project_border_anim.play("button_down")

func _on_button_up():
	if project_border_anim :
		project_border_anim.play("button_up")
	if project:
		open_project_detail()

func open_project_detail():
	if G.P.has_project:
		G.play_sound("illegal_operation")
		G.D.display_sentence("我还是不要同时做多个项目吧")
		return
	var project_detail_scene = load("res://scenes/computer_scene/browser_scene/project_detail_scene.tscn").instantiate()
	project_detail_scene.set_project_information(project)
	project_detail_scene.project_button = self
	G.M.current_scene.add_child(project_detail_scene)

func set_project(p : Project):
	project_name_label.text = p.project_name
	project = p

func clear():
	project_name_label.text = ""
	project = null
	



func _on_mouse_entered() -> void:
	if project_border_anim :
		project_border_anim.play("hover")


func _on_mouse_exited() -> void:
	if project_border_anim :
		project_border_anim.play("hover_over")
