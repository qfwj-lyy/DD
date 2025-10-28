extends TextureRect

@export var buff_description : Node
@export var description_label : Label

	
func set_icon(b : Buff):
	description_label.text = b.description
	buff_description.reparent(G.P)
	texture = b.icon
	show()
	
func _ready() -> void:
	buff_description.hide()
func _on_mouse_entered() -> void:
	buff_description.show()
func _on_mouse_exited() -> void:
	buff_description.hide()
