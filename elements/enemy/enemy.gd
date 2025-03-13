class_name Enemy extends CharacterBody3D


@export var target: Node3D
@export var speed: float = 4
@export var damage: float = 10
@export var attack_range: float = 2.0
@export var attack_cooldown: float = 1.0
@onready var hitbox: Hitbox = $Hitbox
@onready var sprite: AnimatedSprite3D = %Sprite
@onready var state_machine: StateMachine = $StateMachine


func _on_health_depleted():
	state_machine.activate_state_by_name(&"death")


func _on_took_hit():
	state_machine.activate_state_by_name(&"hurt")


func _physics_process(_delta: float) -> void:
	move_and_slide()


func _ready() -> void:
	hitbox.took_hit.connect(_on_took_hit)
	hitbox.health_depleted.connect(_on_health_depleted)
	target = get_tree().get_first_node_in_group(&"players")
