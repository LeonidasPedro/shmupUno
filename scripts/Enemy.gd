extends Area2D

@export var speed = 100
@export var health = 3
@export var shoot_interval = 1.5

var bullet_scene = preload("res://scenes/bullet.tscn")
@onready var timer = $Timer

func _ready():
	add_to_group("Enemy")
	timer.wait_time = shoot_interval
	timer.start()

func _process(delta):
	position.y += speed * delta
	
	if position.y > get_viewport_rect().size.y + 50:
		queue_free()

func take_damage(amount):
	health -= amount
	if health <= 0:
		die()

func die():
	# TODO: Add explosion
	# TODO: Add score
	queue_free()

func _on_timer_timeout():
	shoot()

func shoot():
	var b = bullet_scene.instantiate()
	b.position = position + Vector2(0, 16)
	b.direction = Vector2(0, 1)
	get_parent().add_child(b)

func _on_area_entered(area):
	if area.is_in_group("Player"):
		area.take_damage(1)
		take_damage(3) # Destroy enemy on collision with player
