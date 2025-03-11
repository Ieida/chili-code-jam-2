class_name PlayerSpaceShipController extends Node


@export_range(0, 1, 0.01) var look_deadzone: float = 0.4
@onready var viewmodel: PlayerSpaceShipViewmodel = get_parent() as PlayerSpaceShipViewmodel
@onready var crosshair: Crosshair = %Crosshair
var ray_query_params: PhysicsRayQueryParameters3D


func _physics_process(_delta: float) -> void:
	var h_in := Input.get_axis(&"left", &"right")
	var v_in := Input.get_axis(&"down", &"up")
	var c_in := Input.get_axis(&"front", &"back")
	var inp_v := Vector3(h_in, v_in, c_in)
	viewmodel.space_ship.input = inp_v
	if crosshair.edge_distance > look_deadzone:
		var h_ain = crosshair.edge_distance_x
		var v_ain = crosshair.edge_distance_y
		viewmodel.space_ship.angular_input = Vector3(h_ain, v_ain, 0)
	
	# Aim gun
	var gn = viewmodel.space_ship.gun
	var gn2 = viewmodel.space_ship.gun2
	var ap = calc_aiming_point()
	gn.look_at(ap)
	gn2.look_at(ap)
	# Shoot
	if Input.is_action_pressed(&"shoot"):
		gn.shoot()
		gn2.shoot()


func _ready() -> void:
	ray_query_params = PhysicsRayQueryParameters3D.new()
	ray_query_params.hit_back_faces = false


func calc_aiming_point() -> Vector3:
	var sp = crosshair.global_position
	var ro = viewmodel.project_ray_origin(sp)
	var rn = viewmodel.project_ray_normal(sp)
	var wld = viewmodel.get_world_3d()
	var to = ro + (rn * 1000.0)
	ray_query_params.from = ro
	ray_query_params.to = to
	var r = wld.direct_space_state.intersect_ray(ray_query_params)
	if r.is_empty(): return to
	else: return r["position"]
