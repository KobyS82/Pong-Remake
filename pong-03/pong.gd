extends Node2D

# states
enum GAME_STATE {MENU, SERVE, PLAY}
var isPlayerServe = true

# current state
var currentGameState = GAME_STATE.MENU

# screen values
@onready var screenWidth = get_tree().get_root().size.x
@onready var screenHeight = get_tree().get_root().size.y
@onready var halfScreenWidth = screenWidth/2.0
@onready var halfScreenHeight = screenHeight/2.0

# ball variables
var ballRadius = 10.0
var ballColor = Color.WHITE

# paddle variables
var paddleColor = Color.WHITE
var paddleSize = Vector2(10.0,100.0)
var halfPaddleHeight = paddleSize.y/2
var paddlePadding = 10.0

# font variables
var font = FontFile.new()
var robotoFile = load("res://Roboto-Light.ttf")
var fontSize = 24
# has to wait to set width/height till data and size gets set in _ready function
var halfWidthFont
var heightFont
var stringValue = "Hello World!"

# ball variable
@onready var startingBallPosition = Vector2(halfScreenWidth,halfScreenHeight)
@onready var ballPosition = startingBallPosition

# player paddle
@onready var playerPosition = Vector2(paddlePadding, halfScreenHeight - halfPaddleHeight)
@onready var playerRectangle = Rect2(playerPosition, paddleSize)

# ai paddle
@onready var aiPosition = Vector2(screenWidth - (paddlePadding + paddleSize.x), halfScreenHeight - halfPaddleHeight)
@onready var aiRectangle = Rect2(aiPosition, paddleSize)

# string variable
var stringPosition

# delta key
const RESET_DELTA_KEY = 0.0
const MAX_KEY_TIME = 0.3
var deltaKeyPress = RESET_DELTA_KEY

# ball speed
var startingSpeed = Vector2(400.0,0.0)
var ballSpeed = -startingSpeed

var playerSpeed = 200.0

func _ready() -> void:
	#print(get_tree().get_root().size)
	font.font_data = robotoFile
	font.fixed_size = fontSize
	halfWidthFont = font.get_string_size(stringValue).x/2
	heightFont = font.get_height()
	stringPosition = Vector2(halfScreenWidth - halfWidthFont, heightFont)

func _physics_process(delta: float) -> void:
	
	deltaKeyPress += delta
	
	match currentGameState:
		GAME_STATE.MENU:
			changeString("MENU!!!!")
			if(Input.is_key_pressed(KEY_SPACE) and 
			deltaKeyPress > MAX_KEY_TIME):
				currentGameState = GAME_STATE.SERVE
				deltaKeyPress = RESET_DELTA_KEY
		GAME_STATE.SERVE:
			ballPosition = startingBallPosition
			
			if isPlayerServe:
				ballSpeed = startingSpeed
				changeString("Player Serve")
				
			if !isPlayerServe:
				ballSpeed = -startingSpeed
				changeString("Ai Serve")
			
			if(Input.is_key_pressed(KEY_SPACE)and 
			deltaKeyPress > MAX_KEY_TIME):
				currentGameState = GAME_STATE.PLAY
				deltaKeyPress = RESET_DELTA_KEY
		GAME_STATE.PLAY:
			changeString("PLAY!!!")
			if(Input.is_key_pressed(KEY_SPACE)and 
			deltaKeyPress > MAX_KEY_TIME):
				currentGameState = GAME_STATE.SERVE
				deltaKeyPress = RESET_DELTA_KEY
			
			ballPosition += ballSpeed * delta
			
			if ballPosition.x <= 0:
				currentGameState = GAME_STATE.SERVE
				deltaKeyPress = RESET_DELTA_KEY
				isPlayerServe = true
				
			if ballPosition.x >= screenWidth:
				currentGameState = GAME_STATE.SERVE
				deltaKeyPress = RESET_DELTA_KEY
				isPlayerServe = false
				
			if ballPosition.y - ballRadius <= 0.0:
				ballSpeed.y = -ballSpeed.y
			if ballPosition.y + ballRadius >= screenHeight:
				ballSpeed.y = -ballSpeed.y
				
			if(ballPosition.x - ballRadius >= playerPosition.x and
			ballPosition.x - ballRadius <= playerPosition.x + paddleSize.x):
				var PaddleDivide = paddleSize.y/3
				
				if(ballPosition.y >= playerPosition.y and 
				ballPosition.y < playerPosition.y + PaddleDivide):
					var tempBall = Vector2(-ballSpeed.x, -400.0)
					ballSpeed = tempBall
				elif(ballPosition.y >= playerPosition.y and 
				ballPosition.y < playerPosition.y + PaddleDivide*2):
					var tempBall = Vector2(-ballSpeed.x, 0.0)
					ballSpeed = tempBall
				elif(ballPosition.y >= playerPosition.y and 
				ballPosition.y < playerPosition.y + PaddleDivide*3):
					var tempBall = Vector2(-ballSpeed.x, 400.0)
					ballSpeed = tempBall
			
			if(ballPosition.x + ballRadius >= aiPosition.x and
			ballPosition.x + ballRadius <= aiPosition.x + paddleSize.x):
				var PaddleDivide = paddleSize.y/3
				
				if(ballPosition.y >= aiPosition.y and 
				ballPosition.y <= aiPosition.y + PaddleDivide):
					var tempBall = Vector2(-ballSpeed.x, -400.0)
					ballSpeed = tempBall
				elif(ballPosition.y >= aiPosition.y and 
				ballPosition.y <= aiPosition.y + PaddleDivide*2):
					var tempBall = Vector2(-ballSpeed.x, 0.0)
					ballSpeed = tempBall
				elif(ballPosition.y >= aiPosition.y and 
				ballPosition.y <= aiPosition.y + PaddleDivide*3):
					var tempBall = Vector2(-ballSpeed.x, 400.0)
					ballSpeed = tempBall
			
			if(Input.is_key_pressed(KEY_W)):
				playerPosition.y += -playerSpeed * delta
				playerPosition.y = clamp(playerPosition.y, 0.0, screenHeight - paddleSize.y)
				playerRectangle = Rect2(playerPosition, paddleSize)
			if(Input.is_key_pressed(KEY_S)):
				playerPosition.y += playerSpeed * delta
				playerPosition.y = clamp(playerPosition.y, 0.0, screenHeight - paddleSize.y)
				playerRectangle = Rect2(playerPosition, paddleSize)
				
			aiPosition.y = ballPosition.y - paddleSize.y/2
			aiPosition.y = clamp(aiPosition.y, 0.0, screenHeight - paddleSize.y)
			aiRectangle = Rect2(aiPosition, paddleSize)
				
			queue_redraw()

func _draw() -> void:
	setStartingPosition()

func setStartingPosition():
	draw_circle(ballPosition, ballRadius, ballColor)
	draw_rect(playerRectangle, paddleColor)
	draw_rect(aiRectangle, paddleColor)
	draw_string(font, stringPosition, stringValue)

func changeString(newStringValue):
	stringValue = newStringValue
	halfWidthFont = font.get_string_size(stringValue).x/2
	stringPosition = Vector2(halfScreenWidth - halfWidthFont, heightFont)
	queue_redraw()
	
