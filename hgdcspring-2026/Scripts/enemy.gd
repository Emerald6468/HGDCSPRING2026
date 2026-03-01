extends CharacterBody2D

func _physics_process(delta: float) -> void:
	look_at(Global.player_point)
	global_transform.origin = global_transform.origin.move_toward(Global.player_point,.1)
