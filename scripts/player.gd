extends CharacterBody2D

@onready var animacao: AnimatedSprite2D = $AnimacaoPlayer

const MAX_JUMP = 2 #Número máximo de pulos do personagem
var jump_count = 0 #Contador de pulos que o player deu

const SPEED = 120.0
const JUMP_VELOCITY = -400.0


var direction = 0 #Variavel de direção do player 

enum EstadoPlayer{
	andando, 
	parado,
	pulando,
}
var estado_atual: EstadoPlayer 
var direcao = 0

func _physics_process(delta: float) -> void:
	#Adição de gravidade
	ativar_gravidade(delta)

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if is_on_floor():
		
		
		if direction > 0:
			animacao.flip_h = false
			animacao.play("andando")
		elif direction<0:
			animacao.flip_h = true
			animacao.play("andando")
		else:
			animacao.play("parado")
			
	else:
		animacao.play("pulando")
	

	move_and_slide()

func ativar_gravidade(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta
	
func mover(delta):
	if direction:
		velocity.x = move_toward(velocity.x, direction * SPEED, 400 * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, 400 * delta)
		
	
func atualizar_animacao(): #Função que verifica se a atualização do estado do player
	direction = Input.get_axis("left", "right")
	if direction < 0:
		animacao.flip_h = true #Se a animação  
	elif direction > 0:
		animacao.flip_h = false
	
func pode_pular():#Função que verifica se o contador de pulos for menos que o número de pulos
	
	if jump_count < MAX_JUMP:
		return true #Significa que o player pode pular
	else:
		return false #Significa que player não pode pular
		
func pular(delta):
	ativar_gravidade(delta) #Ativa a garvidade para puxar o palyer para o chão
	mover(delta) #Permite que o player se mova durante o pulo
	
	#Verifica se o botão de pulo esta sendo pressionado e se ele pode pular
	if Input.is_action_just_pressed("jump") && pode_pular():
		return # Aqui ficará o estado dele pulando
		
		#Verifica se o player está no ar ( ou seja se ele não esta no chão)
	if velocity.y > 0:
		return #Aqui fica o estado dele caindo

func parado(delta):
	ativar_gravidade(delta) #Ativa a gravidade para o estado do player
	mover(delta)
	
	if velocity.x !=0:
		return
	
	if Input.is_action_just_pressed("jump"):
		preparar_pulo() #Prepara o player para a mudança de estado
		return

func preparar_pulo():
	estado_atual = EstadoPlayer.pulando#Muda o estado do player para pulando
	animacao.play("pulando")#Muda a animação do Player para pulando
	velocity.y = JUMP_VELOCITY #Faz o player pular
	jump_count+=1 #Soma
	
func preparar_andando():
	estado_atual = EstadoPlayer.andando
	animacao.play("andando")
	
