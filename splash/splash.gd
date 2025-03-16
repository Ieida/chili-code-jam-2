class_name Splash extends PanelContainer


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed() and not event.is_echo():
			get_tree().change_scene_to_file("res://game.tscn")
