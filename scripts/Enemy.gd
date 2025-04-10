extends CharacterBody2D

@export var speed = 50
@onready var anim = $AnimatedSprite2D
@onready var attack_anim = $AttackAnim

var red_flash: ShaderMaterial

var health = 100
var last_dir = "s"

var player_chase = false
var player = null
var player_in_attack_zone = false

var is_attacking = false

func _ready() -> void:
	red_flash = ShaderMaterial.new()
	red_flash.shader = preload("res://scripts/RedFlash.gdshader")
	anim.material = red_flash
	

func _physics_process(_delta: float) -> void:
	if player_chase and player and not is_attacking:
		if position.distance_to(player.position) > 12.3:
			var direction = (player.position - position).normalized()
			position += direction * speed * _delta

			play_walk_anim(direction)
		
	move_and_slide()
	
	
func _process(_delta: float) -> void:
	if player_in_attack_zone and GameManager.player_current_attack and !GameManager.player_attack_cooldown:
		deal_with_damage()
		
	if player_in_attack_zone and not is_attacking:
		start_attack()


func play_walk_anim(direction: Vector2) -> void:
	if abs(direction.y) > abs(direction.x):
		if direction.y < 0:
			anim.play("walk_n")
			last_dir = "n"
		else:
			anim.play("walk_s")
			last_dir = "s"
	else:
		if direction.x < 0:
			anim.play("walk_w")
			last_dir = "w"
		else:
			anim.play("walk_e")
			last_dir = "e"


func start_attack():
	is_attacking = true
	anim.play("attack_windup")
	$AttackWindupTimer.start()


func _on_attack_windup_timer_timeout() -> void:
	anim.play("idle")
	attack_anim.play("attack")
	if player_in_attack_zone and player:
		player.enemy_attack()
	
		
func _on_attack_anim_animation_finished() -> void:
	is_attacking = false


func deal_with_damage():
	GameManager.player_attack_cooldown = true
	anim.material.set("shader_param/flash_strength", 0.5)
	await get_tree().create_timer(0.1).timeout
	anim.material.set("shader_param/flash_strength", 0.0)
	var damage = 15
	if PlayerInventory.inventory.has(PlayerInventory.active_item_slot):
		var item_held = PlayerInventory.inventory[PlayerInventory.active_item_slot][0]
		damage = JsonData.item_data[item_held]["ItemAttack"]
		
	health -= damage
	if health <= 0:
		self.queue_free()


func _on_detection_area_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player = body
		player_chase = true


func _on_detection_area_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		player = null
		player_chase = false
		
	anim.play("idle")


func _on_enemy_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_in_attack_zone = true


func _on_enemy_hitbox_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_in_attack_zone = false
