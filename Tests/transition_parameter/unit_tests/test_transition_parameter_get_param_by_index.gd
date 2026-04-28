extends GutTest


var transition_parameter: TransitionParameter


func before_each() -> void:
	transition_parameter = TransitionParameter.new()


func test_get_param_by_index_can_return_existing_values() -> void:
	transition_parameter.add_param(1)
	transition_parameter.add_param(2)
	transition_parameter.add_param(3)
	
	assert_not_null(transition_parameter.get_param_by_index(0))
	assert_not_null(transition_parameter.get_param_by_index(1))
	assert_not_null(transition_parameter.get_param_by_index(2))


func test_get_param_by_index_will_return_null_if_the_specified_index_is_out_of_bounds() -> void:
	transition_parameter.add_param(1)
	transition_parameter.add_param(2)
	
	assert_not_null(transition_parameter.get_param_by_index(-1))
	assert_not_null(transition_parameter.get_param_by_index(-2))
	
	assert_null(transition_parameter.get_param_by_index(-3))
	assert_push_error("Specified index is out of bounds!")
	assert_null(transition_parameter.get_param_by_index(4))
	assert_push_error("Specified index is out of bounds!")


# ------------------ EXTENSIONS ------------------


func test_get_param_by_index_returns_correct_values() -> void:
	transition_parameter.add_param("a")
	transition_parameter.add_param("b")
	transition_parameter.add_param("c")
	
	assert_eq(transition_parameter.get_param_by_index(0), "a")
	assert_eq(transition_parameter.get_param_by_index(1), "b")
	assert_eq(transition_parameter.get_param_by_index(2), "c")


func test_get_param_by_index_supports_negative_indexing() -> void:
	transition_parameter.add_param(10)
	transition_parameter.add_param(20)
	transition_parameter.add_param(30)
	
	assert_eq(transition_parameter.get_param_by_index(-1), 30)
	assert_eq(transition_parameter.get_param_by_index(-2), 20)
	assert_eq(transition_parameter.get_param_by_index(-3), 10)


func test_get_param_by_index_negative_index_out_of_bounds() -> void:
	transition_parameter.add_param(1)
	transition_parameter.add_param(2)
	
	assert_null(transition_parameter.get_param_by_index(-3))
	assert_push_error("Specified index is out of bounds!")


func test_get_param_by_index_positive_index_out_of_bounds_exact_size() -> void:
	transition_parameter.add_param(1)
	transition_parameter.add_param(2)
	
	# This is a critical boundary test (idx == size)
	assert_null(transition_parameter.get_param_by_index(2))
	assert_push_error("Specified index is out of bounds!")


func test_get_param_by_index_positive_index_far_out_of_bounds() -> void:
	transition_parameter.add_param(1)
	
	assert_null(transition_parameter.get_param_by_index(100))
	assert_push_error("Specified index is out of bounds!")


func test_get_param_by_index_on_empty_params() -> void:
	assert_null(transition_parameter.get_param_by_index(0))
	assert_push_error("Specified index is out of bounds!")
	
	assert_null(transition_parameter.get_param_by_index(-1))
	assert_push_error("Specified index is out of bounds!")


func test_get_param_by_index_returns_same_object_reference() -> void:
	var dmg: Damage = Damage.new()
	transition_parameter.add_param(dmg)
	
	var retrieved = transition_parameter.get_param_by_index(0)
	assert_eq(retrieved, dmg)


func test_get_param_by_index_does_not_mutate_internal_state() -> void:
	transition_parameter.add_param(1)
	transition_parameter.add_param(2)
	
	var _value = transition_parameter.get_param_by_index(0)
	
	assert_eq(transition_parameter.params.size(), 2)
	assert_eq(transition_parameter.get_param_by_index(0), 1)
	assert_eq(transition_parameter.get_param_by_index(1), 2)


func test_get_param_by_index_handles_null_values() -> void:
	transition_parameter.add_param(null)
	
	assert_null(transition_parameter.get_param_by_index(0))


func test_get_param_by_index_mixed_types_integrity() -> void:
	var dmg: Damage = Damage.new()
	
	transition_parameter.add_param("text")
	transition_parameter.add_param(42)
	transition_parameter.add_param(dmg)
	
	assert_eq(transition_parameter.get_param_by_index(0), "text")
	assert_eq(transition_parameter.get_param_by_index(1), 42)
	assert_eq(transition_parameter.get_param_by_index(2), dmg)
