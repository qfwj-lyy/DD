extends Control
class_name DialogueManager

@export_group("UI")
#@export var character_name_Label = Label
@export var text_label = Label
#@export var left_avater : TextureRect
#@export var right_avater : TextureRect


var dialogue_segment : DialogueSegment

var index := 0

var typer : Tween

func _append_character(character : String):
	text_label.text += character
func display_next_scene() ->void:
	if index >= len(dialogue_segment.dialogue_scenes):
		clear()
		return
	
	var dialogue_scene = dialogue_segment.dialogue_scenes[index]
	
	if typer and typer.is_running():
		typer.kill()
		G.kill_sound("typing")
		text_label.text = dialogue_scene.text
		index += 1
		return
	
	
	#character_name_Label.text = dialogue_scene.character_name
	
	typer = get_tree().create_tween()
	typer.connect("finished", G.kill_sound.bind("typing"))
	text_label.text = ""
	G.play_sound("typing" , 0 , randf_range(0 , 7))
	for character in dialogue_scene.text :
		typer.tween_callback(_append_character.bind(character)).set_delay(0.05)
	typer.tween_callback(func(): index += 1)

	#if dialogue_scene.show_on_left:
		#left_avater.texture = dialogue_scene.avatar
		#right_avater.texture = null
	#else:
		#left_avater.texture = null
		#right_avater.texture = dialogue_scene.avatar

#func _on_panel_gui_input(event: InputEvent) -> void:
	#if event is InputEventMouseButton:
		#if event.button_index == MOUSE_BUTTON_LEFT:
			#if event.pressed:
				#display_next_dialogue()

func display_dialogue_segment(ds_name : String):
	clear()
	var ds = load("res://data/dialogue_segment/"+ds_name+".tres")
	visible = true
	dialogue_segment = ds
	display_next_scene()

func display_sentence(s : String):
	if typer and typer.is_running():
		typer.kill()
		G.kill_sound("typing")
	var d_segment = DialogueSegment.new()
	var d_scene = DialogueScene.new()
	d_scene.text = s
	d_segment.dialogue_scenes.append(d_scene)
	clear()
	visible = true
	dialogue_segment = d_segment
	display_next_scene()

func clear():
	visible = false
	dialogue_segment = null
	text_label.text = ""
	index = 0
	typer = null

func _on_next_scene_input_region_gui_input(event: InputEvent) -> void:
	if event.is_action_released("LeftMouseDown"):
		display_next_scene()

func _ready() -> void:
	G.D = self
	
