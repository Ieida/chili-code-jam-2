class_name PlayerSpaceShipController extends Node


@export_range(0, 1, 0.01) var look_deadzone: float = 0.4
@onready var viewmodel: PlayerSpaceShipViewmodel = get_parent() as PlayerSpaceShipViewmodel
@onready var crosshair: Crosshair = %Crosshair


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
