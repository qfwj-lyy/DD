extends Button

@onready var calender_anim: AnimationPlayer = $CalenderAnim
@onready var calender_border: TextureRect = $CalenderBorder

func _ready() -> void:
	calender_border.visible = false

func _on_mouse_entered() -> void:
	calender_anim.play("hover")


func _on_mouse_exited() -> void:
	calender_anim.play("hover_over")
