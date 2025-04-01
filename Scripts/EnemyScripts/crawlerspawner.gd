extends Node2D

var spawnInterval = 600
var spawnTimer = spawnInterval
var enemy = preload("res://Scenes/EnemyScenes/crawler.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	spawnTimer -= 1
	if spawnTimer <1:
		spawnTimer =spawnInterval
		
		var instance = enemy.instantiate()
		instance.position = position
		get_tree().current_scene.add_child(instance)
