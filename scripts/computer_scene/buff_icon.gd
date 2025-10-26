extends TextureRect

@export var buff_description : Node
@export var description_label : Label
func set_description(d : String):
	description_label.text = d
	buff_description.reparent(G.P)
	show()
func _ready() -> void:
	buff_description.hide()
func _on_mouse_entered() -> void:
	buff_description.show()
func _on_mouse_exited() -> void:
	buff_description.hide()
