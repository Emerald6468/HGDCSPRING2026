extends CanvasLayer


@onready var Resume: TextureButton = $Resume
@onready var Restart: TextureButton = $Restart
@onready var Exit: TextureButton = $Exit



@export var tween_intensity: float
@export var tween_duration: float

func _ready() -> void:
	visible = false
	resume()

func resume():
	visible = false
	get_tree().paused = false

func pause():
	visible = true
	get_tree().paused = true

func testEsc():
	if Input.is_action_just_pressed("Pause") and !get_tree().paused:
		pause()
	elif Input.is_action_just_pressed("Pause") and get_tree().paused:
		resume()


func start_tween(object: Object, property: String, final_val: Variant, duration: float):
	var tween = create_tween()
	tween.tween_property(object, property, final_val, duration)

func hovered(button: TextureButton):
	button.pivot_offset = button.size / 2
	if button.is_hovered():
		start_tween(button, "scale", Vector2.ONE * tween_intensity, tween_duration)
	else:
		start_tween(button, "scale", Vector2.ONE, tween_duration)



func _on_resume_pressed() -> void:
	resume()


func _on_restart_pressed() -> void:
	resume()
	get_tree().reload_current_scene()


func _on_exit_pressed() -> void:
	get_tree().reload_current_scene()
	get_tree().change_scene_to_file("res://Scenes/UI UX Scenes/start_screen.tscn")



func _process(delta: float) -> void:
	testEsc()
	hovered(Resume)
	hovered(Restart)
	hovered(Exit)
	
