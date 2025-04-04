extends CharacterBody2D


const SPEED = 70.0
const JUMP_VELOCITY = -400.0
var player = null;
@onready var nav := $NavigationAgent2D as NavigationAgent2D # nav agent used to make move toward pos. of hero in regards to environment
var targetNode # create var for future use of locatating hero
var health = 5
var can_damage = true

func _physics_process(delta: float) -> void:
	var dir = to_local(nav.get_next_path_position()).normalized()
	velocity = dir * SPEED
	move_and_slide()
	
	
func take_damage(amount):
	health -= amount
	if health <= 0:
		print("crawler died")
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
	makePath() # Replace with function body.
<<<<<<< HEAD


func animate():
	if velocity == Vector2(0,0):
		$AnimatedSprite2D.play("idle")
		
	else:
		$AnimatedSprite2D.play("crawl")
=======
>>>>>>> 6641db7f445be5c81ac86b1f59958e350aa6349c
