extends Node2D
class_name Game

func _ready():
	RefManager.gameRef = self
	RefManager.stageRef = get_node("Stage")
	RefManager.playerRef = get_node("Player")
