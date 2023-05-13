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
var stringValue = "Start a game by pressing the spacebar"

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

# scoring
var playerScore = 0
var playerScoreText = str(playerScore)
var playerTextHalfWidth
var playerScorePosition

var aiScore = 0
var aiScoreText = str(aiScore)
var aiTextHalfWidth
var aiScorePosition

const MAX_SCORE = 3
var isPlayerWin

func _ready() -> void:
	font.font_data = robotoFile
	font.fixed_size = fontSize
	halfWidthFont = font.get_string_size(stringValue).x/2
	heightFont = font.get_height()
	stringPosition = Vector2(halfScreenWidth - halfWidthFont, heightFont)
	
	playerTextHalfWidth = font.get_string_size(playerScoreText).x/2
	playerScorePosition = Vector2(halfScreenWidth - (halfScreenWidth/2) - playerTextHalfWidth, heightFont + 50)
	aiTextHalfWidth = font.get_string_size(aiScoreText).x/2
	aiScorePosition = Vector2(halfScreenWidth + (halfScreenWidth/2) - aiTextHalfWidth, heightFont + 50)

func _physics_process(delta: float) -> void:
	deltaKeyPress += delta
	
	match currentGameState:
		GAME_STATE.MENU:
			if(isPlayerWin == true):
				changeString("Player wins! Press spacebar to start a new game")
			elif(isPlayerWin == false):
				changeString("Ai wins! Press spacebar to start a new game")
			if(Input.is_key_pressed(KEY_SPACE) and 
			deltaKeyPress > MAX_KEY_TIME):
				currentGameState = GAME_STATE.SERVE
				deltaKeyPress = RESET_DELTA_KEY
				playerScoreText = str(playerScore)
				aiScoreText = str(aiScore)
		GAME_STATE.SERVE:
			setStartingPosition()
			queue_redraw()
			
			if(MAX_SCORE == playerScore):
				currentGameState = GAME_STATE.MENU
				playerScore = 0
				aiScore = 0
				isPlayerWin = true
			if(MAX_SCORE == aiScore):
				currentGameState = GAME_STATE.MENU
				playerScore = 0
				aiScore = 0
				isPlayerWin = false
			
			if isPlayerServe:
				ballSpeed = startingSpeed
				changeString("Player Serve: Press spacebar so serve")
				
			if !isPlayerServe:
				ballSpeed = -startingSpeed
				changeString("Ai Serve: Press spacebar so serve")
			
			if(Input.is_key_pressed(KEY_SPACE) and 
			deltaKeyPress > MAX_KEY_TIME):
				currentGameState = GAME_STATE.PLAY
				deltaKeyPress = RESET_DELTA_KEY
		GAME_STATE.PLAY:
			changeString("PLAY!!!")
			if(Input.is_key_pressed(KEY_SPACE) and 
			deltaKeyPress > MAX_KEY_TIME):
				currentGameState = GAME_STATE.SERVE
				deltaKeyPress = RESET_DELTA_KEY
			
			ballPosition += ballSpeed * delta
			
			if ballPosition.x <= 0:
				currentGameState = GAME_STATE.SERVE
				deltaKeyPress = RESET_DELTA_KEY
				isPlayerServe = true
				aiScore += 1
				aiScoreText = str(aiScore)
				
			if ballPosition.x >= screenWidth:
				currentGameState = GAME_STATE.SERVE
				deltaKeyPress = RESET_DELTA_KEY
				isPlayerServe = false
				playerScore += 1
				playerScoreText = str(playerScore)
				
			if ballPosition.y - ballRadius <= 0.0:
				ballSpeed.y = -ballSpeed.y
			if ballPosition.y + ballRadius >= screenHeight:
				ballSpeed.y = -ballSpeed.y
				
			# sectioning off the paddle to give it some y speed based on where it hits the  paddle
			if(Collisions.pointToRectangle(ballPosition, Rect2(playerPosition, paddleSize))):
				ballSpeed = Vector2(-ballSpeed.x, randf_range(-400.0, 400.0))
			
			if(Collisions.pointToRectangle(ballPosition, Rect2(aiPosition, paddleSize))):
				ballSpeed = Vector2(-ballSpeed.x, randf_range(-400.0, 400.0))
			
			if(Input.is_key_pressed(KEY_W)):
				playerPosition.y += -playerSpeed * delta
				playerPosition.y = clamp(playerPosition.y, 0.0, screenHeight - paddleSize.y)
				playerRectangle = Rect2(playerPosition, paddleSize)
			if(Input.is_key_pressed(KEY_S)):
				playerPosition.y += playerSpeed * delta
				playerPosition.y = clamp(playerPosition.y, 0.0, screenHeight - paddleSize.y)
				playerRectangle = Rect2(playerPosition, paddleSize)
			
			# ai paddle will chase the ball
			if ballPosition.y > aiPosition.y + (paddleSize.y/2 + 10):
				aiPosition.y += 250 * delta
			if ballPosition.y < aiPosition.y + (paddleSize.y/2 - 10):
				aiPosition.y -= 250 * delta
			aiPosition.y = clamp(aiPosition.y, 0.0, screenHeight - paddleSize.y)
			aiRectangle = Rect2(aiPosition, paddleSize)
				
			queue_redraw()

func _draw() -> void:
	draw_circle(ballPosition, ballRadius, ballColor)
	draw_rect(playerRectangle, paddleColor)
	draw_rect(aiRectangle, paddleColor)
	draw_string(font, stringPosition, stringValue)
	draw_string(font, playerScorePosition, playerScoreText)
	draw_string(font, aiScorePosition, aiScoreText)

func setStartingPosition():
	aiPosition = Vector2(screenWidth - (paddlePadding + paddleSize.x), halfScreenHeight - halfPaddleHeight)
	aiRectangle = Rect2(aiPosition, paddleSize)
	
	playerPosition = Vector2(paddlePadding, halfScreenHeight - halfPaddleHeight	)
	playerRectangle = Rect2(playerPosition, paddleSize)
	
	ballPosition = startingBallPosition

func changeString(newStringValue):
	stringValue = newStringValue
	halfWidthFont = font.get_string_size(stringValue).x/2
	stringPosition = Vector2(halfScreenWidth - halfWidthFont, heightFont)
	queue_redraw()
	
