extends Node2D

var spawnInterval = 500
var spawnTimer = spawnInterval
var enemy := preload("res://crawler.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass



func _process(delta: float) -> void:
	
	spawnTimer -= 1
	if spawnTimer <1:
		spawnTimer =spawnInterval
		
		var instance = enemy.instantiate()
		instance.position = position
		get_tree().current_scene.add_child(instance)

func _on_timer_timeout() -> void:
	pass
