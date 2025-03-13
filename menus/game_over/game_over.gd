class_name GameOver extends GameMenu


@onready var game: Game = get_node("/root/Game")


func _on_restart_pressed():
	get_tree().paused = false
	game.restart_level.call_deferred()


func _ready() -> void:
	%Restart.pressed.connect(_on_restart_pressed)


func close():
	get_tree().paused = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	hide()


func open():
	get_tree().paused = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	show()
