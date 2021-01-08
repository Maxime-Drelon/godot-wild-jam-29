extends Node2D

signal _splash_screen_timeout

func _ready():
	$Timer.start()
	$Text.interpolate_property($Label, "percent_visible", 0, 1, 1, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$Text.start()

func _on_Timer_timeout():
	emit_signal("_splash_screen_timeout")
	queue_free()
