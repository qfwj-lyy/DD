extends TextureRect

@export var buff_description : Node
@export var description_label : Node
func set_description(d : String):
	description_label.text = d
	show()
func _ready() -> void:
	buff_description.hide()
func _on_mouse_entered() -> void:
	buff_description.show()
func _on_mouse_exited() -> void:
	buff_description.hide()
