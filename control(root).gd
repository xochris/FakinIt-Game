class_name GameUI
extends Control

@onready var main_menu = $MainMenu
@onready var how_to_play = $HowToPlay
@onready var host = $Host
@onready var game_settings = $GameSettings

func _ready():
	# set initial visibility if nodes exist
	if main_menu:
		main_menu.visible = true
	if how_to_play:
		how_to_play.visible = false
	if host:
		host.visible = false
	if game_settings:
		game_settings.visible = false

# Play button functionality
func _on_play_pressed():
	if main_menu and host:
		main_menu.visible = false
		host.visible = true

# HTP button functionality
func _on_htp_button_pressed():
	if main_menu and how_to_play:
		main_menu.visible = false
		how_to_play.visible = true

# Quit button functionality
func _on_quit_pressed():
	get_tree().quit()

# Back Button returns to previous scene
func _on_back_pressed():
	if how_to_play and main_menu:
		how_to_play.visible = false
		main_menu.visible = true
	
func _on_host_pressed():
	if main_menu and host:
		main_menu.visible = false
		game_settings.visible = true
