extends Button
@onready var setting_anim: AnimationPlayer = $SettingAnim
@onready var setting_border: TextureRect = $SettingBorder

func _ready() -> void:
	setting_border.visible = false

func _on_mouse_entered() -> void:
	setting_anim.play("hover")


func _on_mouse_exited() -> void:
	setting_anim.play("hover_over")
