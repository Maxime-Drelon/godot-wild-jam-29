extends Node2D

var RESTAURANT = preload("res://Scenes/Restaurant/Restaurant.tscn")

var france_level1 = {
	"chefs": {
		"max": 2,
		"speed": 500,
	},
	"dishes": {
		"number": 10,
		"variety": 3
	},
	"foods": [
		{
			"name": "croissant",
			"difficulty": 2,
			"saturation": 15,
			"sprite": "res://Ressources/Restaurant/Food/smol_croissant.png"
		},
		{
			"name": "fromage",
			"difficulty": 2,
			"saturation": 30,
			"sprite": "res://Ressources/Restaurant/Food/fromage.png"
		},
		{
			"name": "baguette",
			"difficulty": 4,
			"saturation": 30,
			"sprite": "res://Ressources/Restaurant/Food/baguette.png"
		}
	]
}

func _ready():
	pass

func _on_SplashScreen__splash_screen_timeout():
	var restaurant = RESTAURANT.instance()
	restaurant.level = france_level1
	
	add_child(restaurant)
