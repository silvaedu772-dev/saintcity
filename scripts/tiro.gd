extends Area2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

var direction = 1
const SPEED = 80



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



func _process(delta: float) -> void:
	position.x += SPEED * delta * direction
	
func definir_direction(direcao_inimigo):
	self.direction=direcao_inimigo
	if direction > 0:
		anim.flip_h = false
		print("Tiro para direita")
	else:
		anim.flip_h = true
		print("Tiro para esquerda")


func _on_area_entered(_area: Area2D) -> void:
	queue_free()


func _on_body_entered(_body: Node2D) -> void:
	queue_free()


func _on_timer_timeout() -> void:
	queue_free()# Replace with function body.
