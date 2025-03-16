class_name StarSpawner extends Spawner


func spawn_scene(scn: PackedScene):
	var s = scn.instantiate() as Sprite3D
	if not s: return
	
	add_child(s)
	var p = global_position
	var rd = Vector3(
		randf_range(-1, 1),
		randf_range(-1, 1),
		randf_range(-1, 1)
	).normalized()
	var r = rd
	if on_surface: r *= radius
	else: r *= randf_range(0, radius)
	p += r
	s.global_position = p
	s.look_at(Vector3.ZERO, Vector3.UP, true)
	var tex: Texture2D = null
	if randi_range(0, 1): tex = load("res://stars/star.png")
	else: tex = load("res://stars/star2.png")
	s.texture = tex
	s.pixel_size = 0.2 + randf_range(0, 0.3)
	s.modulate = Color(1, 1, 1, 0).lerp(Color.WHITE, maxf(0.1, randf()))
