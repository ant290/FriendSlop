extends Node3D

@onready var spawn_container: Node3D = $SpawnContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.forest = self
	Global.spawn_container = spawn_container

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
