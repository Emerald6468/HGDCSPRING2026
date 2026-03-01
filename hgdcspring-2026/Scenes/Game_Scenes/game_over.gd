extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Overlay/AnimationPlayer.play("fade_to_screen")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
