extends Panel

var command : String
var parameter : String

@onready var command_edit: TextEdit = $CommandEdit
@onready var parameter_edit: TextEdit = $ParameterEdit

#region 打开 GM 控制台
func _ready() -> void:
	visible = false
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("OpenGMMode"):
		if not visible:
			G.M.change_main_scene(self , false , false , false)
		else:
			G.M.return_last_main_scene(false , false)
#endregion

func _on_enter_dialogue_pressed() -> void:
	G.enter_dialogue(parameter)


func _on_parameter_edit_text_changed() -> void:
	parameter = parameter_edit.text
func _on_command_edit_text_changed() -> void:
	command = command_edit.text

func _on_execute_button_pressed() -> void:
	match command:
		"add_project_progress":
			G.P.add_project_progress(int(parameter))
		"add_bug_amount":
			G.P.add_bug_amount(int(parameter))
		"add_bug_limit":
			G.P.add_bug_limit(int(parameter))
		"add_bug_rate":
			G.P.add_bug_rate(int(parameter))
		"add_deposit_amount":
			G.P.add_deposit_amount(int(parameter))
		"add_hand_card_amount_limit":
			G.P.add_hand_card_amount_limit(int(parameter))
		"add_money":
			G.P.add_money(int(parameter))
		_:
			printerr("错误！未知命令")
			G.play_sound("illegal_operation")
