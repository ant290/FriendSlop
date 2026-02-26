extends Node3D

@onready var spawn_container: Node3D = $SpawnContainer
@onready var timer_target: Timer = %TimerTarget

const TARGET = preload("uid://cyrkbcrco03nq")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.forest = self
	Global.spawn_container = spawn_container
	
	timer_target.timeout.connect(spawn_target)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func spawn_target():
	if is_multiplayer_authority() and get_tree().get_node_count_in_group('Targets') < 10:
		var new_target = TARGET.instantiate()
		
		var rand_x = randf_range(-25, 25)
		var rand_z = randf_range(-25, 25)
		
		new_target.position = Vector3(rand_x, 1.0, rand_z)
	
		spawn_container.add_child(new_target, true)
