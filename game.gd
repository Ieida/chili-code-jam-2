class_name Game extends Node


@onready var level: Node = $Level


func change_level_to_file(file_path: String):
	var f = load(file_path)
	if f is PackedScene: change_level_to_scene(f)


func change_level_to_node(node: Level):
	# Free previous level
	for c in level.get_children():
		c.queue_free()
	
	# Add new level
	level.add_child(node)


func change_level_to_scene(scene: PackedScene):
	var l = scene.instantiate() as Level
	if l: change_level_to_node(l)
