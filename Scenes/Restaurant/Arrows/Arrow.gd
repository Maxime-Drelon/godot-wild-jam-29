extends Sprite

export var type = "down"

export var neutral = preload("res://Ressources/Restaurant/Arrows/downt_arrow.png")
export var green = preload("res://Ressources/Restaurant/Arrows/down_green_arrow.png")
export var red = preload("res://Ressources/Restaurant/Arrows/down_red_arrow.png")

func set_true():
	texture = green

func set_false():
	texture = red

func set_neutral():
	texture = neutral

func _ready():
	texture = neutral
