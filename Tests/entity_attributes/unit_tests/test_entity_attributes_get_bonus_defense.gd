extends GutTest

var entity_attributes: EntityAttributes


func after_each():
	entity_attributes = null


func before_each():
	entity_attributes = EntityAttributes.new()
	
	# Ensure BASE_DEFENSE is untouched (sanity check)
	assert_eq(entity_attributes.BASE_DEFENSE, 10)


# =========================================================
# SECTION 1: STANDARD TESTING
# =========================================================

func test_standard_mid_values():
	entity_attributes.set_strength(10.0)
	entity_attributes.set_endurance(10.0)
	entity_attributes.set_max_health(100.0)
	entity_attributes.set_health(100.0)
	
	var result = entity_attributes.get_bonus_defense()
	
	# manual:
	# bonus_def = 1 + 0.03*10 + 0.02*10 = 1 + 0.3 + 0.2 = 1.5
	# penalty = 1 - 0.5 * (0/100) = 1
	# expected = 10 * 1.5 * 1 = 15
	assert_almost_eq(result, 15.0, 0.0001)


func test_low_attributes_min_bound_behavior():
	entity_attributes.set_strength(0.01)
	entity_attributes.set_endurance(0.01)
	entity_attributes.set_max_health(50.0)
	entity_attributes.set_health(50.0)
	
	var result = entity_attributes.get_bonus_defense()
	
	var bonus_def = 1 + 0.03 * 0.01 + 0.02 * 0.01
	var penalty = 1 - 0.5 * ((50.0 - 50.0) / 50.0)
	var expected = 10 * bonus_def * penalty
	
	assert_almost_eq(result, expected, 0.0001)


# =========================================================
# SECTION 2: EXPECTED VALUE CHECKS
# =========================================================

func test_half_health_penalty_scaling():
	entity_attributes.set_strength(20.0)
	entity_attributes.set_endurance(20.0)
	entity_attributes.set_max_health(100.0)
	entity_attributes.set_health(50.0)
	
	var result = entity_attributes.get_bonus_defense()
	
	# bonus_def = 1 + 0.03*20 + 0.02*20 = 1 + 0.6 + 0.4 = 2.0
	# penalty = 1 - 0.5 * (50/100) = 1 - 0.25 = 0.75
	# expected = 10 * 2.0 * 0.75 = 15
	assert_almost_eq(result, 15.0, 0.0001)


func test_low_health_heavy_penalty():
	entity_attributes.set_strength(15.0)
	entity_attributes.set_endurance(15.0)
	entity_attributes.set_max_health(100.0)
	entity_attributes.set_health(10.0)
	
	var result = entity_attributes.get_bonus_defense()
	
	# bonus_def = 1 + 0.45 + 0.3 = 1.75
	# penalty = 1 - 0.5 * (90/100) = 1 - 0.45 = 0.55
	# expected = 10 * 1.75 * 0.55 = 9.625
	assert_almost_eq(result, 9.625, 0.0001)


func test_full_health_no_penalty():
	entity_attributes.set_strength(5.0)
	entity_attributes.set_endurance(5.0)
	entity_attributes.set_max_health(100.0)
	entity_attributes.set_health(100.0)
	
	var result = entity_attributes.get_bonus_defense()
	
	var bonus_def = 1 + 0.03 * 5.0 + 0.02 * 5.0
	var expected = 10 * bonus_def
	
	assert_almost_eq(result, expected, 0.0001)


# =========================================================
# SECTION 3: CURVE BEHAVIOR TESTS (BREAK / EDGE CASES)
# =========================================================

func test_zero_health_edge_clamped_behavior():
	entity_attributes.set_strength(10.0)
	entity_attributes.set_endurance(10.0)
	entity_attributes.set_max_health(100.0)
	entity_attributes.set_health(0.01) # minimum allowed
	
	var result = entity_attributes.get_bonus_defense()
	
	# Expect heavy penalty but not crash or negative multiplier
	assert_true(result > 0)
	assert_true(is_finite(result))


func test_max_health_near_zero_protection():
	entity_attributes.set_strength(10.0)
	entity_attributes.set_endurance(10.0)
	entity_attributes.set_max_health(0.01) # min bound
	entity_attributes.set_health(0.01)
	
	var result = entity_attributes.get_bonus_defense()
	
	# Should avoid division issues and stay stable
	assert_true(is_finite(result))
	assert_true(result > 0)


func test_health_greater_than_max_health_exploit():
	entity_attributes.set_strength(10.0)
	entity_attributes.set_endurance(10.0)
	entity_attributes.set_max_health(100.0)
	entity_attributes.set_health(150.0)
	
	var result = entity_attributes.get_bonus_defense()
	
	# Penalty should not become > 1 (or should be handled safely)
	assert_true(is_finite(result))
	assert_true(result >= 0)


func test_extreme_strength_endurance_curve_stability():
	entity_attributes.set_strength(1000.0)
	entity_attributes.set_endurance(1000.0)
	entity_attributes.set_max_health(100.0)
	entity_attributes.set_health(1.0)
	
	var result = entity_attributes.get_bonus_defense()
	
	# Ensure no overflow / NaN
	assert_true(is_finite(result))
	assert_true(result > 0)
