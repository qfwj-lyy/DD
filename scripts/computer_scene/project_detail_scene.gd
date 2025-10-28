extends Control

var displayed_project
var project_button
@export var project_name_label: Node
@export var initial_progress_label: Node
@export var initial_bug_amount_label: Node
@export var bug_amount_limit_label: Node
@export var initial_money_label: Node
@export var initial_mood_label: Node
@export var initial_skill_label: Node
@export var description_label: Node
@export var deposit_reward_label : Node
@export var accept_task_icon : TextureRect
@export var reject_task_icon : TextureRect
@export var project_icon : TextureRect

func set_project_information(project : Project , level):
	displayed_project = project
	project_icon.texture = project.icon
	project_name_label.text = "项目名称：" + project.project_name
	initial_progress_label.text = "项目初始进度：" + str(int(project.initial_progress))
	initial_bug_amount_label.text = "项目初始bug数：" + str(int(project.initial_bug_amount))
	bug_amount_limit_label.text = "用户对bug的忍耐度：" + str(int(project.bug_amount_limit))
	initial_money_label.text = "初始资金：" + str(int(project.initial_money))
	initial_mood_label.text = "参与意向：" + str(int(project.initial_mood))
	initial_skill_label.text = "项目内容熟练度：" + str(int(project.initial_skill))
	deposit_reward_label.text = "项目总收入：" + str(int(project.deposit_reward))
	description_label.text = project.description
	match level:
		"LOW":
			pass
		"MID":
			pass
		"HIGH":
			pass
	
func _on_project_button_pressed() -> void:
	choose_project()

func choose_project():
	if G.P.has_project:
		printerr("in project_detail_scene choose_project()")
		return
	project_button.clear()
	
	var p : Project = displayed_project
	project_icon.texture = p.icon
	
	G.P.set_current_project(p)
	G.P.set_money(p.initial_money)
	G.P.set_mood(p.initial_mood)
	G.P.set_skill(p.initial_skill)
	G.P.set_project_progress(p.initial_progress)
	G.P.set_bug_amount(p.initial_bug_amount)
	G.P.set_bug_limit(p.bug_amount_limit)
	G.P.set_bug_rate(p.initial_bug_rate)
	
	
	G.D.display_sentence("接下来就是把项目进度推到100了，好好干，以后年薪百万不是梦啊")
	for buff_resource in p.initial_buffs:
		var buff_node = buff_resource.instantiate()
		add_child(buff_node)
		buff_node.reparent_to_buff_manager()
		
	
	queue_free()


func _on_reject_task_icon_gui_input(event: InputEvent) -> void:
	if event.is_action_released("LeftMouseDown"):
		queue_free()
