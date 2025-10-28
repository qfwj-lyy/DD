extends AnimatedSprite2D

var condition := 0
func talk():
	condition = 0
	while(1):
		if condition == 0:
			play("talk_without_hand")
			if randi_range(0, 1):
				condition = 1
		elif condition == 1:
			play("talk_with_hand_up")
			condition = 2
		elif condition == 2:
			var r = randi_range(0 , 2)
			if r == 0:
				play("talk_with_hand")
			elif r == 1:
				play("talk_with_hand_down")
				condition = 0
			elif r == 2:
				play("talk_with_hand_and_bug")
		elif condition == -6:
			speed_scale = 2
			break
		await animation_finished
	
func stop_talk():
	condition = -6
