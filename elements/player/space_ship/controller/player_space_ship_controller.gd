class_name PlayerSpaceShipController extends Node


@export_range(0, 1, 0.01) var look_deadzone: float = 0.4
@onready var viewmodel: PlayerSpaceShipViewmodel = get_parent() as PlayerSpaceShipViewmodel
@onready var hud: Control = %HUD
@onready var targeting: Area3D = %Targeting
var ray_query_params: PhysicsRayQueryParameters3D


func _physics_process(_delta: float) -> void:
	var h_in := Input.get_axis(&"left", &"right")
	var v_in := Input.get_axis(&"down", &"up")
	var c_in := Input.get_axis(&"front", &"back")
	var inp_v := Vector3(h_in, v_in, c_in)
	viewmodel.space_ship.input = inp_v
	if viewmodel.crosshair.edge_distance > look_deadzone:
		var h_ain = viewmodel.crosshair.edge_distance_x
		var v_ain = viewmodel.crosshair.edge_distance_y
		viewmodel.space_ship.angular_input = Vector3(h_ain, v_ain, 0)
	
	# Aim gun
	var gn = viewmodel.space_ship.gun
	var gn2 = viewmodel.space_ship.gun2
	var l1 = null
	var l2 = null
	if targeting.lockons.size() > 0: l1 = targeting.lockons[0]
	if targeting.lockons.size() > 1: l2 = targeting.lockons[1]
	if l1 and l1.target:
		gn.look_at(l1.target.global_position)
	if l2 and l2.target:
		gn2.look_at(l2.target.global_position)
	# Shoot
	if Input.is_action_pressed(&"shoot"):
		gn.shoot()
		gn2.shoot()


func _ready() -> void:
	ray_query_params = PhysicsRayQueryParameters3D.new()
	ray_query_params.hit_back_faces = false
	targeting.spawn_lockon.call_deferred()
	targeting.spawn_lockon.call_deferred()


func calc_aiming_point(screen_point) -> Vector3:
	var ro = viewmodel.project_ray_origin(screen_point)
	var rn = viewmodel.project_ray_normal(screen_point)
	var wld = viewmodel.get_world_3d()
	var to = ro + (rn * 1000.0)
	ray_query_params.from = ro
	ray_query_params.to = to
	var r = wld.direct_space_state.intersect_ray(ray_query_params)
	if r.is_empty(): return to
	else: return r["position"]
