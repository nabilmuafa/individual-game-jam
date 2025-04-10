extends Node2D

var enemy = preload("res://scenes/BambooEnemy.tscn")
@onready var timer = $EnemySpawnTimer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for drops in GameManager.dropped_items:
		var drop = GameManager.dropped_items[drops]
		if drop["scene"] == self.name:
			var item_scene = load("res://scenes/items/" + drop["item_name"] + ".tscn")
			var item_instance = item_scene.instantiate()
			item_instance.item_id = drop["item_id"]
			item_instance.position = drop["position"]
			item_instance.max_take = GameManager.takenID[drop["item_id"]]
			$Items.add_child(item_instance)
	randomize()
	timer.wait_time = randi_range(8, 13)
	timer.start()
	
	$Player.position.y = GameManager.y_pos
	$Player.position.x = GameManager.x_pos
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_forest_scene_trigger_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		GameManager.y_pos = body.position.y
		GameManager.x_pos = 616.0
		GameManager.last_dir = "w"
		call_deferred("change_scene_to_forest")

func change_scene_to_forest():
	get_tree().change_scene_to_file("res://scenes/OuterForest.tscn")


func _on_enemy_spawn_timer_timeout() -> void:
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	
	timer.wait_time = rng.randi_range(8, 13)
	
	$Player/Path2D/PathFollow2D.progress = rng.randf_range(0.0, 1639.0)
	var enemy_instance = enemy.instantiate()
	
	enemy_instance.global_position = $Player/Path2D/PathFollow2D/Marker2D.global_position
	$EnemyLayer.add_child(enemy_instance)
	timer.start()
