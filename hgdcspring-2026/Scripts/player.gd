extends CharacterBody2D


@export var speed = 400

#invincibility
var invincability_time = .5
var timer_on = false
var invincable = false

#size
@export var starting_size = 3.0
@export var max_size = 10.0
var size:float = starting_size

#projectiles
@onready var projectile_scene = preload("res://Prefabs/projectile.tscn")
var target:Vector2 = position
var just_clicked = false
var projectile_speed = 10

#eyeball
@onready var eyeball: Sprite2D = $Eyeball
@onready var marker_2d: Marker2D = $Eyeball/Marker2D

#pickup
@onready var pickup: Area2D = $Pickup


func _ready() -> void:
	timer_on = true
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
		if size > 1:
			size-=1
			var projectile = projectile_scene.instantiate()
			owner.add_child(projectile)
			projectile.transform = marker_2d.global_transform
	
	
func look_toward_mouse():
	eyeball.look_at(target)
	


#runs every tick
func _physics_process(_delta):
	if timer_on: invincible_timer()
	Global.player_point = global_position
	get_input()
	look_toward_mouse()
	move_and_slide()
	update_size()
	

#update size
func update_size():
	scale.x = size/10
	scale.y = size/10

func invincible_timer():
	if timer_on:
		timer_on = false
		invincable = true
		await get_tree().create_timer(invincability_time).timeout
		invincable = false

#collision
func _on_pickup_body_entered(body: Node2D) -> void:
	if body.is_in_group("Food"):
		if size<max_size: 
			size += body.food_points
			Global.score += 1
			print(size)
		else: Global.score += 3
		body.queue_free()
	elif body.is_in_group("Enemy"):
		#game over
		if !invincable: get_tree().reload_current_scene()
	
	


func _on_pickup_area_entered(area: Area2D) -> void:
	if area.is_in_group("EnemyProjectile"):
		print("hit")
		if !invincable and size > 1:
			size = 1
			timer_on = true
		#game over
		elif !invincable: get_tree().reload_current_scene()
