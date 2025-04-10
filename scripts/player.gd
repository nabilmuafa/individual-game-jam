extends CharacterBody2D

@export var speed = 100
@onready var anim = $AnimatedSprite2D
@onready var attack_anim = $AttackSweep

var player_state
var is_attacking = false
var last_dir = "e"

var health: int
var player_alive = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health = GameManager.player_health
	last_dir = GameManager.last_dir
	PlayerInventory.inventory_layer = $InventoryLayer


func _physics_process(_delta: float) -> void:
	var direction = Input.get_vector("left", "right", "up", "down")
	
	if direction.x == 0 and direction.y == 0:
		player_state = "idle"
	elif direction.x != 0 or direction.y != 0:
		player_state = "walking"
		
	velocity = direction * speed
	if not is_attacking:
		play_anim(direction)
	move_and_slide()
	
	
func _process(_delta: float) -> void:
	if not is_attacking and Input.is_action_just_pressed("attack"):
		start_attack()
		
	if health <= 0:
		player_alive = false
		print("YOURE A DEAD MAN")


func play_anim(direction):
	if player_state == "idle":
		anim.play("idle_"+last_dir)
	elif player_state == "walking":
		if direction.y == -1:
			anim.play("walk_n")
			last_dir = "n"
		elif direction.y == 1:
			anim.play("walk_s")
			last_dir = "s"
		elif direction.x == -1:
			if not is_attacking:
				anim.play("walk_w")
				attack_anim.flip_h = true
			last_dir = "w"
		elif direction.x == 1:
			if not is_attacking:
				anim.play("walk_e")
				attack_anim.flip_h = false
			last_dir = "e"

	
func start_attack():
	is_attacking = true
	GameManager.player_current_attack = true
	if PlayerInventory.inventory.has(PlayerInventory.active_item_slot):
		var item_held = PlayerInventory.inventory[PlayerInventory.active_item_slot][0]
		var anim_speed = JsonData.item_data[item_held]["ItemSpeed"]
		anim.speed_scale = anim_speed
		attack_anim.speed_scale = anim_speed
	else:
		anim.speed_scale = 1.0
		attack_anim.speed_scale = 1.0
	anim.play("attack_" + last_dir)
	attack_anim.play("sword_sweep")


func enemy_attack():
	health -= 20
	GameManager.player_health -= 20
	print("Player attacked, health: ",health)


func _on_animated_sprite_2d_animation_finished() -> void:
	if anim.animation.begins_with("attack_"):
		GameManager.player_current_attack = false
		GameManager.player_attack_cooldown = false
		is_attacking = false
