extends Button

@onready var settings_anim: AnimationPlayer = $SettingsAnim

func _on_mouse_entered() -> void:
	settings_anim.play("hover")


func _on_mouse_exited() -> void:
	settings_anim.play("hover_over")

@onready var border: TextureRect = $Border

func _ready() -> void:
	border.visible = false
