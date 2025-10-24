extends Control

@onready var computer_scene: ComputerScene = $".."
@onready var setting_anim: AnimationPlayer = $OpenSetting/SettingAnim
@onready var browser_anim: AnimationPlayer = $OpenBrowser/BrowserAnim
@onready var calender_anim: AnimationPlayer = $OpenCalendar/CalenderAnim
@onready var company_anim: AnimationPlayer = $OpenCompany/CompanyAnim


func _ready() -> void:
	visible = true
	


#func _on_open_setting_pressed() -> void:
#	var setting_scene = load("res://scenes/setting_scene.tscn").instantiate()
#	G.M.change_main_scene(setting_scene , false , false , true)

#func _on_open_calendar_pressed() -> void:
#	computer_scene.calendar_scene.visible = true

#func _on_open_browser_pressed() -> void:
#	computer_scene.browser_scene.visible = true

#func _on_open_company_pressed() -> void:
#	computer_scene.company_scene.visible = true
	


func _on_open_setting_button_down() -> void:
	setting_anim.play("button_down")


func _on_open_setting_button_up() -> void:
	setting_anim.play("button_up")
	var setting_scene = load("res://scenes/setting_scene.tscn").instantiate()
	G.M.add_child(setting_scene)
#region 浏览器动画

@onready var browser_self_anim: AnimationPlayer = $"../BrowserScene/BrowserSelfAnim"

func _on_open_browser_button_down() -> void:
	browser_anim.play("button_down")
var _is_browser_first_open := true
func _on_open_browser_button_up() -> void:
	browser_anim.play("button_up")
	browser_self_anim.play("open")
	computer_scene.browser_scene.visible = true
	if _is_browser_first_open:
		_is_browser_first_open = false
		G.D.display_dialogue_segment("wan_jia_chu_ci_da_kai_liu_lan_qi")
		
#endregion

#region 日历

@onready var calender_self_anim: AnimationPlayer = $"../CalendarScene/CalenderSelfAnim"
func _on_open_calendar_button_down() -> void:
	calender_anim.play("button_down")

func _on_open_calendar_button_up() -> void:
	calender_anim.play("button_up")
	calender_self_anim.play("open")
	computer_scene.calendar_scene.is_open = true
	G.D.display_sentence("接下来干点啥好呢")
	#computer_scene.calendar_scene.visible = true #这里需要优化一下

#endregion

#region 公司
@onready var company_self_anim: AnimationPlayer = $"../CompanyScene/CompanySelfAnim"

func _on_open_company_button_down() -> void:
	company_anim.play("button_down")
var _is_company_first_open := true
func _on_open_company_button_up() -> void:
	company_anim.play("button_up")
	company_self_anim.play("open")
	computer_scene.company_scene.visible = true
	if _is_company_first_open:
		_is_company_first_open = false
		G.D.display_dialogue_segment("wan_jia_chu_ci_da_kai_zu_zhi")
#endregion
