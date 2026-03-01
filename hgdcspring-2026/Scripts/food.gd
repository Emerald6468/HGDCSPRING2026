extends StaticBody2D

@export var food_points = 1

@onready var sprite: Sprite2D = $CollisionShape2D/Sprite2D

@onready var food1 = preload("res://Assets/art/tealpellet.png")
@onready var food2 = preload("res://Assets/art/pinkpellet.png")
@onready var food3 = preload("res://Assets/art/oragngepellet.png")

func _ready() -> void:
	var r = round(randf_range(.5,3.49))
	print(r)
	match r:
		1.0: sprite.set_texture(food1)
		2.0: sprite.set_texture(food2)
		3.0: sprite.set_texture(food3)
		_:print("error")
