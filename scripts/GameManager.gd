extends Node

@export var x_pos: float = 0.0;
@export var y_pos: float = 0.0;
@export var last_dir = "e"
@onready var thunderAudio = $AudioStreamPlayerThunder
@onready var whooshAudio = $AudioStreamPlayerWhoosh

signal health_changed

var game_started = false
var is_movement_disabled = true
var is_first_dialogue_shown = false
var entered_forest = false
var found_crystals = false
var first_enemy_encounter = false

var takenID = {}
var entityID = {}
var dropped_items = {}

var player_health: int
var player_current_attack = false
var player_attack_cooldown = false
var player_enemy_cooldown = false
var player_is_alive = true

var runtime_id = 1000
var dialogue = preload("res://dialogues/all_dialogues.dialogue")

var death_screen = preload("res://scenes/DeathScreen.tscn")
var main_menu = preload("res://scenes/MainMenuOverlay.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_health = 100
	PlayerInventory.inventory_layer = $UILayer


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if player_health == 0 and player_is_alive:
		player_is_alive = false
		var death_screen_instance = death_screen.instantiate()
		death_screen_instance.layer = 27
		add_child(death_screen_instance)
	
	
func get_runtime_id():
	runtime_id += 1
	return runtime_id
	

func game_start():
	if not DialogueManager.dialogue_ended.is_connected(_on_dialogue_end):
		DialogueManager.dialogue_ended.connect(_on_dialogue_end)
	is_first_dialogue_shown = true
	show_dialogue("game_start")
	emit_signal("health_changed")
	
func reset_game_state():
	game_started = false
	is_movement_disabled = true
	is_first_dialogue_shown = false
	entered_forest = false
	found_crystals = false
	first_enemy_encounter = false
	takenID = {}
	entityID = {}
	dropped_items = {}
	player_health = 100
	player_current_attack = false
	player_attack_cooldown = false
	player_enemy_cooldown = false
	player_is_alive = true
	x_pos = 0.0;
	y_pos = 0.0;
	$UILayer/Inventory.reset_inventory_state()
	
	$UILayer.visible = false
	
	get_tree().change_scene_to_file("res://scenes/Beach.tscn")
	var main_menu_instance = main_menu.instantiate()
	add_child(main_menu_instance)

func show_dialogue(name: String):
	is_movement_disabled = true
	var dialogue_line = await DialogueManager.show_dialogue_balloon(dialogue, name)


func _on_dialogue_end(resource):
	if $UILayer.visible == false:
		$UILayer.visible = true
	if not game_started:
		game_started = true
	is_movement_disabled = false

	
# Audio Functions


func enemy_hit():
	$AudioStreamPlayerEnemyHit.play()
	
func player_hit():
	$AudioStreamPlayerPlayerHit.play()
	
func audio_attack():
	whooshAudio.play()
	
func take_item():
	$AudioStreamPlayerTakeItem.play()

func mine_item():
	$AudioStreamPlayerMine.play()
