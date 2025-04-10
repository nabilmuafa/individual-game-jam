extends CharacterBody2D

@export var speed = 100
@onready var anim = $AnimatedSprite2D

var player_state
var is_attacking = false
var last_dir = "e"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
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
	
func start_attack():
	is_attacking = true
	anim.play("attack_" + last_dir)

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
			anim.play("walk_w")
			last_dir = "w"
		elif direction.x == 1:
			anim.play("walk_e")
			last_dir = "e"


func _on_animated_sprite_2d_animation_finished() -> void:
	if anim.animation.begins_with("attack_"):
		is_attacking = false
