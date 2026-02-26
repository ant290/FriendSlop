extends RigidBody3D

@export var damage:= 10

@onready var area_3d: Area3D = $Area3D

var source: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_3d.body_entered.connect(on_ball_hit)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func on_ball_hit(body: Node3D):
	if not is_multiplayer_authority():
		return
	
	if body.has_method('take_damage'):
		body.take_damage(damage, source)
		
	if body.is_in_group("Players"):
		call_deferred("queue_free")
