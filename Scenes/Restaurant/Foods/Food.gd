extends KinematicBody2D

const GRAVITY = 3000

var velocity = Vector2.ZERO

export var type = "croissant"
export var food_texture = preload("res://Ressources/Restaurant/Food/smol_croissant.png")
export var saturation = 50


func _ready():
	$Sprite.texture = food_texture
	set_physics_process(false)

func _physics_process(delta):
	velocity.y += GRAVITY * delta
	var collision = move_and_collide(velocity * delta)
	if collision != null:
		_on_impact(collision.normal)

func launch(target_position):
	var temp = global_transform
	var scene = get_tree().current_scene
	get_parent().remove_child(self)
	scene.add_child(self)
	global_transform = temp
	
	var arc_height = target_position.y - global_position.y - 32
	arc_height = min(arc_height, -32)
	
	velocity = PhysicsHelper.calculate_arc_velocity(global_position, target_position, arc_height)
	
	set_physics_process(true)

func _on_impact(normal: Vector2):
	pass
