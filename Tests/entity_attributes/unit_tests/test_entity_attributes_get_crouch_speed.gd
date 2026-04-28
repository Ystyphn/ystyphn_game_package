extends GutTest

var entity_attributes: EntityAttributes

const BASE_SPEED := 10.0


func before_each():
	entity_attributes = EntityAttributes.new()


# =========================================================
# SECTION 1: STANDARD TESTING
# =========================================================

func test_crouch_speed_standard_case():
	entity_attributes.__agility = 1.0
	entity_attributes.__strength = 1.0
	entity_attributes.__weight = 1.0
	entity_attributes.__health = 100.0
	entity_attributes.__max_health = 100.0

	var speed = entity_attributes.get_speed()
	var crouch = entity_attributes.get_crouch_speed()

	assert_not_null(speed)
	assert_not_null(crouch)
	assert_gt(speed, 0)
	assert_gt(crouch, 0)


func test_crouch_speed_high_agility_low_weight():
	entity_attributes.__agility = 10.0
	entity_attributes.__strength = 2.0
	entity_attributes.__weight = 1.0
	entity_attributes.__health = 100.0
	entity_attributes.__max_health = 100.0

	var crouch = entity_attributes.get_crouch_speed()
	assert_gt(crouch, 0)


# =========================================================
# SECTION 2: EXPECTED VALUE CHECKS
# =========================================================

func test_crouch_speed_exact_expected_values():
	entity_attributes.__agility = 1.0
	entity_attributes.__strength = 1.0
	entity_attributes.__weight = 1.0
	entity_attributes.__health = 100.0
	entity_attributes.__max_health = 100.0

	# --- SPEED ---
	var bonus = 1.0 + log(1.0 + 1.0) # ln(2)
	var penalty = 1.0 + (1.0 / (1.0 + 1.0))
	var expected_speed = BASE_SPEED * (bonus / penalty)

	# --- CROUCH ---
	var a = 0.3
	var health_penalty = entity_attributes.__health / entity_attributes.__max_health
	var weight_penalty = 1.0 + (1.0 / (1.0 + 1.0))
	var crouch_penalty = (1.0 / weight_penalty) * health_penalty
	var expected_crouch = expected_speed * a * crouch_penalty

	assert_almost_eq(entity_attributes.get_speed(), expected_speed, 0.0001)
	assert_almost_eq(entity_attributes.get_crouch_speed(), expected_crouch, 0.0001)


# =========================================================
# SECTION 3: CURVE BEHAVIOR TESTS
# =========================================================

func test_crouch_speed_decreases_with_high_weight():
	# Light build
	entity_attributes.__agility = 1.0
	entity_attributes.__strength = 1.0
	entity_attributes.__weight = 1.0
	entity_attributes.__health = 100.0
	entity_attributes.__max_health = 100.0
	var light = entity_attributes.get_crouch_speed()

	# Heavy build
	entity_attributes.__weight = 50.0
	var heavy = entity_attributes.get_crouch_speed()

	assert_lt(heavy, light)


func test_crouch_speed_decreases_with_low_health():
	# Full health
	entity_attributes.__agility = 1.0
	entity_attributes.__strength = 1.0
	entity_attributes.__weight = 1.0
	entity_attributes.__health = 100.0
	entity_attributes.__max_health = 100.0
	var full = entity_attributes.get_crouch_speed()

	# Low health
	entity_attributes.__health = 10.0
	var low = entity_attributes.get_crouch_speed()

	assert_lt(low, full)


func test_crouch_speed_never_breaks_minimum_values():
	# Extreme low stats (edge case safety test)
	entity_attributes.__agility = 0.01
	entity_attributes.__strength = 0.01
	entity_attributes.__weight = 0.01
	entity_attributes.__health = 0.01
	entity_attributes.__max_health = 0.01

	var speed = entity_attributes.get_speed()
	var crouch = entity_attributes.get_crouch_speed()

	assert_not_null(speed)
	assert_not_null(crouch)
	assert_true(is_finite(speed))
	assert_true(is_finite(crouch))
	assert_gt(crouch, 0)
