extends AnimatedSprite2D

var condition := 0
var _can_talk := false
func talk():
	if _can_talk:
		return
	_can_talk = true
	while(1):
		if not _can_talk:
			break
		if condition == 0:
			play("talk_without_hand")
			if randi_range(0, 1):
				condition = 1
		elif condition == 1:
			play("talk_with_hand_up")
			condition = 2
		elif condition == 2:
			var r = randi_range(0 , 4)
			if r >= 2:
				play("talk_with_hand")
			elif r == 1:
				play("talk_with_hand_down")
				condition = 0
			elif r == 0:
				play("talk_with_hand_and_bug")
		await animation_finished
	
func stop_talk():
	_can_talk = false
