extends Area2D


# Called when the node enters the scene tree for the first time.

@export var nivel_selecionado = "" #Defikne a proxima fase 
#Função para quando o corpo entra na área 
func _on_body_entered(_body: Node2D) -> void:
	#Encerra o processamento de física e a fase atual e chama o próximo nivel
	call_deferred("selecionar_nivel")# Replace with function body.
# Função que carrega o proximo nível
func selecionar_nivel():
	#Carrega a próxima fase a partir da pasta scenes
	get_tree().change_scene_to_file("res://scenes/" +nivel_selecionado+".tscn")
