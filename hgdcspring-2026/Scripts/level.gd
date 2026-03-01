extends Node2D

@export var food_timer = 2.0
@onready var food_scene = preload("res://Prefabs/food.tscn")
#make food
func make_food():
	var f = food_scene.instantiate()
	#var fx = randf_range()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
