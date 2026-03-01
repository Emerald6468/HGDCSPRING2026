extends CanvasLayer

@onready var score: Label = $Overlay/ScoreLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$HighscoreMenuButtons.visible = false
	$GameOverMenuButtons.visible = false
	$Restart.visible = false
	$Overlay/ScoreLabel.visible = false
	$Overlay/AnimationPlayer.play("fade_to_screen")
	var high_score:int = Global.score
	score.text = str(high_score)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	$HighscoreMenuButtons.visible = true
	$GameOverMenuButtons.visible = true
	$Restart.visible = true
	$Overlay/ScoreLabel.visible = true


func _on_restart_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/TestScenes/ZanderTestScene.tscn")
