extends GutTest

var transition_parameter: TransitionParameter

func before_each() -> void:
	transition_parameter = TransitionParameter.new()


func test_add_param_can_add_values() -> void:
	var dmg: Damage = Damage.new()
	
	transition_parameter.add_param("softcore")
	transition_parameter.add_param(dmg)
	transition_parameter.add_param(1)
	
	assert_eq(transition_parameter.params.size(), 3)
	assert_eq(transition_parameter.params[0], "softcore")
	assert_eq(transition_parameter.params[1], dmg)
	assert_eq(transition_parameter.params[2], 1)


func test_add_param_preserves_insertion_order() -> void:
	transition_parameter.add_param("a")
	transition_parameter.add_param("b")
	transition_parameter.add_param("c")
	
	assert_eq(transition_parameter.params, ["a", "b", "c"])


func test_add_param_cannot_add_duplicate_values() -> void:
	var dmg: Damage = Damage.new()
	
	transition_parameter.add_param(dmg)
	transition_parameter.add_param(dmg)
	transition_parameter.add_param(1)
	transition_parameter.add_param(1)
	
	assert_eq(transition_parameter.params.size(), 2)
	assert_eq(transition_parameter.params[0], dmg)
	assert_eq(transition_parameter.params[1], 1)


func test_add_param_allows_different_instances_with_same_value() -> void:
	var dmg1: Damage = Damage.new()
	var dmg2: Damage = Damage.new()
	
	transition_parameter.add_param(dmg1)
	transition_parameter.add_param(dmg2)
	
	assert_eq(transition_parameter.params.size(), 2)
	assert_eq(transition_parameter.params[0], dmg1)
	assert_eq(transition_parameter.params[1], dmg2)


func test_add_param_accepts_various_types() -> void:
	transition_parameter.add_param("string")
	transition_parameter.add_param(1)
	transition_parameter.add_param(1.5)
	transition_parameter.add_param(Vector2.ONE)
	transition_parameter.add_param(true)
	
	assert_eq(transition_parameter.params.size(), 5)


func test_add_param_allows_null_value() -> void:
	transition_parameter.add_param(null)
	
	assert_eq(transition_parameter.params.size(), 1)
	assert_null(transition_parameter.params[0])


func test_add_param_prevents_duplicate_null() -> void:
	transition_parameter.add_param(null)
	transition_parameter.add_param(null)
	
	assert_eq(transition_parameter.params.size(), 1)


func test_add_param_value_integrity() -> void:
	var value := "test"
	transition_parameter.add_param(value)
	
	assert_true(value in transition_parameter.params)


func test_add_param_does_not_modify_existing_values() -> void:
	var value := "original"
	transition_parameter.add_param(value)
	
	value = "changed" # mutate local reference
	
	assert_eq(transition_parameter.params[0], "original")
