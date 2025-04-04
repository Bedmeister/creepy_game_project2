extends CharacterBody2D

# BASIC MOVEMENT
var SPEED = 300.0

#furniture push physics
var min_force = 15
var max_force = 100

# Health and Attack
var health = 100

@onready var audioSwing: AudioStreamPlayer2D = $AudioStreamPlayer2D #for bat swing sfx

@onready var attack_hitbox = $AttackHitbox
@onready var anim_player = $AnimationPlayer
@onready var cam = $Camera2D

@export var inventory: Node
@onready var inventory_ui = $CanvasLayer/InventoryUI

# camera shake
var shake_timer = 0.0
var shake_strength = 10.0  
var shake_duration = 0.2  

func _physics_process(_delta: float) -> void:
	rotate_player()
	slow_player()
	_get_input()
	move_and_slide()
	furniture_physics()

func _process(delta):
	if Input.is_action_just_pressed("attack"):
		perform_attack()
		audioSwing.play()
		
	if shake_timer > 0:
		shake_timer -= delta
		var offset = Vector2(
			randf_range(-1.0, 1.0),
			randf_range(-1.0, 1.0)
		) * shake_strength
		cam.offset = offset
	else:
		cam.offset = Vector2.ZERO


	
#Function is used to create diagonal movement
func _get_input():
	var  input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down");
	velocity = input_direction * SPEED




func rotate_player(): #rotates player with mouse
	var direction = get_global_mouse_position()
	look_at(direction)

func slow_player():
	if Input.is_action_pressed("pull"):
		SPEED = 75
	else: 
		SPEED = 300

func furniture_physics():
	for index in get_slide_collision_count():
		var collision = get_slide_collision(index)
		if collision.get_collider() is RigidBody2D:
			var rigidbody = collision.get_collider() as RigidBody2D
			#var push_force = (15 * velocity.length() / SPEED) + min_force
			rigidbody.apply_central_impulse(-collision.get_normal() * 0.25) 

func perform_attack():
	anim_player.play("attack")
	attack_hitbox.monitoring = true
	
	await get_tree().create_timer(0.1).timeout
	attack_hitbox.monitoring = false

func _on_attack_hitbox_area_entered(area: Area2D) -> void:
	print("hit something:", area.name)
	if area.is_in_group("enemy"):
		print("hit enemy")
		area.get_parent().call("take_damage", 5)
		shake_timer = shake_duration
		

func take_damage(amount):
	health -= amount
	print("Player health:", health)
	if health <= 0:
		die()

func die():
	print("Player died")
	queue_free()
	
func collect_item(item_name: String, max_stack: int) -> bool:
	if inventory:
		var success = inventory.add_item(item_name, max_stack)
		if success:
			return true
		else:
			return false
	return true
		
