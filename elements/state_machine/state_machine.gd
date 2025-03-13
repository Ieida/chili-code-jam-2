class_name StateMachine extends State


var active_state: State
var active_state_name: StringName = NULL_STATE
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
	if active_state == state:
		if active_state.reactivate:
			active_state.set_active(false)
			active_state.set_active(true)
	else:
		active_state = state
		active_state_name = state.name
		state.set_active(true)


func activate_state_by_name(state: StringName):
	if not states.has(state): return
	
	var s = states[state] as State
	if active_state == s:
		if active_state.reactivate:
			active_state.set_active(false)
			active_state.set_active(true)
	else:
		if active_state: deactivate_state(active_state)
		active_state = s
		active_state_name = state
		s.set_active(true)


func deactivate_state(state: State):
	state.set_active(false)
	if active_state:
		active_state = null
		active_state_name = NULL_STATE
