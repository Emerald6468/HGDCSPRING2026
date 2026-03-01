class_name StartScreen extends CanvasLayer

signal loaded()

@export_file("*.tscn") var next_scene: String
@export var tween_intensity: float
@export var tween_duration: float

@onready var score: Label = $ScoreLabel
@onready var play: TextureButton = $Play

func start_tween(object: Object, property: String, final_val: Variant, duration: float):
	var tween = create_tween()
	tween.tween_property(object, property, final_val, duration)

func hovered(button: TextureButton):
	button.pivot_offset = button.size / 2
	if button.is_hovered():
		start_tween(button, "scale", Vector2.ONE * tween_intensity, tween_duration)
	else:
		start_tween(button, "scale", Vector2.ONE, tween_duration)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var high_score:int = Global.save_data.high_score
	score.text = "High Score: " + str(high_score)

func _process(delta: float) -> void:
	hovered(play)

func activate() -> void:
	pass
	

func load_scene() -> void:
	await get_tree().create_timer(3.0).timeout
	loaded.emit()
