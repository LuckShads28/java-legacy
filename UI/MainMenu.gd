extends Control

func _on_play_pressed():
	get_tree().change_scene_to_file("res://UI/select_world.tscn")

func _on_pepak_pressed():
	pass # Replace with function body.

func _on_exit_pressed():
	get_tree().quit()
