@tool
extends EditorPlugin

const AUTOLOAD_NAME = "RushRequest"

func _enter_tree():
	add_autoload_singleton(AUTOLOAD_NAME, "res://addons/rush_request/rush_request.gd")


func _exit_tree():
	remove_autoload_singleton(AUTOLOAD_NAME)
