class_name Hitbox extends Area3D


signal health_depleted
signal took_hit


@export var max_health: float
@onready var health: float = max_health
var is_health_depleted: bool


func hit(damage: float):
	if is_health_depleted: return
	
	health = maxf(0, health - damage)
	if is_zero_approx(health):
		is_health_depleted = true
	
	if is_health_depleted: health_depleted.emit()
	else: took_hit.emit()


func reset():
	is_health_depleted = false
	health = max_health
