extends Control

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file('res://levels/prototype/prototype_level.tscn')


func _on_options_pressed() -> void:
	get_tree().change_scene_to_file('res://scene/option menu.tscn')


func _on_quit_pressed() -> void:
	get_tree().quit()
