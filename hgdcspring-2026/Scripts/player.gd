extends CharacterBody2D


@export var speed = 400

#reads inputs
func get_input():
	var input_direction = Input.get_vector("Left", "Right", "Up", "Down")
	velocity = input_direction * speed

#every tick
func _physics_process(_delta):
	get_input()
	move_and_slide()
