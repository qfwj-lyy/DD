extends Button

@onready var browser_anim: AnimationPlayer = $BrowserAnim
@onready var browser_border: TextureRect = $BrowserBorder

func _ready() -> void:
	browser_border.visible = false

func _on_mouse_entered() -> void:
	browser_anim.play("hover")


func _on_mouse_exited() -> void:
	browser_anim.play("hover_over")
