extends Node2D

# states
enum GAME_STATE {MENU, SERVE, PLAY}
var isPlayerServe = true

# current state
var currentGameState = GAME_STATE.MENU

# screen values
@onready var screen: Rect2 = get_tree().get_root().get_visible_rect()
@onready var screenBox: BoundBox = BoundBox.new(screen)
# object instancing
@onready var ball: Ball = Ball.new(screenBox.getCenter())
@onready var playerPaddle: PlayerPaddle = PlayerPaddle.new(screenBox)

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

# ai paddle
@onready var aiPosition = Vector2(screenBox.getSize().x - (paddlePadding + paddleSize.x), screenBox.getHalfHeight() - halfPaddleHeight)
@onready var aiRectangle = Rect2(aiPosition, paddleSize)

# string variable
var stringPosition

# delta key
const RESET_DELTA_KEY = 0.0
const MAX_KEY_TIME = 0.3
var deltaKeyPress = RESET_DELTA_KEY

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
	add_child(ball)
	add_child(playerPaddle)
	
	font.font_data = robotoFile
	font.fixed_size = fontSize
	halfWidthFont = font.get_string_size(stringValue).x/2
	heightFont = font.get_height()
	stringPosition = Vector2(screenBox.getHalfWidth() - halfWidthFont, heightFont)
	
	playerTextHalfWidth = font.get_string_size(playerScoreText).x/2
	playerScorePosition = Vector2(screenBox.getHalfWidth() - (screenBox.getHalfWidth()/2) - playerTextHalfWidth, heightFont + 50)
	aiTextHalfWidth = font.get_string_size(aiScoreText).x/2
	aiScorePosition = Vector2(screenBox.getHalfWidth() + (screenBox.getHalfWidth()/2) - aiTextHalfWidth, heightFont + 50)

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
#				ball.resetBall((isPlayerServe))
				changeString("Player Serve: Press spacebar so serve")
			if !isPlayerServe:
#				ball.resetBall((isPlayerServe))
				changeString("Ai Serve: Press spacebar so serve")
			
			if(Input.is_key_pressed(KEY_SPACE) and 
			deltaKeyPress > MAX_KEY_TIME):
				currentGameState = GAME_STATE.PLAY
				deltaKeyPress = RESET_DELTA_KEY
		GAME_STATE.PLAY:
			playerPaddle.checkMovement(delta)
			changeString("PLAY!!!")
			if(Input.is_key_pressed(KEY_SPACE) and 
			deltaKeyPress > MAX_KEY_TIME):
				currentGameState = GAME_STATE.SERVE
				deltaKeyPress = RESET_DELTA_KEY
			
			ball.moveBall(delta)
			
			if screenBox.isPassLeftBound(ball.getPosition()):
				currentGameState = GAME_STATE.SERVE
				deltaKeyPress = RESET_DELTA_KEY
				isPlayerServe = true
				aiScore += 1
				aiScoreText = str(aiScore)
				
			if screenBox.isPassRightBound(ball.getPosition()):
				currentGameState = GAME_STATE.SERVE
				deltaKeyPress = RESET_DELTA_KEY
				isPlayerServe = false
				playerScore += 1
				playerScoreText = str(playerScore)
				
			if screenBox.isPassTopBound(ball.getTopPoint()):
				ball.inverseYSpeed()
			if screenBox.isPassBottomBound(ball.getBottomPoint()):
				ball.inverseYSpeed()
				
			# sectioning off the paddle to give it some y speed based on where it hits the  paddle
			if(Collisions.pointToRectangle(ball.getPosition(), playerPaddle.getRect())):
				ball.inverseXSpeed()
			
			if(Collisions.pointToRectangle(ball.getPosition(), Rect2(aiPosition, paddleSize))):
				ball.inverseXSpeed()
			
			
			# ai paddle will chase the ball
			if ball.getPosition().y > aiPosition.y + (paddleSize.y/2 + 10):
				aiPosition.y += 250 * delta
			if ball.getPosition().y < aiPosition.y + (paddleSize.y/2 - 10):
				aiPosition.y -= 250 * delta
			aiPosition.y = clamp(aiPosition.y, 0.0, screenBox.getSize().y - paddleSize.y)
			aiRectangle = Rect2(aiPosition, paddleSize)
				
			queue_redraw()

func _draw() -> void:
	draw_rect(aiRectangle, paddleColor)
	draw_string(font, stringPosition, stringValue)
	draw_string(font, playerScorePosition, playerScoreText)
	draw_string(font, aiScorePosition, aiScoreText)

func setStartingPosition():
	aiPosition = Vector2(screenBox.getSize().x - (paddlePadding + paddleSize.x), screenBox.getHalfHeight() - halfPaddleHeight)
	aiRectangle = Rect2(aiPosition, paddleSize)
	
	playerPaddle.resetPosition()
	ball.resetBall(isPlayerServe)

func changeString(newStringValue):
	stringValue = newStringValue
	halfWidthFont = font.get_string_size(stringValue).x/2
	stringPosition = Vector2(screenBox.getHalfWidth() - halfWidthFont, heightFont)
	queue_redraw()
	
