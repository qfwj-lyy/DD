extends Button

@onready var exit_game_anim: AnimationPlayer = $ExitGameAnim

func _on_mouse_entered() -> void:
	exit_game_anim.play("hover")


func _on_mouse_exited() -> void:
	exit_game_anim.play("hover_over")

@onready var border: TextureRect = $Border

func _ready() -> void:
	border.visible = false
