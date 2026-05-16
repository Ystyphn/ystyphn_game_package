extends GutTest


var transition_parameter: TransitionParameter


func before_each() -> void:
	transition_parameter = TransitionParameter.new()


func test_has_named_parameter_can_check_whether_the_specified_value_exists() -> void:
	transition_parameter.add_named_param("state", "idle")
	transition_parameter.add_named_param("previous_state", "walk")
	
	assert_true(transition_parameter.has_named_param("state"))
	assert_true(transition_parameter.has_named_param("previous_state"))
	
	assert_false(transition_parameter.has_named_param("damage"))
	assert_false(transition_parameter.has_named_param("small"))


func test_has_named_parameter_to_return_false_if_there_are_no_parameters() -> void:
	transition_parameter.named_params = {}
	assert_false(transition_parameter.has_named_param("input"))


# ------------------ EXTENSIONS ------------------


func test_has_named_parameter_returns_false_when_empty() -> void:
	assert_false(transition_parameter.has_named_param("anything"))


func test_has_named_parameter_after_multiple_insertions() -> void:
	transition_parameter.add_named_param("a", 1)
	transition_parameter.add_named_param("b", 2)
	transition_parameter.add_named_param("c", 3)
	
	assert_true(transition_parameter.has_named_param("a"))
	assert_true(transition_parameter.has_named_param("b"))
	assert_true(transition_parameter.has_named_param("c"))
	assert_false(transition_parameter.has_named_param("d"))


func test_has_named_parameter_is_not_affected_by_values() -> void:
	transition_parameter.add_named_param("state", null)
	
	assert_true(transition_parameter.has_named_param("state")) # key exists even if value is null


func test_has_named_parameter_distinguishes_between_missing_and_null_value() -> void:
	transition_parameter.add_named_param("nullable", null)
	
	assert_true(transition_parameter.has_named_param("nullable"))
	assert_false(transition_parameter.has_named_param("missing"))


func test_has_named_parameter_after_duplicate_insert_attempt() -> void:
	transition_parameter.add_named_param("state", "idle")
	transition_parameter.add_named_param("state", "walk") # ignored
	
	assert_true(transition_parameter.has_named_param("state"))


func test_has_named_parameter_with_empty_key() -> void:
	transition_parameter.add_named_param("", "value")
	
	assert_true(transition_parameter.has_named_param(""))
	assert_false(transition_parameter.has_named_param(" "))


func test_has_named_parameter_does_not_mutate_internal_state() -> void:
	transition_parameter.add_named_param("state", "idle")
	
	var _value = transition_parameter.has_named_param("state")
	
	assert_eq(transition_parameter.named_params.size(), 1)
	assert_true(transition_parameter.has_named_param("state"))


func test_has_named_parameter_large_number_of_keys() -> void:
	for i in range(100):
		transition_parameter.add_named_param("key_%d" % i, i)
	
	for i in range(100):
		assert_true(transition_parameter.has_named_param("key_%d" % i))
	
	assert_false(transition_parameter.has_named_param("key_101"))
