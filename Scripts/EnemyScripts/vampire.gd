extends CharacterBody2D


const SPEED = 120.0

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


func makePath() -> void: # method to create path
	targetNode = get_node_or_null("/root/Main/myHero") #assigns hero to targetnode
	if targetNode != null:
		nav.target_position = targetNode.global_position


func _on_timer_timeout() -> void:
	makePath() # Creates path for enemy to follow

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
