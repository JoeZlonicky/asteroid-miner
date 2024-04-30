class_name SpeedLabel
extends Label


const SPEED_UNIT = "m/s"


func update_text(speed: float) -> void:
	speed = ceilf(speed - 0.01)  # Offset so it doesn't occasionally +1
	speed = maxf(speed, 0.0)
	text = str(speed) + SPEED_UNIT
