extends CharacterBody2D

@export var speed = 100
@onready var anim = $AnimatedSprite2D

var player_state
var last_dir = "e"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("left", "right", "up", "down")
	
	if direction.x == 0 and direction.y == 0:
		player_state = "idle"
	elif direction.x != 0 or direction.y != 0:
		player_state = "walking"
		
	velocity = direction * speed
	play_anim(direction)
	move_and_slide()
	
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
	
			
		
