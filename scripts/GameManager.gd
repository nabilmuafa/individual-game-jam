extends Node

@export var x_pos: float = 0.0;
@export var y_pos: float = 0.0;
@export var last_dir = "e"
@onready var thunderAudio = $AudioStreamPlayerThunder

var takenID = {}
var player_health = 100
var player_current_attack = false
var player_attack_cooldown = false
var player_enemy_cooldown = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
