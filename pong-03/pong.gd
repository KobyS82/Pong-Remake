extends Node2D

# screen values
@onready var screenWidth = get_tree().get_root().size.x
@onready var screenHeight = get_tree().get_root().size.y
@onready var halfScreenWidth = screenWidth/2
@onready var halfScreenHeight = screenHeight/2

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

# ballvariable
@onready var ballPosition = Vector2(halfScreenWidth,halfScreenHeight)

# player paddle
@onready var playerPosition = Vector2(paddlePadding, halfScreenHeight - halfPaddleHeight)
@onready var playerStartPosition = Rect2(playerPosition, paddleSize)

# ai paddle
@onready var aiPosition = Vector2(screenWidth - (paddlePadding + paddleSize.x), halfScreenHeight - halfPaddleHeight)
@onready var aiStartPosition = Rect2(aiPosition, paddleSize)

# string variable
var stringPosition

func _ready() -> void:
	print(get_tree().get_root().size)
	font.font_data = robotoFile
	font.fixed_size = fontSize
	halfWidthFont = font.get_string_size(stringValue).x/2
	heightFont = font.get_height()
	stringPosition = Vector2(halfScreenWidth - halfWidthFont, heightFont)

func _physics_process(delta: float) -> void:
	pass

func _draw() -> void:
	setStartingPosition()

func setStartingPosition():
	draw_circle(ballPosition, ballRadius, ballColor)
	draw_rect(playerStartPosition, paddleColor)
	draw_rect(aiStartPosition, paddleColor)
	draw_string(font, stringPosition, stringValue)
