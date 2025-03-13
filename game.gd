class_name Game extends Node


signal level_changed


@onready var level: Node = $Level
var current_level: Level
var current_menu: GameMenu


func _ready() -> void:
	var c = level.get_child(0) as Level
	if c: current_level = c
	for m in $Menus.get_children():
		m.close()

func change_level_to_file(file_path: String):
	var f = load(file_path)
	if f is PackedScene: change_level_to_scene(f)


func change_level_to_node(node: Level):
	# Free previous level
	for c in level.get_children():
		level.remove_child(c)
		c.queue_free()
	
	# Add new level
	current_level = node
	level.add_child(node)
	level_changed.emit()


func change_level_to_scene(scene: PackedScene):
	var l = scene.instantiate() as Level
	if l: change_level_to_node(l)


func restart_level():
	var l = level.get_child(0) as Level
	if l and not l.scene_file_path.is_empty():
		change_level_to_file(l.scene_file_path)
	if current_menu is GameOver:
		%GameOver.close()
		current_menu = null


func trigger_game_over():
	if current_menu: current_menu.close()
	current_menu = %GameOver
	%GameOver.open()
