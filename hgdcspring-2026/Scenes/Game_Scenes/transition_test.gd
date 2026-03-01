class_name transition_test extends Node2D

signal loaded()

@export_file ("*.tscn") var next_scene: String

func load_scene() -> void:
	await get_tree().create_timer(3.0).timeout
	loaded.emit()
	

func activate() -> void:
	pass  # add any startup logic here
