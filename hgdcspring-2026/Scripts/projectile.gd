extends Area2D

var speed = 2000

func _physics_process(delta):
	position += transform.x * speed * delta


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("EnemyProjectile"):
		Global.score += 1
		area.queue_free()
	await get_tree().create_timer(1).timeout
	queue_free()
