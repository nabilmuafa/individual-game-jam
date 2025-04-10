extends Node2D

var player_in_range = false
@export var item_id: int
@export var item_name: String
@export var unlimited = false
@export var max_take = 1
@export var need_tools = false
@export var tool_needed_name: String

@onready var sprite = $Sprite2D

var shader_material: ShaderMaterial
var tool_held = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if GameManager.takenID.has(item_id):
		max_take = GameManager.takenID[item_id]
		if max_take == 0:
			queue_free()
	shader_material = ShaderMaterial.new()
	shader_material.shader = preload("res://scripts/Collectible.gdshader")
	if not need_tools:
		sprite.material = shader_material


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if need_tools:
		if PlayerInventory.inventory.has(PlayerInventory.active_item_slot):
			if PlayerInventory.inventory[PlayerInventory.active_item_slot][0] != tool_needed_name:
				sprite.material = null
				tool_held = false
			else:
				sprite.material = shader_material
				tool_held = true
		else:
			sprite.material = null
			tool_held = false
			
	if Input.is_action_just_pressed("interact") and player_in_range and tool_held:
		PlayerInventory.add_item(item_name, 1)
		if not unlimited:
			max_take -= 1
			GameManager.takenID[item_id] = max_take
			if max_take == 0:
				queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player_in_range = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		player_in_range = false
