class_name Credits extends GameMenu


signal closed
signal opened


@onready var button_container: Container = %ButtonContainer
@onready var game: Game = get_node("/root/Game")


func _input(event: InputEvent) -> void:
	if event.is_action(&"toggle_credits"):
		if event.is_pressed() and not event.is_echo():
			if visible: close()
			elif not game.current_menu: open()


func _process(_delta: float) -> void:
	if not get_viewport().gui_get_focus_owner():
		var f = button_container.find_next_valid_focus()
		if f: f.grab_focus()


func _ready() -> void:
	close()


func close():
	visible = false
	get_tree().paused = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	closed.emit()


func open():
	visible = true
	get_tree().paused = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	opened.emit()
