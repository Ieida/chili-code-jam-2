class_name State extends Node


const NULL_STATE: StringName = &"null"


## Should the state be reactivated if requested
@export var reactivate: bool
var is_active: bool
var machine: StateMachine


func enter():
	pass


func exit():
	pass


func set_active(active: bool):
	is_active = active
	if active: enter()
	else: exit()
