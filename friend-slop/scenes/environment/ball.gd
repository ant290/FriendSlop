extends RigidBody3D

@onready var area_3d: Area3D = $Area3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_3d.body_entered.connect(on_ball_hit)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func on_ball_hit(body: Node3D):
	if body.is_in_group("Players"):
		call_deferred("queue_free")
