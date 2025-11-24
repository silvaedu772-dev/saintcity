extends Area2D


# Called when the node enters the scene tree for the first time.

@export var nivel_selecionado = ""
var player_spawn:Vector2 = Vector2.ZERO

func _on_body_entered(_body: Node2D) -> void:
	call_deferred("selecionar_nivel")# Replace with function body.
	
func selecionar_nivel():
	get_tree().change_scene_to_file("res://scenes/" +nivel_selecionado+".tscn")
