extends GutTest

const BASE_SPEED: float = 10.0

var entity_attributes: EntityAttributes

func before_each():
	entity_attributes = EntityAttributes.new()


# =========================================================
# SECTION 1: STANDARD TESTING
# =========================================================

func test_speed_with_minimum_attributes():
	entity_attributes.set_agility(0.01)
	entity_attributes.set_strength(0.01)
	entity_attributes.set_weight(0.01)

	var result: float = entity_attributes.get_speed()

	assert_true(result > 0, "Speed should always be positive")
	assert_almost_eq(result, BASE_SPEED, 0.002, "With minimal stats, speed should be close to base speed")


func test_speed_with_balanced_attributes():
	entity_attributes.set_agility(10)
	entity_attributes.set_strength(10)
	entity_attributes.set_weight(10)

	var result: float = entity_attributes.get_speed()

	assert_true(result > BASE_SPEED, "Balanced stats should generally enhance speed")


# =========================================================
# SECTION 2: EXPECTED VALUE CHECKS
# =========================================================

func test_agility_increase_should_increase_speed():
	entity_attributes.set_agility(1)
	entity_attributes.set_strength(10)
	entity_attributes.set_weight(10)

	var low_speed: float = entity_attributes.get_speed()

	entity_attributes.set_agility(50)

	var high_speed: float = entity_attributes.get_speed()

	assert_true(high_speed > low_speed, "Higher agility must increase speed via log curve")


func test_weight_penalty_should_reduce_speed():
	entity_attributes.set_agility(20)
	entity_attributes.set_strength(20)
	entity_attributes.set_weight(1)

	var low_weight_speed: float = entity_attributes.get_speed()

	entity_attributes.set_weight(100)

	var high_weight_speed: float = entity_attributes.get_speed()

	assert_true(high_weight_speed < low_weight_speed, "Higher weight must reduce speed")


func test_strength_should_reduce_weight_penalty():
	entity_attributes.set_agility(20)
	entity_attributes.set_weight(50)

	entity_attributes.set_strength(1)
	var weak_strength_speed: float = entity_attributes.get_speed()

	entity_attributes.set_strength(100)
	var strong_strength_speed: float = entity_attributes.get_speed()

	assert_true(strong_strength_speed > weak_strength_speed, "Higher strength should reduce penalty and improve speed")


# =========================================================
# SECTION 3: CURVE BEHAVIOR TESTS (BREAK CASES / STRESS TESTS)
# =========================================================

func test_extreme_agility_diminishing_returns():
	entity_attributes.set_agility(1)
	entity_attributes.set_strength(10)
	entity_attributes.set_weight(10)
	var base_speed: float = entity_attributes.get_speed()

	entity_attributes.set_agility(10000)
	var extreme_speed: float = entity_attributes.get_speed()

	# log curve should prevent linear explosion
	assert_true(extreme_speed < base_speed * 10, "Agility scaling should show diminishing returns")


func test_extreme_weight_break_attempt():
	entity_attributes.set_agility(50)
	entity_attributes.set_strength(50)
	entity_attributes.set_weight(100000)

	var result: float = entity_attributes.get_speed()

	assert_true(result > 0, "Speed should never drop to zero or negative even with extreme weight")


func test_low_strength_high_weight_stress_case():
	entity_attributes.set_agility(10)
	entity_attributes.set_strength(0.01)
	entity_attributes.set_weight(1000)

	var result: float = entity_attributes.get_speed()

	assert_true(result < BASE_SPEED, "Extreme weight with low strength should heavily penalize speed")
	assert_true(result > 0, "Speed must remain valid (non-zero, non-negative)")


func test_formula_stability_at_min_bounds():
	entity_attributes.set_agility(0.01)
	entity_attributes.set_strength(0.01)
	entity_attributes.set_weight(0.01)

	var result: float = entity_attributes.get_speed()

	# ensures no division instability or log issues
	assert_true(is_finite(result), "Result must always be finite")
	assert_true(result > 0, "Result must always be positive")
