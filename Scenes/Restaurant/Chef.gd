extends KinematicBody2D

const FOOD = preload("res://Scenes/Restaurant/Foods/Food.tscn")

const ARROWS = [
	preload("res://Scenes/Restaurant/Arrows/Arrow1.tscn"),
	preload("res://Scenes/Restaurant/Arrows/Arrow2.tscn"),
	preload("res://Scenes/Restaurant/Arrows/Arrow3.tscn"),
	preload("res://Scenes/Restaurant/Arrows/Arrow4.tscn")
]

onready var pos = [
	$Arrow1,
	$Arrow2,
	$Arrow3,
	$Arrow4
]

const arrows_values = [
	"down",
	"left",
	"right",
	"up"
]

var SPEED = 300

var direction
var moving

var combo = Array()
var solved

var food

func _ready():
	direction = -1
	moving = true
	
	solved = generate_filled_array(food.difficulty, 0)
	
	generate_combo()
	
	var new_food = FOOD.instance()
	
	new_food.type = food.name
	new_food.saturation = food.saturation
	new_food.food_texture = load(food.sprite)
	new_food.position = $Dish.position
	add_child(new_food)

func generate_filled_array(size, value):
	var array = Array()
	
	for i in range(size):
		array.append(value)
	
	return array

func generate_combo():
	for i in range(0, food.difficulty):
		var arrow = ARROWS[rand_range(0, 4)].instance()
		if food.difficulty == 2:
			arrow.position = pos[i + 1].position
		else:
			arrow.position = pos[i].position
		add_child(arrow)
		combo.append(arrow)

func _process(_delta):
	var velocity = Vector2.ZERO
	
	if moving:
		velocity.x = SPEED * direction
		move_and_slide(velocity)

func get_food(position):
	$Food.launch(position)
	$AnimatedSprite.play("default")

func check_if_valid(input, counter):
	if combo[counter].type == input:
		solved[counter] = 1
		combo[counter].set_true()
	else:
		reset_combo()

func reset_combo():
	solved = generate_filled_array(food.difficulty, 0)
	$Bad.play()
	set_all_arrows("neutral")

func check_if_validated():
	if solved == generate_filled_array(food.difficulty, 1):
		$Good.play()
		return true
	return false

func clear_combo():
	for arrow in combo:
		arrow.queue_free()

func set_all_arrows(color):
	for el in combo:
		if color == "red":
			el.set_false()
		elif color == "neutral":
			el.set_neutral()
		else:
			el.set_true()

func process_input(input):
	if direction == 1:
		return
	
	var counter = 0

	for el in solved:
		if el == 0:
			check_if_valid(input, counter)
			return
		counter += 1

func turn_around():
	$Wait.start()
	if !check_if_validated():
		set_all_arrows("red")
	moving = false
	direction = 1

func _on_Wait_timeout():
	direction = 1
	$AnimatedSprite.flip_h = false
	moving = true
