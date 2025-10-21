extends Button

@onready var border_rect: TextureRect = $BorderRect
@onready var begin_game_anim: AnimationPlayer = $BeginGameAnim

func _on_area_2d_mouse_entered() -> void:
	begin_game_anim.play("hover")
	border_rect.visible = true


func _on_area_2d_mouse_exited() -> void:
	begin_game_anim.play("hover_over")
	border_rect.visible = false
