extends CanvasLayer

@onready var score: Label = $Overlay/ScoreLabel
@onready var Restart: TextureButton = $Restart

@export var tween_intensity: float
@export var tween_duration: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	$HighscoreMenuButtons.visible = false
	$GameOverMenuButtons.visible = false
	$Restart.visible = false
	$Overlay/ScoreLabel.visible = false
	
	var high_score:int = Global.score
	score.text = str(high_score)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func dead():
	if Global.isDead:
		if Global.justDied:
			Global.justDied = false
			get_tree().paused = true
			visible = true
			$Overlay/AnimationPlayer.play("fade_to_screen")
			await $Overlay/AnimationPlayer.animation_finished
			Global.isDead = false
	elif Global.isDead == false:
		$Overlay/AnimationPlayer.stop()
	elif Global.isDead == false and Global.gameRestarted == true:
		Global.gameRestarted = false

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	$HighscoreMenuButtons.visible = true
	$GameOverMenuButtons.visible = true
	$Restart.visible = true
	$Overlay/ScoreLabel.visible = true


func _on_restart_pressed() -> void:
	Global.gameRestarted = true
	get_tree().reload_current_scene()
	visible = false
	
	
func start_tween(object: Object, property: String, final_val: Variant, duration: float):
	var tween = create_tween()
	tween.tween_property(object, property, final_val, duration)

func hovered(button: TextureButton):
	button.pivot_offset = button.size / 2
	if button.is_hovered():
		start_tween(button, "scale", Vector2.ONE * tween_intensity, tween_duration)
	else:
		start_tween(button, "scale", Vector2.ONE, tween_duration)


func _process(delta: float) -> void:
	hovered(Restart)
	dead()
