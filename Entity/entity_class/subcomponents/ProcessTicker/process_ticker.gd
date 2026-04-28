extends Timer
class_name ProcessTicker


signal tick_finished(_delta: float)


func _on_process_tick() -> void:
	emit_signal("tick_finished", get_wait_time())


func _ready() -> void:
	set_wait_time(Globals.ATTRIBUTES_TICK_TIME)
