extends GutTest


class FakeBuff extends Buff:
	func _tick(_delta):
		pass


var buff: Buff


func before_each() -> void:
	buff = FakeBuff.new()


func test_setget_buff_name() -> void:
	buff.set_name("Heal I")
	assert_eq(buff.get_name(), "Heal I")
