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

#eyeball
@onready var eyeball: Sprite2D = $Eyeball
@onready var marker_2d: Marker2D = $Eyeball/Marker2D


#reads inputs
func get_input():
	var input_direction = Input.get_vector("Left", "Right", "Up", "Down")
	velocity = input_direction * speed
func _input(event):
	target = get_global_mouse_position()
	if event.is_action_pressed("Click"):
		just_clicked = true
		create_projectile()


#creates projectile
func create_projectile():
	if just_clicked:
		just_clicked = false
		print("projectile")
		var projectile = projectile_scene.instantiate()
		owner.add_child(projectile)
		projectile.transform = marker_2d.global_transform
	
	
func look_toward_mouse():
	eyeball.look_at(target)
#runs every tick
func _physics_process(_delta):
	get_input()
	look_toward_mouse()
	move_and_slide()
