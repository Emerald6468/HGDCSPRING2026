class_name StartScreen extends CanvasLayer

signal loaded()

@export_file("*.tscn") var next_scene: String

@onready var score: Label = $Panel/ScoreLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var high_score:int = Global.save_data.high_score
	score.text = "High Score: " + str(high_score)


func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	SceneManager.transition_to(next_scene)
	
	
	
	

func activate() -> void:
	pass
	
	
	

func load_scene() -> void:
	await get_tree().create_timer(3.0).timeout
	loaded.emit()
