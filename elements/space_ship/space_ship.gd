class_name SpaceShip extends CharacterBody3D


@export var horizontal_x_force: float = 8
@export var horizontal_y_force: float = 8
@export var vertical_force: float = 4
@export var accelerate_force: float = 8
@export var slow_down_force: float = 4
@export var torque_x: float = 2
@export var torque_y: float = 2
@onready var gun := $Gun
@onready var gun2 := $Gun2
@onready var hitbox: Hitbox = %Hitbox
var input: Vector3
var angular_input: Vector3


func _physics_process(delta: float) -> void:
	if angular_input:
		var inp = angular_input
		angular_input = Vector3.ZERO
		inp.x *= torque_x
		inp.y *= torque_y
		var up = global_basis.y.normalized()
		var right = global_basis.x.normalized()
		rotate(up, deg_to_rad(-inp.x))
		rotate(right, deg_to_rad(-inp.y))
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


func _ready() -> void:
	gun.damage_exceptions.append(self)
	gun.damage_exceptions.append(hitbox)
	gun2.damage_exceptions.append(self)
	gun2.damage_exceptions.append(hitbox)
