extends CharacterBody2D


@export var speed = 400

#size
@export var starting_size = 3
var size = starting_size

#projectiles
@onready var projectile_scene = preload("res://Prefabs/projectile.tscn")
var target:Vector2 = position
var just_clicked = false
var projectile_speed = 10

#reads inputs
func get_input():
	var input_direction = Input.get_vector("Left", "Right", "Up", "Down")
	velocity = input_direction * speed
func _input(event):
	if event.is_action_pressed(&"click"):
		just_clicked = true
		target = get_global_mouse_position()
		create_projectile()


#creates projectile
func create_projectile():
	if just_clicked:
		just_clicked = false
		print("projectile")
		#var projectile = 		
#runs every tick
func _physics_process(_delta):
	get_input()
	move_and_slide()
