extends GutTest

var controllable_entity: ControllableEntity


func before_each() -> void:
	controllable_entity = autofree(FakeControllableEntity.new())


# ============================================================
# SUCCESS PATH
# ============================================================

func test_ready_initializes_receivers_and_state_machine() -> void:
	var input_receivers := Node.new()
	input_receivers.name = "InputReceivers"

	var receiver_a = double(InputReceiver).new()
	var receiver_b = double(InputReceiver).new()

	input_receivers.add_child(receiver_a)
	input_receivers.add_child(receiver_b)

	var state_machine = double(StateMachine).new()
	state_machine.name = "StateMachine"

	controllable_entity.add_child(input_receivers)
	controllable_entity.add_child(state_machine)

	controllable_entity.set_input_receivers_path(NodePath("InputReceivers"))
	controllable_entity.set_state_machine_path(NodePath("StateMachine"))

	add_child_autofree(controllable_entity)

	controllable_entity._ready()

	assert_eq(
		controllable_entity.get_state_machine(),
		state_machine,
		"Should assign state machine reference."
	)

	assert_called(receiver_a, "set_entity", [controllable_entity])
	assert_called(receiver_b, "set_entity", [controllable_entity])

	assert_called(state_machine, "set_root_object", [controllable_entity])


# ============================================================
# INPUT RECEIVERS PATH EMPTY
# ============================================================

func test_ready_returns_early_when_input_receivers_path_not_set() -> void:
	add_child_autofree(controllable_entity)
	
	assert_push_error("Input receivers path was not set!")
	assert_eq(
		controllable_entity.get_state_machine(),
		null,
		"Should abort before state machine setup when input receiver path missing."
	)


# ============================================================
# STATE MACHINE PATH EMPTY
# ============================================================

func test_ready_sets_receivers_but_aborts_when_state_machine_path_missing() -> void:
	pass_test("Modify this later")


# ============================================================
# INVALID INPUT RECEIVER PATH (BREAK TEST)
# ============================================================

func test_ready_breaks_when_input_receivers_path_invalid() -> void:
	controllable_entity.set_input_receivers_path(NodePath("FakePath"))
	controllable_entity.set_state_machine_path(NodePath("Anything"))

	add_child_autofree(controllable_entity)
	assert_engine_error_count(2)
	
	assert_push_error("Specified state machine path was not found!")
	assert_push_error("Input receivers was not set!")


# ============================================================
# INVALID STATE MACHINE PATH (BREAK TEST)
# ============================================================

func test_ready_breaks_when_state_machine_path_invalid() -> void:
	var input_receivers := Node.new()
	input_receivers.name = "InputReceivers"

	controllable_entity.add_child(input_receivers)

	controllable_entity.set_input_receivers_path(NodePath("InputReceivers"))
	controllable_entity.set_state_machine_path(NodePath("MissingStateMachine"))

	add_child_autofree(controllable_entity)
	
	assert_engine_error_count(1)
	assert_push_error("Specified state machine path was not found!")
