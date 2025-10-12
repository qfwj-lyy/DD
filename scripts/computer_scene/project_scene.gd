extends Control

var displayed_project
@export var project_name_label: Node
@export var initial_progress_label: Node
@export var initial_bug_amount_label: Node
@export var bug_amount_limit_label: Node
@export var initial_money_label: Node
@export var initial_mood_label: Node
@export var initial_skill_label: Node

signal click_project(p)

func _ready() -> void:
	connect("click_project" , get_parent().choose_project )

func set_project_information(project : Project):
	displayed_project = project
	project_name_label.text = "项目名称：" + project.project_name
	initial_progress_label.text = "项目初始进度：" + str(project.initial_progress)
	initial_bug_amount_label.text = "项目初始bug数：" + str(project.initial_bug_amount)
	bug_amount_limit_label.text = "用户对bug的忍耐度" + str(project.bug_amount_limit)
	initial_money_label.text = "初始资金：" + str(project.initial_money)
	initial_mood_label.text = "参与意向" + str(project.initial_mood)
	initial_skill_label.text = "项目内容熟练度" + str(project.initial_skill)


func _on_project_button_pressed() -> void:
	emit_signal("click_project" , displayed_project)
