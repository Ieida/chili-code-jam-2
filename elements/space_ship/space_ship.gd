class_name SpaceShip extends CharacterBody3D


@export var horizontal_x_force: float = 8
@export var horizontal_y_force: float = 8
@export var vertical_force: float = 4
@export var accelerate_force: float = 8
@export var slow_down_force: float = 4
@export var torque_x: float = 2
@export var torque_y: float = 2
@onready var crosshair: Crosshair = $UI/Control/Crosshair
var input: Vector3
var angular_input: Vector3


func _physics_process(delta: float) -> void:
	if angular_input:
		var inp = angular_input
		angular_input = Vector3.ZERO
		inp.x *= torque_x
		inp.y *= torque_y
		rotate(global_basis.y, deg_to_rad(-inp.x))
		rotate(global_basis.x, deg_to_rad(-inp.y))
	global_rotation.z = move_toward(global_rotation.z, 0, delta)
	if input:
		var inp = input
		input = Vector3.ZERO
		inp.x *= horizontal_x_force
		inp.y *= vertical_force
		inp.z *= horizontal_y_force
		inp = transform.basis * inp
		velocity = velocity.move_toward(inp, accelerate_force * delta)
	else:
		velocity = velocity.move_toward(Vector3.ZERO, slow_down_force * delta)
	move_and_slide()
