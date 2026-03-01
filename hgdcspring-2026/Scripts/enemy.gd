extends CharacterBody2D

@onready var projectile = preload("res://Prefabs/enemy_projectile.tscn")
@onready var marker_2d: Marker2D = $Marker2D

var rng = RandomNumberGenerator.new()

var enemy_type = rng.randi_range(1, 3)
var firing = false
var timerOn = true
var hp

# firingInterval is how long the enemy will wait inbetween shots. It's randomly generated within a certain range.
# firingLength is how long the enemy will wait in place to shoot.
var firingInterval
var firingLength
var speed
var startingSpeed

var projectile1

func _ready() -> void:
	
	# IF YOU WANNA CHANGE THE SPRITES GO HERE AND CHANGE THE LINE: 
	# $CollisionShape2D/Sprite.modulate = Color(x, x, x)
	# to
	# $CollisionShape2D/Sprite.texture = some_texture
	#
	# Make sure to preload 'some_texture' when instantiating variables above.
	# Also you'll need a seprate texture preloaded for each enemy type. Right now it's just changing their color
	match enemy_type:
		1:
			hp = 4
			# if you want to know what firingInterval & firingLength is, head up above to where the variable is created
			firingInterval = rng.randi_range(4, 7)
			firingLength = 1
			startingSpeed = 0.5
			$CollisionShape2D/Sprite2D.modulate = Color(1, 0, 0)
		2:
			hp = 2
			firingInterval = rng.randi_range(2, 4)
			firingLength = .5
			startingSpeed = 1
			$CollisionShape2D/Sprite2D.modulate = Color(0, 1, 0)
		3:
			hp = 1
			firingInterval = rng.randf_range(0.3, 0.8)
			firingLength = .1
			startingSpeed = 3
			$CollisionShape2D/Sprite2D.modulate = Color(0, 0, 1)
	speed = startingSpeed

# Checking if you're getting hit by the player's bullets
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("PlayerProjectile"):
		area.queue_free()
		hp -= 1


func _physics_process(delta: float) -> void:
	# This handful of code should be self explanatory
	look_at(Global.player_point)
	global_transform.origin = global_transform.origin.move_toward(Global.player_point,speed)
	if hp <= 0:
		queue_free()
	
	# Waiting to actually shoot
	if timerOn:
		timerOn = false
		await get_tree().create_timer(firingInterval).timeout
		shoot()


func shoot():
	# Stop in place and wait to shoot
	speed = 0
	await get_tree().create_timer(firingLength).timeout
	
	# More instructions depending on which enemy type it is
	match enemy_type:
		1:
			# The code will be explained in the second switch statement because there's one unique variable there
			projectile1 = projectile.instantiate()
			projectile1.speed = 1000
			projectile1.dead = 200
			get_tree().get_root().add_child(projectile1)
			projectile1.global_position = global_position
			projectile1.enemyType = enemy_type
		2:
			# Actually creating the shit that's gonna be shot
			projectile1 = projectile.instantiate()
			
			# speed should be self explanatory
			# dead is how long each projectile will remain in the air before it deletes itself
			projectile1.speed = 200
			projectile1.dead = 400
			
			# maxTimer is a unique variable to this projectile. It can still, however, be applied to the other projectiles.
			# maxTimer is just how long the projectile will track the player.
			projectile1.maxTimer = 400
			
			# More Godot magic summoning voodoo shit
			get_tree().get_root().add_child(projectile1)
			
			# passing the position and the enemy type it to the projectile
			projectile1.global_position = global_position
			projectile1.enemyType = enemy_type
		3:
			projectile1 = projectile.instantiate()
			projectile1.speed = 300.0
			projectile1.dead = 700
			get_tree().get_root().add_child(projectile1)
			projectile1.global_position = global_position
			projectile1.enemyType = enemy_type
	
	# Resume engines
	speed = startingSpeed
	
	# Start the timer to wait to shoot again
	timerOn = true
