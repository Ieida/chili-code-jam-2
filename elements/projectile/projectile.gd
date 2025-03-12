class_name Projectile extends ShapeCast3D


@export var damage: float = 10
@export var lifetime: float = 10
@export var speed: float = 100
var time_elapsed: float


func _physics_process(delta: float) -> void:
	time_elapsed += delta
	
	var mov = -global_basis.z.normalized() * speed * delta 
	global_position += mov
	target_position = mov
	force_shapecast_update()
	if is_colliding():
		for ci in get_collision_count():
			var c = get_collider(ci)
			if c is Hitbox:
				deal_damage(c)
		queue_free()
	
	if not is_queued_for_deletion() and time_elapsed > lifetime:
		queue_free()


func deal_damage(to: Hitbox):
	to.hit(damage)
