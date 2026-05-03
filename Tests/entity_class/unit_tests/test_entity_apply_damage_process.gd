extends GutTest


var entity: FakeEntity


func after_each() -> void:
	entity = null


func before_each() -> void:
	entity = FakeEntity.new()


func test_apply_damage_calls_necessary_functions_of_subcomponents() -> void:
	var attributes: EntityAttributes = double(EntityAttributes).new()
	var damage: Damage = double(Damage).new()
	var sm: StateMachine = double(StateMachine).new()
	var debuff: Debuff = double(Debuff).new()
	
	stub(attributes.get_bonus_defense).to_return(12.0)
	stub(attributes.get_health).to_return(100.0)
	stub(damage.get_damage).to_return(25.0)
	stub(damage.get_debuff).to_return(debuff)
	
	entity.set_state_machine(sm)
	entity.set_entity_attributes(attributes)
	
	entity.apply_damage(damage)
	
	assert_called(sm.transition_to.bind("hurt", null))
	assert_called(attributes.get_bonus_defense)
	assert_called(attributes.set_health.bind(83.11))
	assert_called(attributes.add_debuff.bind(debuff))


func test_apply_damage_basic_case() -> void:
	var attributes = double(EntityAttributes).new()
	var damage = double(Damage).new()
	var sm = double(StateMachine).new()
	var debuff = double(Debuff).new()
	
	# Arrange
	stub(attributes.get_bonus_defense).to_return(12.0)
	stub(attributes.get_health).to_return(100.0)
	stub(damage.get_damage).to_return(25.0)
	stub(damage.get_debuff).to_return(debuff)
	
	entity.set_entity_attributes(attributes)
	entity.set_state_machine(sm)
	
	# Act
	entity.apply_damage(damage)
	
	# Expected calculation:
	# final_dmg = 25 * (25 / (25 + 12)) = 16.89189...
	# rounded = 16.89
	var expected_health = 100.0 - 16.89
	
	# Assert
	assert_called(attributes.get_bonus_defense)
	assert_called(attributes.set_health.bind(expected_health))
	assert_called(attributes.add_debuff.bind(debuff))
	assert_called(sm.transition_to.bind("hurt", null))


func test_apply_damage_zero_defense() -> void:
	var attributes = double(EntityAttributes).new()
	var damage = double(Damage).new()
	var sm = double(StateMachine).new()
	var debuff = double(Debuff).new()
	
	stub(attributes.get_bonus_defense).to_return(0.0)
	stub(attributes.get_health).to_return(100.0)
	stub(damage.get_damage).to_return(50.0)
	stub(damage.get_debuff).to_return(debuff)
	
	entity.set_entity_attributes(attributes)
	entity.set_state_machine(sm)
	
	entity.apply_damage(damage)
	
	# final_dmg = 50 * (50 / 50) = 50
	var expected_health = 50.0
	
	assert_called(attributes.set_health.bind(expected_health))
	assert_called(attributes.add_debuff.bind(debuff))
	assert_called(sm.transition_to.bind("hurt", null))


func test_apply_damage_high_defense() -> void:
	var attributes = double(EntityAttributes).new()
	var damage = double(Damage).new()
	var sm = double(StateMachine).new()
	var debuff = double(Debuff).new()
	
	stub(attributes.get_bonus_defense).to_return(1000.0)
	stub(attributes.get_health).to_return(100.0)
	stub(damage.get_damage).to_return(50.0)
	stub(damage.get_debuff).to_return(debuff)
	
	entity.set_entity_attributes(attributes)
	entity.set_state_machine(sm)
	
	entity.apply_damage(damage)
	
	# final_dmg ≈ 50 * (50 / 1050) ≈ 2.38
	var expected_health = 100.0 - 2.38
	
	assert_called(attributes.set_health.bind(expected_health))
	assert_called(attributes.add_debuff.bind(debuff))
	assert_called(sm.transition_to.bind("hurt", null))


func test_apply_damage_rounding() -> void:
	var attributes = double(EntityAttributes).new()
	var damage = double(Damage).new()
	var sm = double(StateMachine).new()
	var debuff = double(Debuff).new()
	
	stub(attributes.get_bonus_defense).to_return(3.0)
	stub(attributes.get_health).to_return(100.0)
	stub(damage.get_damage).to_return(10.0)
	stub(damage.get_debuff).to_return(debuff)
	
	entity.set_entity_attributes(attributes)
	entity.set_state_machine(sm)
	
	entity.apply_damage(damage)
	
	# final_dmg = 10 * (10 / 13) ≈ 7.6923 → 7.69
	var expected_health = 92.31
	
	assert_called(attributes.set_health.bind(expected_health))
