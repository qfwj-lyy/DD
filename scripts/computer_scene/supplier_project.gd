extends Button

@onready var project_name: Label = $ProjectName


func _ready() -> void:
	connect("pressed" , _on_pressed)
	
func _on_pressed():
	pass
