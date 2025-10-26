extends ProgressBar

@onready var value_label: Label = $ValueLabel

func update_label_text():
	value_label.text = str(int(value)) + "/" + str(int(max_value))

func _on_changed() -> void:
	update_label_text()
func _on_value_changed(_value: float) -> void:
	update_label_text()
