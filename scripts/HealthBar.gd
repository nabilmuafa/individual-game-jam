extends TextureProgressBar

@export var player: CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.healthChanged.connect(update)
	update()


func update():
	value = GameManager.player_health * 100 / 100
