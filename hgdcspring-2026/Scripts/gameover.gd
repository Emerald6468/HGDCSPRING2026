class_name GameOver extends CanvasLayer

@onready var score: Label = %ScoreLabel
@onready var high_score: Label = %HighScoreLabel


func set_score(n:int):
	score.text = "Final Score: " + str(n)
	if n > Global.save_data.high_score:
		high_score.visible = true
		Global.save_data.high_score
		Global.save_data.save()
	else:
		high_score.visible = false
