extends CanvasLayer

@onready var button_quit: Button = $Control/Center/MarginContainer/VBoxContainer/ButtonQuit
@onready var button_join: Button = $Control/Center/MarginContainer/VBoxContainer/ButtonJoin
const WORLD_FOREST = preload("uid://bdvl2gj6icaet")
const PLAYER = preload("uid://1yude8pbi567")

func _ready() -> void:
	button_join.pressed.connect(on_join)
	button_quit.pressed.connect(func(): get_tree().quit())
	
	if OS.has_feature('server'):
		Network.start_server()
		add_world()	
		hide()

func on_join():
	Network.join_server()
	add_world()
	hide()

func add_world():
	var new_world = WORLD_FOREST.instantiate()
	get_tree().current_scene.add_child.call_deferred(new_world)
