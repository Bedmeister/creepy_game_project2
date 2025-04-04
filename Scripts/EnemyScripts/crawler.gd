extends CharacterBody2D

const SPEED = 70.0
const JUMP_VELOCITY = -400.0
@onready var player = null
@onready var nav := $NavigationAgent2D as NavigationAgent2D # nav agent used to make move toward pos. of hero in regards to environment
var targetNode # create var for future use of locatating hero
var health = 5
var can_damage = true
@onready var audioCrawler: AudioStreamPlayer2D = $deathsfx

signal died(crawler: CharacterBody2D)


func _physics_process(_delta: float) -> void:
		var dir = to_local(nav.get_next_path_position()).normalized()
		velocity = dir * SPEED
		move_and_slide()
		$AnimatedSprite2D.play("crawl")

func take_damage(amount):
	health -= amount
	if health <= 0:
		print("crawler died")
		audioCrawler.play()
		await get_tree().create_timer(.5).timeout
		emit_signal("died", self)
		queue_free()

func makePath() -> void:
	targetNode = get_node_or_null("/root/Main/myHero") #assigns hero to targetnode
	if targetNode != null:
		nav.target_position = targetNode.global_position

func _on_hitbox_body_entered(body: Node2D) -> void: # Detects hit player
	
	if body.is_in_group("player") and can_damage:
		body.call("take_damage", 5)
		can_damage = false
		await get_tree().create_timer(1.0).timeout
		can_damage = true

func _on_timer_timeout() -> void:
	makePath()
