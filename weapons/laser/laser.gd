@tool
class_name Laser extends ShapeCast3D


@export var is_active: bool = true
@export var target: Vector3
@export var width: float = 1:
	set(value):
		width = value
		width_changed = true
@export var damage: float
@onready var mesh: MeshInstance3D = $Mesh
var width_changed: bool


func _process(_delta: float) -> void:
	var c = get_viewport().get_camera_3d()
	if Engine.is_editor_hint():
		c = EditorInterface.get_editor_viewport_3d(0).get_camera_3d()
	if c:
		var pt = c.global_position - global_position
		var pp = Plane(-global_basis.z).project(pt)
		mesh.global_basis = Basis(
			pp.normalized().cross(global_basis.z),
			-global_basis.z,
			pp.normalized()
		)
	
	var sm = mesh.material_override as ShaderMaterial
	if width_changed:
		width_changed = false
		if sm: sm.set_shader_parameter(&"line_width", width)
	sm.set_shader_parameter(&"line_length", to_local(target).length())


func _physics_process(delta: float) -> void:
	if is_active:
		if not is_visible_in_tree(): show()
		force_shapecast_update()
		if is_colliding():
			target = get_collision_point(0)
			if not Engine.is_editor_hint():
				for ci in get_collision_count():
					var c = get_collider(ci)
					if c is Hitbox:
						c.hit(damage * delta)
		else:
			var l = 1000.
			target = -global_basis.z * l
	elif not Engine.is_editor_hint() and is_visible_in_tree(): hide()


func _ready() -> void:
	if not Engine.is_editor_hint():
		is_active = false
