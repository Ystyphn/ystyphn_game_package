extends GutTest

var transition_parameter: TransitionParameter

func before_each() -> void:
	transition_parameter = TransitionParameter.new()


func test_get_named_param_can_return_existing_values() -> void:
	var dmg: Damage = Damage.new()
	
	transition_parameter.add_named_param(&"previous_state", "idle")
	transition_parameter.add_named_param(&"payload", dmg)
	
	assert_eq(transition_parameter.get_named_param(&"previous_state"), "idle")
	assert_eq(transition_parameter.get_named_param(&"payload"), dmg)


func test_get_named_param_return_null_when_specified_key_does_not_exists() -> void:
	assert_null(transition_parameter.get_named_param(&"previous_state"))
	assert_null(transition_parameter.get_named_param(&"payload"))


# ------------------ EXTENSIONS ------------------


func test_get_named_param_returns_correct_value_after_multiple_insertions() -> void:
	transition_parameter.add_named_param(&"a", 1)
	transition_parameter.add_named_param(&"b", 2)
	transition_parameter.add_named_param(&"c", 3)
	
	assert_eq(transition_parameter.get_named_param(&"a"), 1)
	assert_eq(transition_parameter.get_named_param(&"b"), 2)
	assert_eq(transition_parameter.get_named_param(&"c"), 3)


func test_get_named_param_returns_null_for_non_existent_key_even_when_others_exist() -> void:
	transition_parameter.add_named_param(&"existing", 42)
	
	assert_null(transition_parameter.get_named_param(&"missing"))


func test_get_named_param_handles_null_values_correctly() -> void:
	transition_parameter.add_named_param(&"nullable", null)
	
	assert_true(transition_parameter.has_named_param(&"nullable"))
	assert_null(transition_parameter.get_named_param(&"nullable"))


func test_get_named_param_distinguishes_between_missing_and_null_value() -> void:
	transition_parameter.add_named_param(&"nullable", null)
	
	assert_null(transition_parameter.get_named_param(&"nullable"))  # exists but null
	assert_false(transition_parameter.has_named_param(&"missing"))  # truly missing


func test_get_named_param_returns_same_object_reference() -> void:
	var dmg: Damage = Damage.new()
	transition_parameter.add_named_param(&"payload", dmg)
	
	var retrieved = transition_parameter.get_named_param(&"payload")
	assert_eq(retrieved, dmg)


func test_get_named_param_after_duplicate_insert_attempt() -> void:
	transition_parameter.add_named_param(&"state", "idle")
	transition_parameter.add_named_param(&"state", "walk") # ignored
	
	assert_eq(transition_parameter.get_named_param(&"state"), "idle")


func test_get_named_param_with_empty_key() -> void:
	transition_parameter.add_named_param(&"", "value")
	
	assert_eq(transition_parameter.get_named_param(&""), "value")


func test_get_named_param_does_not_mutate_internal_state() -> void:
	transition_parameter.add_named_param(&"state", "idle")
	
	var value = transition_parameter.get_named_param(&"state")
	
	assert_eq(transition_parameter.get_named_param(&"state"), value)
	assert_eq(transition_parameter.named_params.size(), 1)
	assert_eq(transition_parameter.get_named_param(&"state"), "idle")
