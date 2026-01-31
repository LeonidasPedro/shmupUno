extends Area2D

var speed = 600
var direction = Vector2(0, -1)

func _process(delta):
	position += direction * speed * delta

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_area_entered(area):
	if area.is_in_group("Enemy"):
		area.take_damage(1)
		queue_free()
