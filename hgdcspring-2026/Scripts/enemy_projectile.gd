extends Area2D

var speed
var timer = 0
var maxTimer = 10
var deathTimer = 0
var dead
var direction
var enemyType
func _ready() -> void:
	look_at(Global.player_point)


func _physics_process(delta):
	# You may find yourself asking: Xavier, why did you put this stuff here instead of on the _ready() function
	# Well that's a good question
	# This shit doesn't work UNLESS I place it here.
	# So everything under the timer if statement is stuff that (usually) runs for a quarter of a second
	# But on the bright side it basically coded in tracking functionality.
	#
	#
	# I fucking hate Godot
	if timer <= maxTimer:
		look_at(Global.player_point)
		direction = (Global.player_point - global_position).normalized()
		match enemyType:
			1:
				$CollisionShape2D/Sprite2D.modulate = Color(1, 1, 0)
			2:
				$CollisionShape2D/Sprite2D.modulate = Color(0, 1, 1)
			3:
				$CollisionShape2D/Sprite2D.modulate = Color(1, 0, 1)
		timer += 1
	global_position += direction * speed * delta
	deathTimer += 1
	
	if deathTimer >= dead:
		queue_free()
	
