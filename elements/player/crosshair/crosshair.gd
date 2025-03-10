@tool
class_name Crosshair extends Control


@export var color: Color = Color.WHITE:
	set(value):
		color = value
		queue_redraw()
@export var gap_width: float = 32:
	set(value):
		gap_width = value
		queue_redraw()
@export var width: float = 4:
	set(value):
		width = value
		queue_redraw()
@export_range(0, 1, 0.01) var max_radius: float = 0.75
@export var joy_sensitivity: float = 16.0
@export var back_to_center: bool
@export var back_to_center_speed: float = 4
var edge_distance: float
var edge_distance_x: float
var edge_distance_y: float
var recieved_input: bool


func _draw() -> void:
	draw_circle(Vector2.ZERO, gap_width, color, false, width, true)


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		position += event.relative
		recieved_input = true


func _process(delta: float) -> void:
	if not Engine.is_editor_hint():
		var pos = position
		# Add joy input
		var jih = Input.get_axis(&"look_left", &"look_right")
		var jiv = Input.get_axis(&"look_up", &"look_down")
		# Modify input
		jih *= absf(jih) * 2.0
		jiv *= absf(jiv) * 2.0
		if not recieved_input and (not is_zero_approx(jih) or not is_zero_approx(jiv)):
			recieved_input = true
		pos += Vector2(jih * joy_sensitivity, jiv * joy_sensitivity)
		var vs = get_viewport_rect().size
		var hvs = vs / 2.0
		var ctr = vs / 2.0
		var dst = ctr.distance_to(pos)
		if not recieved_input and back_to_center:
			pos = pos.move_toward(ctr, dst * back_to_center_speed * delta)
		# Find radius
		var rds = 0.0
		if vs.x < vs.y: rds = hvs.x * max_radius
		else: rds = hvs.y * max_radius
		# Constrain to radius
		if dst > rds: pos = ctr + (ctr.direction_to(pos) * rds)
		position = pos
		# Calculate edge distance
		var ndst = pos - ctr
		edge_distance = ndst.length() / rds
		edge_distance_x = ndst.x / rds
		edge_distance_y = ndst.y / rds
		
		if recieved_input: recieved_input = false
