class_name PlayerSpaceShipController extends Node


@export var space_ship: SpaceShip


func _physics_process(_delta: float) -> void:
	var h_in := Input.get_axis(&"left", &"right")
	var v_in := Input.get_axis(&"down", &"up")
	var c_in := Input.get_axis(&"front", &"back")
	var inp_v := Vector3(h_in, v_in, c_in)
	space_ship.input = inp_v
	if space_ship.crosshair.edge_distance > 0.2:
		var h_ain = space_ship.crosshair.edge_distance_x
		var v_ain = space_ship.crosshair.edge_distance_y
		space_ship.angular_input = Vector3(h_ain, v_ain, 0)
