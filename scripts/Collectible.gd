extends Node2D

var player_in_range = false
@export var item_name: String
@export var unlimited = false
@export var max_take = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("interact") and player_in_range:
		PlayerInventory.add_item(item_name, 1)
		if not unlimited:
			max_take -= 1
			if max_take == 0:
				queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player_in_range = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		player_in_range = false
