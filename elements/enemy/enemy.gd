class_name Enemy extends CharacterBody3D


@export var target: Node3D
@export var speed: float = 4
@export var damage: float = 10
@export var attack_range: float = 2.0
@onready var sprite: AnimatedSprite3D = %Sprite
@onready var state_machine: StateMachine = $StateMachine


func _physics_process(_delta: float) -> void:
	move_and_slide()
	
	# Handle states
	var tdst := global_position.distance_to(target.global_position)
	var cs = state_machine.active_state_name
	if cs == &"chase" and target and tdst < attack_range:
		state_machine.activate_state_by_name(&"attack")
	elif cs == &"null" and target:
		state_machine.activate_state_by_name(&"chase")
	elif cs == &"null":
		state_machine.activate_state_by_name(&"idle")
