extends Node2D

var spawnInterval = 1000
var spawnTimer = spawnInterval
var enemy := preload("res://Scenes/EnemyScenes/crawler.tscn")
var enemies: Array = []
var can_spawn = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass



func _process(_delta: float) -> void:
	
	if can_spawn == true :
		spawnTimer -= 1
		if spawnTimer < 1:
			spawnTimer = spawnInterval
			spawn_enemy()
			

func spawn_enemy() -> void:
	var instance = enemy.instantiate()
	instance.position = position
	get_tree().current_scene.add_child(instance)
	enemies.append(instance)
	
	instance.died.connect(_on_crawler_died)
	
func kill_all_enemies() -> void:
	for enemy_instance in enemies:
		enemy_instance.queue_free()
	enemies.clear()
	
func _on_crawler_died(crawler: CharacterBody2D) -> void:
	enemies.erase(crawler)
	crawler.queue_free()

func _on_timer_timeout() -> void:
	pass

func _on_disable_spawn_pressed() -> void:
	can_spawn = false
	kill_all_enemies()
	
func _on_enable_spawn_pressed() -> void:
	can_spawn = true
