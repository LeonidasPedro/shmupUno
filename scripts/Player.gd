extends Area2D

@export var speed = 300
@export var health = 5
@export var fire_rate = 0.2

var p_bullet_scene = preload("res://scenes/p_bullet.tscn")
var can_shoot = true
var screen_size

func _ready():
	add_to_group("Player")
	screen_size = get_viewport_rect().size
	$Timer.wait_time = fire_rate

func _process(delta):
	# Movement
	var direction = Input.get_vector("left", "right", "up", "down")
	if direction.length() > 0:
		direction = direction.normalized()
	
	position += direction * speed * delta
	
	# Clamp position
	position.x = clamp(position.x, 16, screen_size.x - 16)
	position.y = clamp(position.y, 16, screen_size.y - 16)
	
	# Shooting
	if Input.is_action_pressed("fire") and can_shoot:
		shoot()

func shoot():
	var b = p_bullet_scene.instantiate()
	b.position = position + Vector2(0, -20)
	get_parent().add_child(b)
	can_shoot = false
	$Timer.start()

func _on_timer_timeout():
	can_shoot = true

func take_damage(amount):
	health -= amount
	print("Player Health: ", health)
	if health <= 0:
		die()

signal died

func die():
	print("Player Died")
	died.emit()
	queue_free()
