class_name StartScreen extends CanvasLayer

@onready var score: Label = $ScoreLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var high_score:int = Global.save_data.high_score
	score.text = "High Score: " + str(high_score)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
