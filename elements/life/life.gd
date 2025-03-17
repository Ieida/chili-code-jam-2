@tool
class_name Life extends TextureRect


@export var animate: bool
@export var frames: int
@export var frame_size: Vector2
@export var fps: float = 1
var time_elapsed: float


func _process(delta: float) -> void:
	if not animate: return
	
	time_elapsed = wrapf(time_elapsed + (fps * delta), 0, 1)
	var tex = texture as AtlasTexture
	if tex:
		tex.region.size = frame_size
		var l = float(frames - 1)
		var t = time_elapsed * l
		var cf = roundf(t)
		var cfp = cf * frame_size.x
		tex.region.position.x = cfp
