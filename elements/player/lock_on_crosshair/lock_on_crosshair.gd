@tool
class_name LockOnCrosshair extends Control


@export var anim_duration: float = 1
@export var size_x: float = 96:
	set(value):
		size_x = value
		queue_redraw()
@export var size_y: float = 96:
	set(value):
		size_y = value
		queue_redraw()
@export var line_width: float = 4:
	set(value):
		line_width = value
		queue_redraw()
@export var color: Color = Color.CYAN:
	set(value):
		color = value
		queue_redraw()
var camera: Camera3D
var is_locked_on: bool
var target: Node3D
var time_elapsed: float


func _draw() -> void:
	var hsx = size_x / 2.0
	var hsy = size_y / 2.0
	draw_rect(
		Rect2(-hsx, -hsy, size_x, size_y),
		color,
		false,
		line_width,
		true
	)


func _process(delta: float) -> void:
	if target and time_elapsed < anim_duration:
		time_elapsed = minf(anim_duration, time_elapsed + delta)
		var t = time_elapsed / anim_duration
		rotation = lerp_angle(rotation, 0, t)
		modulate = Color.TRANSPARENT.lerp(Color.WHITE, t)
		if time_elapsed >= anim_duration:
			is_locked_on = true
			if Engine.is_editor_hint():
				time_elapsed = 0
				rotation = deg_to_rad(90)
	if target:
		var cm = camera if camera else get_viewport().get_camera_3d()
		if cm:
			var tp = cm.unproject_position(target.global_position)
			global_position = global_position.lerp(tp, time_elapsed / anim_duration)


func reset():
	is_locked_on = false
	time_elapsed = 0
	rotation = deg_to_rad(90)
