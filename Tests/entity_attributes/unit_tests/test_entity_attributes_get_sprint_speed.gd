extends GutTest

var entity_attributes: EntityAttributes

const BASE_SPEED = 20.0
const EPSILON = 0.0001

func before_each():
	entity_attributes = EntityAttributes.new()

# =========================================================
# SECTION 1: STANDARD TESTING
# =========================================================

func test_sprint_speed_basic_case():
	entity_attributes.__agility = 10
	entity_attributes.__strength = 10
	entity_attributes.__endurance = 10
	entity_attributes.__weight = 10
	entity_attributes.__health = 100
	entity_attributes.__max_health = 100
	
	var result = entity_attributes.get_sprint_speed()
	assert_true(result > 0)

func test_sprint_speed_low_stats():
	entity_attributes.__agility = 0.01
	entity_attributes.__strength = 0.01
	entity_attributes.__endurance = 0.01
	entity_attributes.__weight = 0.01
	entity_attributes.__health = 0.01
	entity_attributes.__max_health = 0.01
	
	var result = entity_attributes.get_sprint_speed()
	assert_true(result > 0)

func test_sprint_speed_high_stats():
	entity_attributes.__agility = 1000
	entity_attributes.__strength = 1000
	entity_attributes.__endurance = 1000
	entity_attributes.__weight = 1
	entity_attributes.__health = 1000
	entity_attributes.__max_health = 1000
	
	var result = entity_attributes.get_sprint_speed()
	assert_true(result > 0)

func test_sprint_speed_high_weight_penalty():
	entity_attributes.__agility = 10
	entity_attributes.__strength = 1
	entity_attributes.__endurance = 10
	entity_attributes.__weight = 1000
	entity_attributes.__health = 100
	entity_attributes.__max_health = 100
	
	var result = entity_attributes.get_sprint_speed()
	assert_true(result < 40) # Should be heavily penalized


# =========================================================
# SECTION 2: EXPECTED VALUE CHECKS
# =========================================================
func test_sprint_speed_expected_value_mid_case():
	entity_attributes.__agility = 9
	entity_attributes.__strength = 9
	entity_attributes.__endurance = 9
	entity_attributes.__weight = 9
	entity_attributes.__health = 100
	entity_attributes.__max_health = 100
	
	# Use actual function instead of duplicating formula
	var walk_speed = entity_attributes.get_speed()
	
	var k: float = 5.0
	var speed_boost = 1.0 + (log(1.0 + 9.0) + 0.5 * log(1.0 + 9.0)) / k
	var penalty: float = 1.0 - ((100.0 - 100.0) / 100.0) * (1.0 / (1.0 + 0.5 * 9.0))
	
	var expected = walk_speed + (walk_speed * (speed_boost - 1)) * penalty
	var result = entity_attributes.get_sprint_speed()
	
	assert_almost_eq(result, expected, EPSILON)


func test_sprint_speed_expected_with_health_penalty():
	entity_attributes.__agility = 10
	entity_attributes.__strength = 10
	entity_attributes.__endurance = 10
	entity_attributes.__weight = 10
	entity_attributes.__health = 50
	entity_attributes.__max_health = 100
	
	var walk_speed = entity_attributes.get_speed()
	var speed_boost = 1 + (log(1 + 10) + 0.5 * log(1 + 10)) / 5.0
	var penalty = 1 - (50.0/100.0) * (1 / (1 + 0.5 * 10))
	
	var expected = walk_speed + (walk_speed * (speed_boost - 1)) * penalty
	var result = entity_attributes.get_sprint_speed()
	
	assert_almost_eq(result, expected, EPSILON)


# =========================================================
# SECTION 3: CURVE BEHAVIOR TESTS (BREAKING TESTS)
# =========================================================

func test_agility_increases_speed_monotonically():
	entity_attributes.__strength = 10
	entity_attributes.__endurance = 10
	entity_attributes.__weight = 10
	entity_attributes.__health = 100
	entity_attributes.__max_health = 100
	
	entity_attributes.__agility = 1
	var low = entity_attributes.get_sprint_speed()
	
	entity_attributes.__agility = 50
	var high = entity_attributes.get_sprint_speed()
	
	assert_true(high > low)

func test_strength_reduces_weight_penalty():
	entity_attributes.__agility = 10
	entity_attributes.__endurance = 10
	entity_attributes.__weight = 100
	entity_attributes.__health = 100
	entity_attributes.__max_health = 100
	
	entity_attributes.__strength = 1
	var low = entity_attributes.get_sprint_speed()
	
	entity_attributes.__strength = 50
	var high = entity_attributes.get_sprint_speed()
	
	assert_true(high > low)

func test_health_penalty_reduces_speed():
	entity_attributes.__agility = 10
	entity_attributes.__strength = 10
	entity_attributes.__endurance = 10
	entity_attributes.__weight = 10
	entity_attributes.__max_health = 100
	
	entity_attributes.__health = 100
	var full_hp = entity_attributes.get_sprint_speed()
	
	entity_attributes.__health = 10
	var low_hp = entity_attributes.get_sprint_speed()
	
	assert_true(low_hp < full_hp)

func test_endurance_softens_health_penalty():
	entity_attributes.__agility = 10
	entity_attributes.__strength = 10
	entity_attributes.__weight = 10
	entity_attributes.__health = 10
	entity_attributes.__max_health = 100
	
	entity_attributes.__endurance = 1
	var low_end = entity_attributes.get_sprint_speed()
	
	entity_attributes.__endurance = 50
	var high_end = entity_attributes.get_sprint_speed()
	
	assert_true(high_end > low_end)

func test_extreme_low_health_edge_case():
	entity_attributes.__agility = 10
	entity_attributes.__strength = 10
	entity_attributes.__endurance = 0.01
	entity_attributes.__weight = 10
	entity_attributes.__health = 0.01
	entity_attributes.__max_health = 100
	
	var result = entity_attributes.get_sprint_speed()
	assert_true(result > 0) # Should not collapse to zero or negative

func test_no_nan_or_inf():
	entity_attributes.__agility = 10000
	entity_attributes.__strength = 10000
	entity_attributes.__endurance = 10000
	entity_attributes.__weight = 10000
	entity_attributes.__health = 0.01
	entity_attributes.__max_health = 10000
	
	var result = entity_attributes.get_sprint_speed()
	assert_false(is_nan(result))
	assert_false(is_inf(result))


# =========================================================
# HELPER FUNCTION
# =========================================================

func _expected_walk_speed(a, s, w):
	var bonus = 1 + log(1 + a)
	var penalty = 1 + (w / (s + 1))
	return BASE_SPEED * (bonus / penalty)
