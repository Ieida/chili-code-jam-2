extends CanvasLayer


signal closed
signal opened


@onready var button_container: Container = %ButtonContainer


func _input(event: InputEvent) -> void:
	if event.is_action(&"toggle_credits"):
		if event.is_pressed() and not event.is_echo():
			if visible: close()
			else: open()


func _ready() -> void:
	close()


func close():
	visible = false
	closed.emit()


func open():
	visible = true
	if button_container.get_child_count() > 0:
		for c in button_container.get_children():
			if c is Control:
				c.grab_focus()
				break
	opened.emit()
