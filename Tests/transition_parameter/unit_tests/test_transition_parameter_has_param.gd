extends GutTest


var transition_parameter: TransitionParameter


func before_each() -> void:
	transition_parameter = TransitionParameter.new()


func test_has_param_can_return_appropriate_values() -> void:
	transition_parameter.add_param("hello_world")
	transition_parameter.add_param("yoke")
	transition_parameter.add_param(1)
	
	assert_true(transition_parameter.has_param("hello_world"))
	assert_true(transition_parameter.has_param("yoke"))
	assert_true(transition_parameter.has_param(1))
	
	assert_false(transition_parameter.has_param("state"))
	assert_false(transition_parameter.has_param(Damage.new()))


# ------------------ EXTENSIONS ------------------


func test_has_param_returns_false_when_empty() -> void:
	assert_false(transition_parameter.has_param("anything"))
	assert_false(transition_parameter.has_param(1))


func test_has_param_after_multiple_insertions() -> void:
	transition_parameter.add_param("a")
	transition_parameter.add_param("b")
	transition_parameter.add_param("c")
	
	assert_true(transition_parameter.has_param("a"))
	assert_true(transition_parameter.has_param("b"))
	assert_true(transition_parameter.has_param("c"))
	assert_false(transition_parameter.has_param("d"))


func test_has_param_with_null_value() -> void:
	transition_parameter.add_param(null)
	
	assert_true(transition_parameter.has_param(null))
	assert_false(transition_parameter.has_param("null"))


func test_has_param_prevents_duplicate_values() -> void:
	transition_parameter.add_param(1)
	transition_parameter.add_param(1)
	
	assert_true(transition_parameter.has_param(1))
	assert_eq(transition_parameter.params.size(), 1)


func test_has_param_object_identity() -> void:
	var dmg: Damage = Damage.new()
	transition_parameter.add_param(dmg)
	
	assert_true(transition_parameter.has_param(dmg))
	assert_false(transition_parameter.has_param(Damage.new())) # different instance


func test_has_param_handles_multiple_types() -> void:
	var dmg: Damage = Damage.new()
	
	transition_parameter.add_param("text")
	transition_parameter.add_param(42)
	transition_parameter.add_param(3.14)
	transition_parameter.add_param(Vector2.ONE)
	transition_parameter.add_param(true)
	transition_parameter.add_param(dmg)
	
	assert_true(transition_parameter.has_param("text"))
	assert_true(transition_parameter.has_param(42))
	assert_true(transition_parameter.has_param(3.14))
	assert_true(transition_parameter.has_param(Vector2.ONE))
	assert_true(transition_parameter.has_param(true))
	assert_true(transition_parameter.has_param(dmg))


func test_has_param_value_integrity_after_lookup() -> void:
	transition_parameter.add_param("stable")
	
	var value = transition_parameter.has_param("stable")
	
	assert_true(value)
	assert_true(transition_parameter.has_param("stable"))
	assert_eq(transition_parameter.params.size(), 1)


func test_has_param_edge_case_empty_string() -> void:
	transition_parameter.add_param("")
	
	assert_true(transition_parameter.has_param(""))
	assert_false(transition_parameter.has_param(" "))


func test_has_param_large_dataset() -> void:
	for i in range(100):
		transition_parameter.add_param(i)
	
	for i in range(100):
		assert_true(transition_parameter.has_param(i))
	
	assert_false(transition_parameter.has_param(101))


func test_has_param_similar_but_not_equal_values() -> void:
	transition_parameter.add_param(1)
	
	assert_true(transition_parameter.has_param(1))
	assert_false(transition_parameter.has_param(1.0)) # depends on equality semantics


func test_has_param_after_mixed_operations() -> void:
	var dmg: Damage = Damage.new()
	
	transition_parameter.add_param("alpha")
	transition_parameter.add_param(dmg)
	transition_parameter.add_param(99)
	
	assert_true(transition_parameter.has_param("alpha"))
	assert_true(transition_parameter.has_param(dmg))
	assert_true(transition_parameter.has_param(99))
	
	assert_false(transition_parameter.has_param("beta"))
	assert_false(transition_parameter.has_param(Damage.new()))
