extends CanvasLayer

@onready var button_quit: Button = $Control/Center/MarginContainer/VBoxContainer/ButtonQuit
@onready var button_join: Button = $Control/Center/MarginContainer/VBoxContainer/ButtonJoin

func _ready() -> void:
	button_join.pressed.connect(on_join)
	button_quit.pressed.connect(func(): get_tree().quit())

func on_join():
	print('JOINED!')
