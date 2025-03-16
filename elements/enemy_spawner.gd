class_name EnemySpawner extends Spawner


signal wave_started


@export var normal_scene: PackedScene
@export var normal_wave_multiplier: float = 1.2
@export var normals_per_wave: int = 20
@export var elite_scene: PackedScene
@export var elite_wave_multiplier: float = 1.1
@export var elites_per_wave: int = 1
var spawns: int
var wave: int


func _ready() -> void:
	wave += 1
	wave_started.emit()


func spawn():
	spawn_scene(normal_scene)
	spawns += 1
	var w = wave
	if spawns == roundf(float(normals_per_wave) * (w * normal_wave_multiplier)):
		var ec = roundf(float(elites_per_wave) * elite_wave_multiplier * wave)
		for ei in int(ec):
			spawn_scene(elite_scene)
		wave += 1
		wave_started.emit()
