extends GutTest


func test_setget_agility() -> void:
	var physical_attributes = PhysicalAttributes.new()
	physical_attributes.set_agility(5.0)
	assert_eq(physical_attributes.get_agility(), 5.0, "Testing the setter and getter of agility")

func test_setget_dexterity() -> void:
	var physical_attributes = PhysicalAttributes.new()
	physical_attributes.set_dexterity(5.0)
	assert_eq(physical_attributes.get_dexterity(), 5.0, "Testing the setter and getter of dexterity")

func test_setget_endurance() -> void:
	var physical_attributes = PhysicalAttributes.new()
	physical_attributes.set_endurance(5.0)
	assert_eq(physical_attributes.get_endurance(), 5.0, "Testing the setter and getter of endurance")

func test_setget_health() -> void:
	var physical_attributes = PhysicalAttributes.new()
	physical_attributes.set_health(5.0)
	assert_eq(physical_attributes.get_health(), 5.0, "Testing the setter and getter of health")

func test_setget_intelligence() -> void:
	var physical_attributes = PhysicalAttributes.new()
	physical_attributes.set_intelligence(5.0)
	assert_eq(physical_attributes.get_intelligence(), 5.0, "Testing the setter and getter of intelligence")

func test_setget_max_health() -> void:
	var physical_attributes = PhysicalAttributes.new()
	physical_attributes.set_max_health(5.0)
	assert_eq(physical_attributes.get_max_health(), 5.0, "Testing the setter and getter of max_health")

func test_setget_stamina() -> void:
	var physical_attributes = PhysicalAttributes.new()
	physical_attributes.set_stamina(5.0)
	assert_eq(physical_attributes.get_stamina(), 5.0, "Testing the setter and getter of stamina")

func test_setget_strength() -> void:
	var physical_attributes = PhysicalAttributes.new()
	physical_attributes.set_strength(5.0)
	assert_eq(physical_attributes.get_strength(), 5.0, "Testing the setter and getter of strength")

func test_setget_weight() -> void:
	var physical_attributes = PhysicalAttributes.new()
	physical_attributes.set_weight(5.0)
	assert_eq(physical_attributes.get_weight(), 5.0, "Testing the setter and getter of weight")
