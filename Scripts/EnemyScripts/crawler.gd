extends CharacterBody2D


const SPEED = 50.0
var player = null;
@onready var nav := $NavigationAgent2D as NavigationAgent2D # nav agent used to make move toward pos. of hero in regards to environment
var targetNode # create var for future use of locatating hero
var health = 100

func _physics_process(delta: float) -> void:
	var dir = to_local(nav.get_next_path_position()).normalized()
	velocity = dir * SPEED
	look_at(dir)
	move_and_slide()
	animate()
	
	


	#if targetNode:#used to find hero
		#print("found the hero!")
	#	position = position.move_toward(targetNode.position, 2) #moves enemy towards hero.
	#else: 
	#	print("hero doesnt exist.")

func makePath() -> void:
	targetNode = get_node_or_null("/root/Main/myHero") #assigns hero to targetnode
	nav.target_position = targetNode.global_position

func _on_hitbox_body_entered(body: Node2D) -> void: # Detects hit player
	player = body
	if body.is_in_group("player"):
		print("enemy hitbox entered")


func _on_timer_timeout() -> void:
	makePath() # Replace with function body.


func animate():
	if velocity == Vector2(0,0):
		$AnimatedSprite2D.play("idle")
	else:
		$AnimatedSprite2D.play("crawl")
