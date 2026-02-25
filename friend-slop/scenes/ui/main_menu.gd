extends CanvasLayer

@onready var enet_menu: VBoxContainer = $Control/Center/MarginContainer/HBoxContainer/EnetMenu
@onready var button_quit: Button = $Control/Center/MarginContainer/HBoxContainer/EnetMenu/ButtonQuit
@onready var button_join: Button = $Control/Center/MarginContainer/HBoxContainer/EnetMenu/ButtonJoin

@onready var tube_menu: VBoxContainer = $Control/Center/MarginContainer/HBoxContainer/TubeMenu
@onready var line_edit_session: LineEdit = $Control/Center/MarginContainer/HBoxContainer/TubeMenu/LineEditSession
@onready var line_edit_username: LineEdit = $Control/Center/MarginContainer/HBoxContainer/TubeMenu/LineEditUsername
@onready var button_join_tube: Button = $Control/Center/MarginContainer/HBoxContainer/TubeMenu/ButtonJoinTube
@onready var button_quit_tube: Button = $Control/Center/MarginContainer/HBoxContainer/TubeMenu/ButtonQuitTube
@onready var button_create_tube: Button = $Control/Center/MarginContainer/HBoxContainer/TubeMenu/ButtonCreateTube

const WORLD_FOREST = preload("uid://bdvl2gj6icaet")
const PLAYER = preload("uid://1yude8pbi567")

func _ready() -> void:
	if Network.tube_enabled:
		enet_menu.hide()
	else:
		tube_menu.hide()
	
	button_join.pressed.connect(on_join)
	button_quit.pressed.connect(func(): get_tree().quit())
	
	line_edit_session.text_changed.connect(update_session)
	line_edit_username.text_changed.connect(update_username)
	button_join_tube.disabled = true
	button_join_tube.pressed.connect(on_join_tube)
	button_quit_tube.pressed.connect(func(): get_tree().quit())
	button_create_tube.pressed.connect(on_create_tube)
	
	Network.tube_client.error_raised.connect(on_error_raised)
	
	if OS.has_feature('server'):
		Network.start_server()
		await get_tree().create_timer(0.1).timeout
		add_world()	

func on_join():
	Network.join_server()
	add_world()

func add_world():
	var new_world = WORLD_FOREST.instantiate()
	get_tree().current_scene.add_child(new_world)
	hide()

func update_session(new_text: String):
	if new_text != '':
		button_join_tube.disabled = false

func update_username(new_text: String):
	Global.username = new_text

func on_join_tube():
	Network.tube_join(line_edit_session.text)
	multiplayer.connected_to_server.connect(add_world)

func on_create_tube():
	Network.tube_create()
	add_world()
	
func on_error_raised(_code, _message):
	line_edit_session.text = ''
	button_join_tube.add_theme_color_override('font_disabled_color', Color.DARK_RED)
	button_join_tube.disabled = true
	Network.clean_up_signals()
	
