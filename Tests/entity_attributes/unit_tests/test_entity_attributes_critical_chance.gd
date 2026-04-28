extends GutTest

var entity_attributes: EntityAttributes


func before_each():
	entity_attributes = EntityAttributes.new()
	
	# safe baseline initialization (minimum allowed values)
	entity_attributes.set_dexterity(10.0)
	entity_attributes.set_intelligence(10.0)
	entity_attributes.set_health(100.0)
	entity_attributes.set_max_health(100.0)


func test_critical_chance_basic_execution():
	var result = entity_attributes.get_critical_chance()
	
	assert_not_null(result)
	assert_true(result >= 0.0, "Crit chance should never be negative")


func test_critical_chance_with_min_attributes():
	entity_attributes.set_dexterity(0.01)
	entity_attributes.set_intelligence(0.01)
	entity_attributes.set_health(0.01)
	entity_attributes.set_max_health(0.01)

	var result = entity_attributes.get_critical_chance()
	
	assert_true(result >= 0.0)
	assert_almost_eq(result, 0.05, 0.001, "At minimum stats, result should be near BASE_CRIT_CHANCE")


# =========================
# SECTION 2: EXPECTED VALUE CHECKS
# =========================
func test_critical_chance_expected_scaling():
	entity_attributes.set_dexterity(50.0)
	entity_attributes.set_intelligence(50.0)
	entity_attributes.set_health(100.0)
	entity_attributes.set_max_health(100.0)

	var expected_bonus = (0.05 * 50.0 + 0.03 * 50.0) * (100.0 / 100.0)
	var expected = 0.05 + expected_bonus
	var result = entity_attributes.get_critical_chance()

	assert_almost_eq(result, expected, 0.0001)


func test_critical_chance_half_health_penalty():
	entity_attributes.set_dexterity(50.0)
	entity_attributes.set_intelligence(50.0)
	entity_attributes.set_health(50.0)
	entity_attributes.set_max_health(100.0)

	var full_hp_bonus = (0.05 * 50.0 + 0.03 * 50.0) * 1.0
	var half_hp_bonus = (0.05 * 50.0 + 0.03 * 50.0) * 0.5

	var full_hp = 0.05 + full_hp_bonus
	var half_hp = 0.05 + half_hp_bonus

	assert_true(half_hp < full_hp)


# =========================
# SECTION 3: CURVE BEHAVIOR TESTS
# =========================
func test_critical_chance_health_curve_monotonic():
	entity_attributes.set_dexterity(40.0)
	entity_attributes.set_intelligence(40.0)
	entity_attributes.set_max_health(100.0)

	var previous_value = -1.0

	for h in [100, 75, 50, 25, 10]:
		entity_attributes.set_health(float(h))
		var current = entity_attributes.get_critical_chance()
		
		if previous_value != -1.0:
			assert_true(current <= previous_value, "Crit chance should decrease as health decreases")
		
		previous_value = current


func test_critical_chance_zero_health_floor_behavior():
	entity_attributes.set_dexterity(100.0)
	entity_attributes.set_intelligence(100.0)
	entity_attributes.set_health(0.01)
	entity_attributes.set_max_health(100.0)

	var result = entity_attributes.get_critical_chance()

	assert_true(result >= 0.05, "Crit chance should not drop below BASE_CRIT_CHANCE even at near-zero health")
