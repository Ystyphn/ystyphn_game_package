extends GutTest

var entity_attributes: EntityAttributes


func after_each() -> void:
	entity_attributes = null


func before_each():
	entity_attributes = EntityAttributes.new()


# --- VALID CASE: Minimum values ---
func test_bonus_damage_min_values():
	entity_attributes.set_strength(1)
	entity_attributes.set_dexterity(1)
	
	var result = entity_attributes.get_bonus_damage()
	
	assert_true(result > 0, "Bonus damage should be positive at minimum values")

# --- STRESS CASE: Very large values ---
func test_bonus_damage_large_values():
	entity_attributes.set_strength(10000)
	entity_attributes.set_dexterity(10000)
	
	var result = entity_attributes.get_bonus_damage()
	
	assert_false(is_nan(result), "Bonus damage should not be NaN")
	assert_false(is_inf(result), "Bonus damage should not be infinite")

# --- BREAK CASE: Values below allowed minimum ---
func test_bonus_damage_invalid_low_values():
	entity_attributes.set_strength(0)
	entity_attributes.set_dexterity(0)
	
	var result = entity_attributes.get_bonus_damage()
	
	assert_true(result >= 0, "Bonus damage should not be negative even with invalid input")

# --- BREAK CASE: Negative values ---
func test_bonus_damage_negative_values():
	entity_attributes.set_strength(-10)
	entity_attributes.set_dexterity(-5)
	
	var result = entity_attributes.get_bonus_damage()
	
	assert_true(result >= 0, "Bonus damage should not be negative even with negative stats")

# --- BALANCE CHECK: Strength vs Dexterity contribution ---
func test_bonus_damage_balance():
	entity_attributes.set_strength(10)
	entity_attributes.set_dexterity(10)
	var balanced = entity_attributes.get_bonus_damage()
	
	entity_attributes.set_strength(20)
	entity_attributes.set_dexterity(1)
	var strength_heavy = entity_attributes.get_bonus_damage()
	
	entity_attributes.set_strength(1)
	entity_attributes.set_dexterity(20)
	var dexterity_heavy = entity_attributes.get_bonus_damage()
	
	assert_true(strength_heavy != dexterity_heavy, "Strength and Dexterity should influence differently")
	assert_true(balanced > 0, "Balanced stats should yield valid bonus damage")


# --- CASE 1: Simple baseline (1,1) ---
func test_bonus_damage_expected_min_values():
	entity_attributes.set_strength(1)
	entity_attributes.set_dexterity(1)

	var result = entity_attributes.get_bonus_damage()

	# Manual computation:
	# numerator = (1 * 0.5 + 1 * 0.3) = 0.8
	# denominator = 1 + 0.03 * (2) = 1.06
	# expected = 0.8 / 1.06 ≈ 0.75471698

	var expected = 0.8 / 1.06

	assert_almost_eq(result, expected, 0.0001, "Mismatch at (1,1)")


# --- CASE 2: Pure strength scaling ---
func test_bonus_damage_expected_strength_only():
	entity_attributes.set_strength(10)
	entity_attributes.set_dexterity(1)

	var result = entity_attributes.get_bonus_damage()

	# numerator = (10*0.5 + 1*0.3) = 5.3
	# denominator = 1 + 0.03*(11) = 1.33
	# expected = 5.3 / 1.33

	var expected = 5.3 / 1.33

	assert_almost_eq(result, expected, 0.0001, "Mismatch at (10,1)")


# --- CASE 3: Pure dexterity scaling ---
func test_bonus_damage_expected_dexterity_only():
	entity_attributes.set_strength(1)
	entity_attributes.set_dexterity(10)

	var result = entity_attributes.get_bonus_damage()

	# numerator = (1*0.5 + 10*0.3) = 3.5
	# denominator = 1 + 0.03*(11) = 1.33
	# expected = 3.5 / 1.33

	var expected = 3.5 / 1.33

	assert_almost_eq(result, expected, 0.0001, "Mismatch at (1,10)")


# --- CASE 4: Symmetry sanity check (10,10) ---
func test_bonus_damage_expected_balanced():
	entity_attributes.set_strength(10)
	entity_attributes.set_dexterity(10)

	var result = entity_attributes.get_bonus_damage()

	# numerator = (10*0.5 + 10*0.3) = 8
	# denominator = 1 + 0.03*(20) = 1.6
	# expected = 8 / 1.6 = 5

	var expected = 5.0

	assert_almost_eq(result, expected, 0.0001, "Mismatch at (10,10)")


# --- CASE 5: High stat scaling behavior ---
func test_bonus_damage_expected_high_stats():
	entity_attributes.set_strength(100)
	entity_attributes.set_dexterity(50)

	var result = entity_attributes.get_bonus_damage()

	# numerator = (100*0.5 + 50*0.3) = 50 + 15 = 65
	# denominator = 1 + 0.03*(150) = 1 + 4.5 = 5.5
	# expected = 65 / 5.5

	var expected = 65.0 / 5.5

	assert_almost_eq(result, expected, 0.0001, "Mismatch at (100,50)")


# --- CURVE TEST: Increasing stats gives diminishing returns ---
func test_bonus_damage_diminishing_returns():
	# low baseline
	entity_attributes.set_strength(10)
	entity_attributes.set_dexterity(10)
	var low = entity_attributes.get_bonus_damage()

	# doubled stats
	entity_attributes.set_strength(20)
	entity_attributes.set_dexterity(20)
	var mid = entity_attributes.get_bonus_damage()

	# doubled again
	entity_attributes.set_strength(40)
	entity_attributes.set_dexterity(40)
	var high = entity_attributes.get_bonus_damage()

	# growth should slow down (sublinear scaling)
	var low_to_mid = mid - low
	var mid_to_high = high - mid

	assert_true(mid > low, "Damage should increase with stats")
	assert_true(high > mid, "Damage should increase with stats")

	assert_true(mid_to_high < low_to_mid, "Growth should show diminishing returns")

# --- CURVE TEST: Per-point efficiency decreases as stats rise ---
func test_bonus_damage_efficiency_drop():
	# small stats
	entity_attributes.set_strength(10)
	entity_attributes.set_dexterity(10)
	var base = entity_attributes.get_bonus_damage()

	# +10 stats increment
	entity_attributes.set_strength(20)
	entity_attributes.set_dexterity(20)
	var after_increment = entity_attributes.get_bonus_damage()

	var small_gain = after_increment - base

	# reset to higher baseline
	entity_attributes.set_strength(100)
	entity_attributes.set_dexterity(100)
	var high_base = entity_attributes.get_bonus_damage()

	entity_attributes.set_strength(110)
	entity_attributes.set_dexterity(110)
	var high_after_increment = entity_attributes.get_bonus_damage()

	var high_gain = high_after_increment - high_base

	assert_true(small_gain > high_gain,
		"Each additional stat point should give less benefit at higher values")

# --- CURVE TEST: Function stays bounded (no runaway scaling) ---
func test_bonus_damage_bounded_growth():
	var previous = -INF

	for i in range(10, 501, 50):
		entity_attributes.set_strength(i)
		entity_attributes.set_dexterity(i)
		var value = entity_attributes.get_bonus_damage()

		assert_true(value > previous, "Function should stay monotonic increasing")
		previous = value

	assert_false(is_inf(previous), "Function should remain bounded and not explode")
