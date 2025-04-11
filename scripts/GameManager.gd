extends Node

@export var x_pos: float = 0.0;
@export var y_pos: float = 0.0;
@export var last_dir = "e"
@onready var thunderAudio = $AudioStreamPlayerThunder
@onready var whooshAudio = $AudioStreamPlayerWhoosh

var game_started = false
var is_movement_disabled = true

var takenID = {}
var entityID = {}
var dropped_items = {}
var player_health: int
var player_current_attack = false
var player_attack_cooldown = false
var player_enemy_cooldown = false

var runtime_id = 1000
var dialogue = preload("res://dialogues/all_dialogues.dialogue")
var is_first_dialogue_shown = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_health = 100


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
	
func get_runtime_id():
	runtime_id += 1
	return runtime_id
	

func game_start():
	DialogueManager.dialogue_ended.connect(_on_dialogue_end)
	is_first_dialogue_shown = true
	show_dialogue("game_start")
	

func show_dialogue(name: String):
	is_movement_disabled = true
	var dialogue_line = await DialogueManager.show_dialogue_balloon(dialogue, name)


func _on_dialogue_end(resource):
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
