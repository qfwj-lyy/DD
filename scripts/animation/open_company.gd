extends Button
@onready var company_anim: AnimationPlayer = $CompanyAnim
@onready var company_border: TextureRect = $CompanyBorder

func _ready() -> void:
	company_border.visible = false


func _on_mouse_entered() -> void:
	company_anim.play("hover")


func _on_mouse_exited() -> void:
	company_anim.play("hover_over")
