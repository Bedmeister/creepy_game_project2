extends Node2D

@onready var light = $PointLight2D
@onready var sprite = $AnimatedSprite2D
@onready var timer = $Timer

var flicker_timer = 0.1
var max_flicker = 1.5
var min_flicker = 0.8

func _ready():
	timer.start()
	sprite.play("burn")
	
func _process(delta):
	flicker_timer -= delta
	if flicker_timer <= 0:
		light.energy = randf_range(min_flicker, max_flicker)
		flicker_timer = 0.1  # Reset the flicker timer
	
func _on_timer_timeout():
	# Remove the light and the candle after the timer expires
	#light.queue_free()
	#sprite.queue_free()
	queue_free()  # Free the candle node from the scene
