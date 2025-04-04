extends CharacterBody2D

<<<<<<< HEAD

const SPEED = 80.0
const JUMP_VELOCITY = -400.0
var player = null;
@onready var nav := $NavigationAgent2D as NavigationAgent2D # nav agent used to make move toward pos. of hero in regards to environment
var targetNode # create var for future use of locatating hero
var health = 15
var can_damage = true

func _physics_process(delta: float) -> void:
	#rotate_enemy() #roate enemy

	var dir = to_local(nav.get_next_path_position()).normalized()
	velocity = dir * SPEED
	move_and_slide()
	
func rotate_enemy(): #rotates enemy t 0player
	targetNode =  get_node_or_null("/root/Main/myHero")
	var tp = targetNode.global_position
	var direction = (tp -position).normalized()
	var angle = direction.angle()
	rotation = angle
	
func take_damage(amount):
	health -= amount
	if health <= 0:
		print("vampire died")
		queue_free()


func makePath() -> void: # method to create path
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
	makePath() # Creates path for enemy to follow
=======
const SPEED = 90.0
var player = null
var health = 10
var can_damage = true

@onready var nav := $NavigationAgent2D
var targetNode

func _physics_process(delta):
	if nav.is_navigation_finished():
		velocity = Vector2.ZERO
		return

	var next_pos = nav.get_next_path_position()
	var dir = to_local(next_pos).normalized()
	velocity = dir * SPEED
	move_and_slide()

func makePath() -> void:
	targetNode = get_node_or_null("/root/Main/myHero")
	if targetNode:
		nav.target_position = targetNode.global_position

func _on_timer_timeout() -> void:
	makePath()

func take_damage(amount):
	health -= amount
	print("Vampire damaged! Health left:", health)
	if health <= 0:
		print("Vampire died!")
		queue_free()

func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and can_damage:
		body.call("take_damage", 5)
		print("Vampire hit the player!")
		can_damage = false
		await get_tree().create_timer(1.0).timeout
		can_damage = true


func _on_area_2d_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
>>>>>>> 24ec96714fc40df6d39eeb8faba6cad37be6aca1
