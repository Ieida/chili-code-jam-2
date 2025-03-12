class_name StateMachine extends State


var active_state: State
var active_state_name: StringName = &"null"
var states: Dictionary[StringName, Node]


func _enter_tree() -> void:
	if not get_parent() is State: set_active(true)
	child_entered_tree.connect(_on_child_entered_tree)
	child_exiting_tree.connect(_on_child_exiting_tree)


func _on_child_entered_tree(node: Node):
	if node is State:
		node.machine = self
		var n = node.name.to_snake_case()
		states[n] = node


func _on_child_exiting_tree(node: Node):
	if node is State:
		var n = node.name.to_snake_case()
		if states.has(n): states.erase(n)


func activate_state(state: State):
	if not active_state:
		active_state = state
		active_state_name = state.name.to_snake_case()
	state.set_active(true)


func activate_state_by_name(state: StringName):
	if active_state and state == active_state_name: return
	if not states.has(state): return
	
	if active_state: deactivate_state(active_state)
	
	var s = states[state] as State
	active_state = s
	active_state_name = state
	s.set_active(true)


func deactivate_state(state: State):
	state.set_active(false)
	if active_state:
		active_state = null
		active_state_name = &"null"
