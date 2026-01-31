extends Node2D

var enemy_scene = preload("res://scenes/enemy.tscn")
var screen_size
var spawn_timer

func _ready():
	screen_size = get_viewport_rect().size
	spawn_timer = Timer.new()
	spawn_timer.wait_time = 2.0
	spawn_timer.autostart = true
	spawn_timer.timeout.connect(_on_spawn_timer_timeout)
	add_child(spawn_timer)

func _on_spawn_timer_timeout():
	var enemy = enemy_scene.instantiate()
	var spawn_x = randf_range(20, screen_size.x - 20)
	enemy.position = Vector2(spawn_x, -20)
	add_child(enemy)