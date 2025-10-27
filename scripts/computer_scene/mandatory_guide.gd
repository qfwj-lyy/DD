extends Control
@onready var full_screen_input_stop: Control = $FullScreenInputStop
@onready var small_input_area: Control = $FullScreenInputStop/SmallInputArea
@onready var cpu_particles_2d: CPUParticles2D = $FullScreenInputStop/CPUParticles2D


func pause():
	full_screen_input_stop.is_open = true
	return 1
	
func set_small_input_area(area_size_x , area_size_y , area_position_x , area_position_y):
	#full_screen_input_stop.visible = true
	
	small_input_area.size = Vector2(area_size_x , area_size_y)
	small_input_area.position = Vector2(area_position_x , area_position_y)
	
	set_particles(area_size_x , area_size_y)
	
func clear():
	full_screen_input_stop.clear()
	#full_screen_input_stop.visible = false

func set_particles(size_x ,size_y):
	var p := Vector2.ZERO
	var condition := 0
	const GAP := 20
	while(1):
		var particle_point : CPUParticles2D = cpu_particles_2d.duplicate()
		small_input_area.add_child(particle_point)
		particle_point.position = p
		particle_point.emitting = true
		particle_point.visible = true
		
		if condition == 0:
			p.x += GAP
			if p.x > small_input_area.size.x:
				condition = 1
				p.x -= GAP
				p.y += GAP
				continue
		elif condition == 1:
			p.y += GAP
			if p.y > small_input_area.size.y:
				condition = 2
				p.y -= GAP
				p.x -= GAP
				continue
		elif condition == 2:
			p.x -= GAP
			if p.x < 0:
				condition = 3
				p.y -= GAP
				p.x += GAP
				continue
		elif condition == 3:
			p.y -= GAP
			if p.y < 0:
				break
