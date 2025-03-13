class_name Spawner extends Node3D


@export var scene: PackedScene
## Spawns per second
@export var rate: float = 0.2
@export var radius: float = 16
@export var initial_amount: int = 32
@export var on_surface: bool = true
@onready var game: Game = get_node("/root/Game")
var time_elapsed: float


func _physics_process(delta: float) -> void:
	if time_elapsed < 1.0 / rate:
		time_elapsed += delta
		if time_elapsed >= 1.0 / rate:
			time_elapsed = 0
			spawn()


func _ready() -> void:
	for i in initial_amount:
		spawn.call_deferred()


func spawn():
	spawn_scene(scene)


func spawn_scene(scn: PackedScene):
	var s = scn.instantiate()
	game.current_level.add_child(s)
	if s is Node3D:
		var p = global_position
		var rd = Vector3(
			randf_range(-1, 1),
			randf_range(-1, 1),
			randf_range(-1, 1)
		).normalized()
		var r = rd
		if on_surface: r *= radius
		else: r *= randf_range(0, radius)
		p += r
		s.global_position = p
		s.global_rotation = global_rotation
