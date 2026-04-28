extends GutTest

var entity_attributes: EntityAttributes


func before_each():
	entity_attributes = EntityAttributes.new()


# =========================================================
# SECTION 1: STANDARD TESTING
# =========================================================

func test_critical_multiplier_basic_case():
	entity_attributes.set_strength(10.0)
	entity_attributes.set_dexterity(10.0)
	entity_attributes.set_intelligence(10.0)
	entity_attributes.set_rage(10.0)

	var result: float = entity_attributes.get_critical_multiplier()

	assert_not_null(result)
	assert_true(result > 1.0)


func test_critical_multiplier_low_stats_min_values():
	# all attributes forced to minimum (0.01)
	entity_attributes.set_strength(0.01)
	entity_attributes.set_dexterity(0.01)
	entity_attributes.set_intelligence(0.01)
	entity_attributes.set_rage(0.01)

	var result: float = entity_attributes.get_critical_multiplier()

	assert_true(result > 1.0)
	assert_almost_eq(result, 1.0 + (0.04*0.01 + 0.05*0.01 + 0.03*0.01) + 0.02*0.01 + 0.01*(0.01*0.01), 0.00001)


func test_critical_multiplier_high_rage_scaling():
	entity_attributes.set_strength(10.0)
	entity_attributes.set_dexterity(5.0)
	entity_attributes.set_intelligence(5.0)
	entity_attributes.set_rage(100.0)

	var low_rage_result = entity_attributes.get_critical_multiplier()

	entity_attributes.set_rage(200.0)
	var high_rage_result = entity_attributes.get_critical_multiplier()

	assert_true(high_rage_result > low_rage_result)


# =========================================================
# SECTION 2: EXPECTED VALUE CHECKS
# =========================================================

func test_critical_multiplier_exact_value_case():
	entity_attributes.set_strength(10.0)
	entity_attributes.set_dexterity(20.0)
	entity_attributes.set_intelligence(30.0)
	entity_attributes.set_rage(40.0)

	var result: float = entity_attributes.get_critical_multiplier()

	var expected: float = 1 \
	+ (0.04 * 10.0 + 0.05 * 20.0 + 0.03 * 30.0) \
	+ (0.02 * 40.0) \
	+ (0.01 * (40.0 * 10.0))

	assert_almost_eq(result, expected, 0.00001)


func test_critical_multiplier_extreme_strength_break_test():
	# stress test: very high strength + rage synergy explosion check
	entity_attributes.set_strength(1000.0)
	entity_attributes.set_dexterity(10.0)
	entity_attributes.set_intelligence(10.0)
	entity_attributes.set_rage(1000.0)

	var result: float = entity_attributes.get_critical_multiplier()

	# manual expected computation
	var expected: float = 1 \
	+ (0.04 * 1000.0 + 0.05 * 10.0 + 0.03 * 10.0) \
	+ (0.02 * 1000.0) \
	+ (0.01 * (1000.0 * 1000.0))

	# This is intentionally a "break test" — should reveal scaling explosion risk
	assert_almost_eq(result, expected, 0.0001)


func test_critical_multiplier_min_value_stability_under_reassignment():
	# ensures setters enforce minimum 0.01 and do not allow collapse
	entity_attributes.set_strength(0.0)
	entity_attributes.set_dexterity(-50.0)
	entity_attributes.set_intelligence(-999.0)
	entity_attributes.set_rage(-10.0)

	var result: float = entity_attributes.get_critical_multiplier()

	assert_true(result > 1.0)
	assert_almost_eq(result, entity_attributes.get_critical_multiplier(), 0.000001)
