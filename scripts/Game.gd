extends Node2D

@onready var parallax_background = $ParallaxBackground
var scroll_speed = 100

func _ready():
	$Player.died.connect(_on_player_died)

func _process(delta):
	parallax_background.scroll_offset.y += delta*scroll_speed

func _on_player_died():
	# Simple restart after a delay
	await get_tree().create_timer(2.0).timeout
	get_tree().reload_current_scene()

