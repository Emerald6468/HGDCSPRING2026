extends Node2D

@export var food_time = 1
@export var enemy_time = 15
@export var starting_food = 100
@export var starting_enemy = 10
@onready var food_scene = preload("res://Prefabs/food.tscn")
@onready var enemy_scene = preload("res://Prefabs/Enemy.tscn")
var timer_on = true
var timer2_on = true

func _ready() -> void:
	for i in starting_food:
		make_food()
	for i in starting_enemy:
		make_enemy()
#make food
func make_food():
	print("test")
	var f = food_scene.instantiate()
	add_child(f)
	var fx = randf_range(Global.player_point.x-1000,Global.player_point.x+1000)
	var fy = randf_range(Global.player_point.y-1000,Global.player_point.y+1000)
	f.global_position = Vector2(fx,fy)
	
func make_enemy():
	print("test")
	var e = enemy_scene.instantiate()
	add_child(e)
	var ex = randf_range(Global.player_point.x-1000,Global.player_point.x+1000)
	var ey = randf_range(Global.player_point.y-1000,Global.player_point.y+1000)
	e.global_position = Vector2(ex,ey)
	
func food_timer():
	if timer_on:
		timer_on = false
		await get_tree().create_timer(food_time).timeout
		make_food()
		timer_on = true
		
func enemy_timer():
	if timer_on:
		timer2_on = false
		await get_tree().create_timer(enemy_time).timeout
		make_enemy()
		timer2_on = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	food_timer()
	enemy_timer()
	
