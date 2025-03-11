class_name CreditsButton extends Button


@export var social_link: String


func _on_pressed():
	OS.shell_open(social_link)


func _ready() -> void:
	pressed.connect(_on_pressed)
