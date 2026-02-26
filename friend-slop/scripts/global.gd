extends Node

var username := ''

var forest: Node3D
var spawn_container: Node3D

const BALL = preload("uid://chpi3evv0e4w8")

@rpc("any_peer", "call_local")
func shoot_ball(pos, dir, force):
	var new_ball: RigidBody3D = BALL.instantiate()
	new_ball.source = multiplayer.get_remote_sender_id()
	new_ball.position = pos + Vector3(0, 1, 0) + (dir * 2)
	spawn_container.add_child(new_ball, true)
	new_ball.apply_central_impulse(dir * force)
