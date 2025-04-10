extends Node

@export var x_pos: float = 0.0;
@export var y_pos: float = 0.0;
@export var last_dir = "e"
@onready var thunderAudio = $AudioStreamPlayerThunder
@onready var whooshAudio = $AudioStreamPlayerWhoosh

var takenID = {}
var entityID = {}
var dropped_items = {}
var player_health: int
var player_current_attack = false
var player_attack_cooldown = false
var player_enemy_cooldown = false

var runtime_id = 1000

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_health = 100


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
func get_runtime_id():
	runtime_id += 1
	return runtime_id
	
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
