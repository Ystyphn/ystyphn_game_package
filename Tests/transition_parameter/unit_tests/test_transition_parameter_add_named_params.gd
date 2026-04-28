extends GutTest

var transition_parameter: TransitionParameter


func before_each() -> void:
	transition_parameter = TransitionParameter.new()


func test_add_named_param_can_add_items() -> void:
	transition_parameter.add_named_param(&"previous_state", &"idle")
	transition_parameter.add_named_param(&"velocity", Vector2(20, 0))
	transition_parameter.add_named_param(&"next_state", &"walk")
	
	assert_eq(transition_parameter.named_params.size(), 3)
	assert_eq(transition_parameter.get_named_param(&"previous_state"), &"idle")
	assert_eq(transition_parameter.get_named_param(&"velocity"), Vector2(20, 0))
	assert_eq(transition_parameter.get_named_param(&"next_state"), &"walk")


func test_add_named_param_does_not_override_existing_key() -> void:
	transition_parameter.add_named_param(&"state", &"idle")
	transition_parameter.add_named_param(&"state", &"walk") # attempt override
	
	assert_eq(transition_parameter.named_params.size(), 1)
	assert_eq(transition_parameter.get_named_param(&"state"), &"idle") # original value preserved


func test_add_named_param_prevents_duplicate_keys() -> void:
	transition_parameter.add_named_param(&"health", 100)
	transition_parameter.add_named_param(&"health", 100)
	
	assert_eq(transition_parameter.named_params.size(), 1)


func test_add_named_param_accepts_various_value_types() -> void:
	transition_parameter.add_named_param(&"int", 1)
	transition_parameter.add_named_param(&"float", 1.5)
	transition_parameter.add_named_param(&"string", "hello")
	transition_parameter.add_named_param(&"vector", Vector2.ONE)
	transition_parameter.add_named_param(&"bool", true)
	
	assert_eq(transition_parameter.named_params.size(), 5)


func test_add_named_param_allows_null_value() -> void:
	transition_parameter.add_named_param(&"nullable", null)
	
	assert_true(transition_parameter.has_named_param(&"nullable"))
	assert_null(transition_parameter.get_named_param(&"nullable"))


func test_add_named_param_with_empty_key() -> void:
	transition_parameter.add_named_param(&"", "value")
	
	assert_true(transition_parameter.has_named_param(&""))
	assert_eq(transition_parameter.get_named_param(&""), "value")


func test_add_named_param_key_integrity() -> void:
	var key := &"test_key"
	transition_parameter.add_named_param(key, "value")
	
	assert_true(key in transition_parameter.named_params)
