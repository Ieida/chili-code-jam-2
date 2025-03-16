class_name PlayerSpaceShipViewmodel extends Camera3D


@export var space_ship: SpaceShip
@onready var crosshair: Crosshair = %Crosshair
@onready var game: Game = get_node("/root/Game")


func _on_health_depleted():
	%HUD.hide()
	game.trigger_game_over()


func _on_took_hit():
	pass


func _ready() -> void:
	await space_ship.ready
	space_ship.hitbox.took_hit.connect(_on_took_hit)
	space_ship.hitbox.health_depleted.connect(_on_health_depleted)
