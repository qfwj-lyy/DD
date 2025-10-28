extends TextureRect
@onready var buff_description: Label = $"../BuffDescription"

func _ready() -> void:
	connect("mouse_entered", _on_mouse_entered)
	
func _on_mouse_entered():
	match name:
		"EmotionBuff1":
			buff_description.text = "心情20buff：增加1手牌上限"
		"EmotionBuff2":
			buff_description.text = "心情50buff：增加2手牌上限"
		"EmotionBuff3":
			buff_description.text = "心情60buff：商店可以刷出稀有卡片"
		"EmotionBuff4":
			buff_description.text = "心情90buff：bug数每单位时间-1"
		"EmotionBuff5":
			buff_description.text = "心情100buff：项目进度每回合+3"
			
