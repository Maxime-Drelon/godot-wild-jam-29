extends Node2D

const CHEF = preload("res://Scenes/Restaurant/Chef.tscn")

var level

var food = 0
var chef = false

var chefs = Array()
var foods = Array()

func _ready():
	pass

func _physics_process(_delta):
	if food == level.dishes.number and chefs == Array():
		print("level over")
		set_physics_process(false)
	
	if !chef and chefs.size() < level.chefs.max and food < level.dishes.number:
		$ChefDelay.start()
		chef = true
	
	var input = ""
	
	if Input.is_action_just_pressed("down"):
		input = "down"
	elif Input.is_action_just_pressed("right"):
		input = "right"
	elif Input.is_action_just_pressed("up"):
		input = "up"
	elif Input.is_action_just_pressed("left"):
		input = "left"
	
	if input != "":
		for tmp in chefs:
			if tmp.direction == -1:
				tmp.process_input(input)
				feed_player(tmp)
				return

func feed_player(value):
	if value.check_if_validated() and value.direction == -1:
		value.get_food($PlayerPos.global_position)
		value.turn_around()

func _on_Area2D_body_entered(body):
	if body.is_in_group("chefs"):
		chefs.erase(body)
		body.queue_free()

func _on_Table_body_entered(body):
	if body.is_in_group("chefs"):
		if body.direction == -1:
			body.turn_around()

func _on_ChefDelay_timeout():
	chef = false
	var scene = CHEF.instance()
	scene.position = $ChefSpawn.position
	scene.SPEED = level.chefs.speed
	scene.food = level.foods[rand_range(0, level.dishes.variety)]
	add_child(scene)
	chefs.append(scene)
	food += 1


func _on_PlayerArea_body_entered(body):
	if body.is_in_group("food"):
		var prev_size = $Player.frames.get_frame($Player.animation, $Player.frame).get_size() * $Player.scale
		$Player.scale.x += 2
		$Player.scale.y = $Player.scale.y + 0.5
		var new_size = $Player.frames.get_frame($Player.animation, $Player.frame).get_size() * $Player.scale
		$Player.position.y -= (new_size.y - prev_size.y) / 2
		$Player.position.x -= (new_size.x - prev_size.x) / 4
		body.queue_free()
