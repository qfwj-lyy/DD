extends Button
@onready var calender_button_anim: AnimationPlayer = $CalenderButtonAnim
@onready var calender_button_border: TextureRect = $CalenderButtonBorder

func _ready() -> void:
	calender_button_border.visible = false


func _on_mouse_entered() -> void:
	calender_button_anim.play("hover")


func _on_mouse_exited() -> void:
	calender_button_anim.play("hover_over")
