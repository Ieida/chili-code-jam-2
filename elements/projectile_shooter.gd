class_name ProjectileShooter extends Node3D


@export var projectile_scene: PackedScene
@export var angle_spread: float = 90
@export var bullets: int = 3
var exceptions: Array[CollisionObject3D]


func shoot():
	if not projectile_scene: return
	
	var ad = deg_to_rad(angle_spread / float(bullets))
	var u = global_basis.y.normalized()
	var f = global_basis.z.normalized()
	var d = f.rotated(u, (-ad * (float(bullets) / 2.0)) + (ad / 2.0))
	for bi in bullets:
		var b = projectile_scene.instantiate() as Projectile
		if b:
			for e in exceptions:
				b.add_exception(e)
			get_tree().current_scene.add_child(b)
			var br = u.cross(d)
			b.global_transform = Transform3D(Basis(br, u, d), global_position)
			d = d.rotated(u, ad)
