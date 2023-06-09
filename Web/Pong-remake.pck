GDPC                 �                                                                         T   res://.godot/exported/133200997/export-36103047ef9f34a3c5cf69fc3d37133b-PongGame.scn�(      k      (�
����pg
�.�    ,   res://.godot/global_script_class_cache.cfg          �      o�����.�u�J8
/    \   res://.godot/imported/Pong-remake.apple-touch-icon.png-d4b4b09d5b1ccbcf38450643d3bbc392.ctex�]      p      韌��WbC1��    P   res://.godot/imported/Pong-remake.icon.png-5fbdedbd0a8d4ac33f27bdea71669861.ctex }      ^      2��r3��MgB�[79    L   res://.godot/imported/Pong-remake.png-d99745d5c48407fe384ce0bf2b317f1c.ctex P�      -      �%�$����<�׿�+    P   res://.godot/imported/Roboto-Light.ttf-5cab08b888d7029a314f96d1d7a3342c.fontdata@�      -8     ΢�(���H�{�8��o    T   res://.godot/imported/pong-remake-picture.JPG-1a67fe05efc4a234ac315cee438d72f2.ctex P+      �1      {��L��`q��2+�k       res://.godot/uid_cache.bin  ��     �       8x�p�*�k�y���'s    0   res://Pong-remake.apple-touch-icon.png.import   @|      �       v'��cY�V�'l��    $   res://Pong-remake.icon.png.import   ��      �       ��������LAc       res://Pong-remake.png.importp�      �       �:α�!^nB�J�yW�        res://Roboto-Light.ttf.import   p�     �       �.�Mv+P%�v?c       res://pong-03/Ball/Ball.gd  �      <      ���5�Em�U�eŰ       res://pong-03/GameState.gd  �            �e��wv�p5�
H�݇        res://pong-03/Misc/BoundBox.gd  �      �      9�6��w%[V�W�#�O        res://pong-03/Misc/Collisions.gd�
      �      �ȯ����w�u        res://pong-03/Paddle/Paddle.gd  �      �       g
$wV�����5(��    $   res://pong-03/Paddle/PlayerPaddle.gd�             YO�x���5���u(    $   res://pong-03/PongGame.tscn.remap    �     e       C���ľ�ʛu�����    $   res://pong-remake-picture.JPG.import ]      �       ]V:�tV�mb�e|����       res://project.binary��     �      U]���B����N��    ��Dylist=Array[Dictionary]([{
"base": &"Node2D",
"class": &"Ball",
"icon": "",
"language": &"GDScript",
"path": "res://pong-03/Ball/Ball.gd"
}, {
"base": &"Resource",
"class": &"BoundBox",
"icon": "",
"language": &"GDScript",
"path": "res://pong-03/Misc/BoundBox.gd"
}, {
"base": &"Resource",
"class": &"Collisions",
"icon": "",
"language": &"GDScript",
"path": "res://pong-03/Misc/Collisions.gd"
}, {
"base": &"Node2D",
"class": &"Paddle",
"icon": "",
"language": &"GDScript",
"path": "res://pong-03/Paddle/Paddle.gd"
}, {
"base": &"Paddle",
"class": &"PlayerPaddle",
"icon": "",
"language": &"GDScript",
"path": "res://pong-03/Paddle/PlayerPaddle.gd"
}])
�hextends Node2D

class_name Ball

var _color: Color = Color.WHITE
var _speed: Vector2 = Vector2(400.0, 0.0)
var _radius: float = 10.0
var _resetPos: Vector2 
var _pos: Vector2
var _resetSpeed: Vector2
var _playerServe: bool # dont think I need this


func _init(startPos: Vector2, playerServe:= true):
	_pos = startPos
	_resetPos = startPos # assuming center of the screen is being passed
	_playerServe = playerServe
	_resetSpeed = _speed


func _draw() -> void:
	draw_circle(_pos, _radius, _color)

func moveBall(delta: float) -> void:
	_pos += _speed * delta
	queue_redraw()

func resetBall(playerServe: bool) -> void:
	_pos = _resetPos # uassumes ball is in the center
	_speed = _resetSpeed if playerServe else -_resetSpeed
	queue_redraw()

func inverseYSpeed() -> void:
	_speed.y = -_speed.y

func inverseXSpeed() -> void:
	_speed = Vector2(-_speed.x, randf_range(-400.0, 400.0))
	
func getPosition() -> Vector2:
	return _pos

func getTopPoint() -> Vector2:
	return Vector2(_pos.x, _pos.y - _radius)

func getBottomPoint() -> Vector2:
	return Vector2(_pos.x, _pos.y + _radius)




ѭ�extends Resource

class_name BoundBox

var _box: Rect2
var _topBound: float
var _bottomBound: float
var _rightBound: float
var _leftBound: float

func _init(rect: Rect2) -> void:
	_box = rect
	_leftBound = _box.position.x
	_rightBound = _leftBound + _box.size.x
	_topBound = _box.position.y
	_bottomBound = _topBound + _box.size.y

func getHalfHeight() -> float:
	return _box.size.y/2.0

func getHalfWidth() -> float:
	return _box.size.x/2.0

func getCenter() -> Vector2:
	return _box.size /2.0

func getRect() -> Rect2:
	return _box

func getSize() -> Vector2:
	return _box.size

func getPosition() -> Vector2:
	return _box.position

func getBox() -> BoundBox:
	return self

func isPassLeftBound(position: Vector2) -> bool:
	return position.x <= _leftBound

func isPassRightBound(position: Vector2) -> bool:
	return position.x >= _rightBound

func isPassTopBound(position: Vector2) -> bool:
	return position.y <= _topBound

func isPassBottomBound(position: Vector2) -> bool:
	return position.y >= _bottomBound
r��<+U'�.��gextends Resource

class_name Collisions

static func pointToPoint(pointA: Vector2, pointB: Vector2) -> bool:
	return pointA.x == pointB.x and pointA.y == pointB.y
	
static func pointToRectangle(point: Vector2, rect: Rect2) -> bool:
	var rectLeft: float = rect.position.x
	var rectRight: float = rectLeft + rect.size.x
	var rectTop: float = rect.position.y
	var rectBottom: float = rectTop + rect.size.y
	
	return (rectLeft <= point.x and point.x < rectRight
	and rectTop <= point.y and point.y <= rectBottom)
+8extends Node2D

class_name Paddle

# paddle variables
var _color: Color = Color.WHITE
var _size: Vector2 = Vector2(10.0,100.0)
var _padding: float = 10.0
var _speed: Vector2 = Vector2(0.0, 400.0) # moves only in the y-axis
var _resetSpeed: Vector2 = _speed
var _halfHeight: float = _size.y/2.0

# handled by subclass
var _rect: Rect2
var _pos: Vector2
var _resetPos: Vector2
var _boundBox: BoundBox

func _draw() -> void:
	draw_rect(_rect, _color)

func getHeight() -> float:
	return _halfHeight

func getRect() -> Rect2:
	return _rect

func resetPosition() -> void:
	_pos = _resetPos
	_rect = Rect2(_pos, _size)
	queue_redraw()

func updatePosition() -> void:
	_pos.y = clamp(_pos.y, _boundBox.getPosition().y, _boundBox.getSize().y - _size.y)
	_rect = Rect2(_pos, _size)
	queue_redraw()

# Overidden subclass
func moveUp(delta: float) -> void:
	assert(false, "Methed moveUp has not been overridden")

# Overidden subclass
func moveDown(delta: float) -> void:
	assert(false, "Methed moveDown has not been overridden")
�[�Z\extends Paddle

class_name PlayerPaddle

func _init(box:BoundBox) -> void:
	_boundBox = box
	_pos = Vector2(_padding, _boundBox.getHalfHeight() - _halfHeight)
	_resetPos = _pos
	_rect = Rect2(_pos, _size)

func checkMovement(delta: float):
	if(Input.is_key_pressed(KEY_W)):
		moveUp(delta)
		updatePosition()
	if(Input.is_key_pressed(KEY_S)):
		moveDown(delta)
		updatePosition()

func moveUp(delta: float) -> void: 
	_pos.y -= _speed.y * delta

func moveDown(delta: float) -> void: 
	_pos.y += _speed.y * delta
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
	
���oRSRC                     PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       Script    res://pong-03/GameState.gd ��������      local://PackedScene_c6lfo          PackedScene          	         names "         Node2D    script    	   variants                       node_count             nodes     	   ��������        ����                    conn_count              conns               node_paths              editable_instances              version             RSRC��x��GST2   �  w     ����               �w       r1  RIFFj1  WEBPVP8L^1  /��� �(nI����c�F��3��u5�#w]<f�<��|��~ߒm�6m'��n��[{��9�/�3c۶m�(ٹ���F�眛HE�m�i[�s$7e��K�?�����LN�u�܀];�-Y�]�n�h_R�N� EN�A)JO�������"���?#��UfO��K�m+����$��٢V��W��df733333�̌b��I	������"R�ݳV���m�n�����L�(�ek�.��?�N��@�����mko�F�y_�HJT��Xi�KzϷ���gͷ��,ϸJb�
�y��ܶ�$Ys�LК=���Ȳ�=m#�������=CK��db�d�;�����n)���1��O���i�m���!Yk}�c��W�JB	P9q*xq�Cԋ��ĩC]h�B%iZ���9�pLe�Ogr���n)����O��m��6:���N?��T��y$��_oYYϿpD�ոm1Iﮝ����W�Z-�)��L�I4����KոT�ˣay4,���,�e���Q٣4�J��"��@*~��GK�%ЊdS�lJ�D�fK:��
:�Y�
��t��;�=]:�-����?�s~�9�tV�YA��M{?:�Ow��nvf�a�4�S:s�3W��b�,K{СPСԡtF]�QWf{z�N�Uށ��'3��l��4�tֵ=��N؛��w��9{ٜ���)/�_����}=�a6�av��;{��8�f�F�f�(P��#P���B
	$C)�A4�C	@��{tv`V ��&@������cb��si�҈+\�A#R>$v�Q���hm� ��\|���\�Nv3%��9O��Kɥ��[rBB�� �4h(%F�����Va��>`���À  o�/"��;+��jC}=+�X|4���Ժ,`�&j]�.@	�@X�!��!χ�EY�6�n�f&���AQ4�N ���W�`��j(� ,¢V�
4BFȠA��(ނB�"-(�cB��܈n�n����7�Pq�\2v�i5ޛ3�P||�nЍ}&qQ\D;�3T��}`l���l��E6�u�u���5�BTh�����k����9X��m�����導XG| ֈ5gg��h	-D(�x�1���պ�n͢�����f�,�-~%~e�{��i-�b�#^��u*Ui���}J2d\�%��ۀ�"�D�Dh����ۄ��w���Ax�Dp"X���rB�a#l�`��Ѡ�࿷�5�dȀ����v찃@���V�7�^)g7���xY �}J8� C�6@�J���fC��
THC  H!
H�9?
������� 0�}�q�+�{��u��R�B����Ga����v�.r�Ȑ����:TP���ZEAk�VD� �B�\w�yO���~K<�_/'�^)(�@IAABx�c+��x���Z��C'���{�у&<�V�8��a����]r"冓�^��-�If)X   p�Ai'-z�# тX��� �3,� � �d  �(���U�;�,��j�[�6�PD�@hNs�H�h�Ԁ��aP\5���8�1E3��Bp���	Z��R���Ѡ!�0C�{O�p��i�1���c�.���P(��>����]u��/!M�B  �����P�H�f����V��x���������j�I���x�-�C��l��0�N(j����L����W�]��DM��R  ��7^�`Mi�$s��D�@ W�   j  

 @m�\��I�z<�-���N35I]�n��V!��:X�E
���hj�6D7�/T�\�cJǱ7���肚xKhA��I_�X�%�΀�e�G�F����ǔ�,�`�wag  @�� ��'.��,�`�v�px��6z���Dp"��>y"�>p-�=;�j��k��k�۵���⪥��Tk~�.��4�l�|������e)��� @B   H� ���88x��	j,��I c^(  @@   P  @Fo�G� j�a�V4��]�xċ�̬
�z״ը�Vhf`х,f鐋�PB��q�
�1c�1r�nP����%m�M�| ��%�YᆏU��*r�}?)o�7 @!� ��>�N�:υ@è�0fˬ�C���,ۯa>���X"`m+oj�{��٫z^��v�]��5W��UO��\k6��}��Ԩ:�D�͗�4�O����P����  @�\p���qU:�;p�r�	x��� x  ` � ��ߜLm�tt@�F;���w�l�$w��p�D
Th�]��ַ:����Z��옘U|��lؐ<�űE�¬bӊM+a���k�G����:���-��I�;?sԿX���uU�I���e���������t����~�[���  
9 �᳤	$��(��4��c?ޜ|�vg�ޭ]f�}�FI���Go���]�W-�%G/-G/-�݂�nU�YWjj�ۚ�������4��B�c�c�������a���cA�;�||o� � �	�   �W�,����ZQ< ˤ���  @  � xh  ���Ӎڍi�j9H��䏛�c�ֳ�]
(��ˈ
��D��bH���L/4�aH�pʐ�������P�*Xo�ɧV�>�a�[W�g��mL��̛Q<��k�h���~0��?��I��5��O_}y:���������������9�+  ��=i5t'��9��_@l0y���i�����'<q ����k�e^�����e�v׽��*5kJ͒�����?}������ֱtݐ��7
������q p   B �	 ��0�jb5�\M������6���  �  
��\�^D�&����Ē�"���ď��c/��^��m�Pi���H1j�4i�L?i��膱C�Ȑ۱K/��P��_u�>���Y�K���m����U�7cy������1�l}?�{n��:_�:�鼗�?;}��Etet%��� �@`�=������O���2�&�ԯ�߽[UaA�(( ���I�����r�Sy�R/��+/^�^��X���T{Y����'�������qzl�/�x�/~͜�W>����ҩ�5R'݅�W`8�rPd"�[��Y:���-�h_�+����ҩV���٨�A�Y:C��j����
� �?��P��ϡ��w.�,���g����b��yh���S>�X9tۆn��-�U[�l�#��MF��JVyWd��=k�&A�Ū�8�4R{���k�O���4Y�&!d�x�H�pr�^��c�����i�oF~oV��;�����l���6|���?��x1�x���K�s!�Y ��P�:�ۯ���v�c)T"@گ'�<�띝�����D�_N�_N�?��O�J�V��\�\�x�^����U{I�]����'�F�	��Ň_����1}�"=M�A:��c`N"t[R�,f�u5Ў��F�&�4̊VXa��i	�05_W��X	��]h�H�X§ x�k�<v�7�ذ��6_���)�^,�Ρ�ן9Hl1�k�	KJ�ђѠao�f��,:Q��C�n(����ٕ��_���qJ�TBQ�Ã�k��0Ї��zD�
'G�ӭ�<�P}j&}o�O��h��	?[����~?����?^4�ɏO�r*G��K?�� �������m��p	�;K|'�q�����c��(E�(Dq�Q47��������w��)���s��..]߻_�w��_��/���deJ�xa�cXGk?)���æ��^�NZ�_[�]*]*?��|?��f��f�x�����l�K��v��v��=��Ω�9~9�����L<�_	_��/�⭏�c����}�_��C梒����.^Q:W�	��Z�H��t�y��y^�Vѭ�=|���g!<�����������������7���3i핼҆��c���lx�k��c���B-�fyu���4�2N��S�1IӔpay}���h�?�6�s�)����T���1�h�?�_N����g���K�^����v����Ӧo�����`�����U�=�E� U �4�_�~}�o��퇇���F�l�m����7���7�׋���y�_�����_�/��dñpRJ�a/�S�:aX�HQȨݽ6�����S�N�G����MߚQߛU�儗���˷��i��n�O���l��;ڷ}�N{�{��|��<���>n.6ͅ�4\��s��-q��Y�OF��K�s�UcZ�}�l��g�y<�˓W�I��]�~���|{��˻����N4͕o}�<�y��wƂ�&���&х��βu��i��47N���f���o�v�W���4�?�Z��������TW��������-���,�М_>����폯ms��q�͚�9o�M�]O-�=Z�v�E� @�Y���e�I�EBys1���M�}�s�I �ҫ�~u��o7��6�������k����ز�x�j�s��۾�ӾЁ����(�ñ ��.� B�TԚ�Cs�u|�u�������>��C7��{�O��9�1�؛������8w����/��ϖ���)<������s�㦓�����ˇn�\||. !H1��b�����t������j�ƴ�:߿c���竎�Wu�^co�z��z���q��3�zo�>�ޭ����W�~���2M�1;� �����<7���LqZ̗�<����d�?�L�b��mt�m�@Eڔ�
g��3h׫�f����?>=E�;t,~�w���3������� }úf˩�5�v�yP� m�[v���ƫ#��3���-��˫ku-��/�oO�g��u�g��yo��������«����JQ)���1)�8�.� �D�Z��:�ƕ3C?������ݸ�n����ԥ0�cX�7T���
g�ﯾr�<:}�p�,���i�4�?C��ݔ���D|'�{q.��
�B��XZ�(�Xg�<���Q�����a�������~�|�����Nco�z�n�9+]�*��j��l�&��'?\t�kӡ}|�6�T"����,�%�؜℘W|���jBN�-`y��U؛�n��/H�
gNUs����,��ħ��
W8��9��fs~Kr��Y�z0�`��V����K����m��%,̡Y�2��g|������+�g�`����Yͫ�����E���u{7��n�]��l��������v
�&eT�J)% �!eF4�*ۣ�Y���DWGWs����N|�@�$Qi.�y���+};��n���E��3�Q��թ����٨х�#��>�����>��t]�R->����s�@p'�B�o�o@SSm�M\����C�Z2 P�w�~K�/�}��  �* ��o�57Ui&8��եх�ۃ%,3
!��)�!�c�p���x�j�i�P���j��� �iZ2��)Rց��m� "��ƫ;�/6���ۻ�w��ʋw�z�����2*ŴLJ)�_h�Y�v�s]��ts �KN]U	!^�I����h�~�o��O�~߷l~��@E���VD�.it��,�����}��u2M}L�XGW�a\�*DT���z��L�I��ݏ��:��|˩P���^�Ob������0H  �}��7�`�.>6�L�n?���mo��H�C!�!z\�U~��͡�(\���}�3@�i�	��rĈ��<�0`��%zT���
"� �vH�C�(P���Q@ Rf���`�� �jNCjT��z*�1�A�>�>�����"��@�8�|�P�\�B#��F+�>�D���"��.���������_����> ԁFt!K�H� ��

�{C �*@U]��Y �V�	j�-��*���8����Rkj�o�DC � d ( m,�PN���A�\����\`�@@�3# 3b�d�,TAF  C`2(" ��I�4��,��D*���U��ބ�o'8�PD�Р�fjV�& P���T����j�E�x3����:p [�@�>h�4\��!�ʀ� ���xͤ`ֳ��@���I���+9��t�+�$ؑ���h�6�R�(w����&
@ @! оH� A�X����!�#�a��ĳ��_D��(�R5A ��T��8� 9r*T,PC]�.@Aki-T��jC�12df-��8*ȐA-РQ�' pp���KOp��0 ��=��<Z�@AiЀJ4�#�]�e   .�Ca��R*�$q+A�Jtmt-2VL�(hPP5Q�r2 ��C`[�Q|�5�-�E�8xt��!c?�8࠵vo]�\��j5)�Z3({[tD;�@�!c�eok�E��!J"c8���
�'�d�
�[�-l����l���jJ���Y�uԡ.Z��JW*T�uPD�HQ�,�m�ς��
�l���+.��;lP����;jV`�((�� )RqQ\Dw�.Z(@j�@q��D<�!C�G|�6̒sTh�( F���*����svر�XaE�N��;ܱ#��9C��r�@A��,`ag�5\+�������K#�Fd#r����C�n�V>nݏQ���ln%���P�A��au�5km����f��n���v�H�����X��}��8���)�AT���L�t�ĥڥ�\ڹ��
W\�\�DQ�#�\�ꢺ`Y�̌l��D��,� �w�vE��b�ł���2�2�,-K�c�c�N�t���m�}�}s�4�	��{k~�n~� 
B�y����#�Gڷڷ���3s�Ub��K��d)өH��EY�,ٔM�3��P�J���ő������#C�������qG�Lmm�\j�m�P����o@��������z-DVǵ�Z��u��
2{�^[r���q�`6+�-lKX��,ʵI��亴.�R��vc7�i��$dL�hH�k�0������K���c3c3�j���!oDoD�m�m�{��ǝ�v��v�_�,��[�y׳�l���EO��.]�R��Gz��Z�۫�^u��NT�w�ݸ9t+u+�����݄nB��v�������-H�-H�]�?�b�e�.�-8,8\�kuկU�w����9/�W^�W^�=]{��y9��rr�m{�mku=���}Oz�Э����]>�yW��ȼ��E�lq[-n�.7-X�n��N��O{����=���E�bѩ����k~<��|<����˫,�<�5�����沵�J�+�n�?9x$A��Z�9�k �9j�D^��Vh*�F�x��忏	
g�r�H���s���Z���~�Є�DY,��w���� �ʹ� (΀s��J�̤�E&�h�3�1~�i��s�2#����N�)3f�����߸���\+6x4��p+�`J�APf@�U�(�͒b-� ���+M	"�S;���E	�zG5�_S��,D�P�ɬbZ1y���(��w�k����R2u�1����,�F�!��-Q�0IC����j	 �9̖�D�	 ��`l� �k��j�(a(��z0�5�y
��~a$�-i	�zK�7�r�jF^a�#m�P�㿀�C�G���9�o��4��x��:ŊF�!�	=�����_��;��hU������t��]<x8���f�&� a����v"����aVbζ�M�`�ėZC.bC���oMbd���^�ެ�� ���݃�%���ܱ�F��n<�F�G�H~���H��DSr0Z���n�{����~�=5,N7�b�핀Ed��!U<�|h�T��ڨ:�Q���-�H�����P��9F]d��F^��o�O��"@	I�)����PO}�k��%�5����F&9���[�򶖙ȡ ��覌~'��Q���2�٨�k���@Hh��V!��**k^�@}"��pE���	-!��,$ 5��v�с�?t����鷼�{����Z���/�>��߬jc�C��z`�iQU�d�W�]����=�sb����I|sf�t�o��tѾ�'WTG+%���/}���˙8p�Q�>w����k9}�ھ�2�ԥ��܉���#��'��w���	���5�q��Ǘs�o����u{o����~<��ܶ���q�1w~|���Y ���{�ʥ����k"n��?8��"]�����5'w�W�e{��n�����__x�ַ���0�ު<�;�����C�Q~�6�R�rz��pۧ��A ��5�O� ���9ʯ�a�{(�ǜ�U�3�w��=��{,sf�*�yy`��7l��V�/X����WV��C�FٲSۻb�c{�>�Nf>xP��ϰ�ݏ��ߖk���ݦ�T76��9�տ֍ ��_Lb'|����{�h���!2eS�w�����]W䥾8���2��z�ʧ��|r�������p��tei����Ȱs;a��f4���P��lٹO�q\h�eWR��C���� _\��ܳ�gB����Og⡺��I30%�2Q�j���/�Y���3�䏌�RB���X�� �WJ9�)���M��r�'���̮�<%Z��sP���?��r�lk8��4/h��3U{m"A�Nq����'�a\&�_���_M����G k�s��Z�#�ͭO��S�ɗ���(Ss>�:�+���O���1���+��i�X߱VG��י96�TU?���k�䕟��B�dEsĪ3���X�t<�m����&<�ι>�gd�i;��xIW����9oh�KT��nx�����?�x*���r�=c�6���WD�k5[�qҥ�l���ܾ v��UOU����3`~��yq%.0߼��Τ�g3\D�T@f�\V�E�^�w&�@ʘ(|�@���l�3-�_jS�)s:�r���G�D?jNt����$6ں�5�ڔR�,;��/�J�P�z�t4�ơ �&�f���Ǉ�^S��u�v�'<P_��������	���\�$
tzo��ٗ���p�dI׃�Z���A];�E����Tۗ���������3�Nԝ;Q0z��|�{�V<���#���`���o�V��i���"~h��������Q���	�dT5~B"Y�\.�����ZO�=�����|f�ێ��(��O�T-�^Fa�['�}ޟ�}�7�6D:~8�s�Dϗ����Z<�ީ;��}z����S�Tj�P��U��@���X=����f��물�Fd�ǐ�кj��Nk_��1�w/l#uo7~�-(j�^���[���a"����FJ4s������a�4W��܃�+!���X����7�ǞRAG��ͽXg���A����e$b�ȗ���T{�iI<�]���.c���O��[�LG�&eUu|��M��v~�����i7f���U�� �����.x�,c����ʞq�t��ppl5�5��"� ;�������3n��2߶�z��n9�]�$�f�Ċ�-{ǠL�l~H���K\��_y��4Kݟ5;1)2�,R1ȭ�4��8#x�d�A�����X���[���Y{�qL��z��f��?�W7@����ڧ�?/8Wۗd����S��ص�w����Vz`z�QF\�l�ቚ��w�oK��7�a�"���M/p[�֬��y��й��Lƿ�a�^	�N<�i�-%�=j�>�������R�f��p���N��ޏ��c�=�2�u��a�{qVOqqb�3������fY�~�[%I�{� D����8|��щ�����Ɩ���8���V���u	3�|C٢7$z`C�72{u�(?�ʯ+�k7:�'�rx��$�]�����knh��'V�r]�d�}w�Q�V*�9�o�����|��yˋ�r��6���?.��=����+��ߝ���7��e�����^��Uk��F�n&��jd��{gC�ș玖bé��w|�^Z�$Q���|�5r�-<~��Vv4W2g�������X��^����_���}&xW;+pק��6�22�&��귯�߬ZB}:�id��f~�����:$����^9{��/�~�s��_Wpӈ՛��l@���:��_�.:��T9}����]V*sd"��wO���.��%����������'���Wm{�왷�Ord�:u����?�;����*.V���ū�v�0fO�����Zw�TJ·�[���)f@���9丧2�4�#�@�ZY��蘧<��2�����(bn��"�j��'TR��P+j�����fڊi�>���aًN��g1U�ei�����5K�5���%�҂-���
�=��.כy[*Ǧ1`���*塥-v��NN�R"c��w���r!�t&��NXH��z���Ps�bh2պb�*�.�J-���y��<S��C!c�T�l�2ּ0u�L+J��JZ��"�~��
�U]	�~D'����!��Z	�� �$�>J-�h��T������}�jV�T��XOEI��R���u%Ӗr�m*:7��|�@C������#YI!
��P�A��@���#�G"#��-S���FF�4�u�z�,� e���cl9φ�I�
Juy?R'��md��"՚�@��x�l�����5�0]���S�<)���6��P2�R�͎0(F��BP:ex?���<U��US��\���� !��L�Q��!�� x"AFR�z�,8x��.�f��B�&�u3K_�E�SBJ�sQ� Zj9s�o��<�lT�eZxeQ�mӔ�9�*�0�^k)�F��^	b���xυ�7o�pALoe
'AKc3ܬ2��uŠ�)�R"ZTXN��s�8����ă%T�yY��pMH�Fh�M]7S ZC�o��$3ư�yCxʉ��_W�rf�*��ma`���p�@��G��d5�UU��pD%/����\7&�b�'v�(�F�Z��C,+��I��EI��"q�)E��ĺQQa��q�D��K^U���$:K�SkL�+����Med�k��Ji��T��ˈ��Q�(�,��P�b/Ekă���EfTU��"���VB�_W@<�$N�2\�"�̦i���g�b>uШ)Yk�Q�I-��B��<IxJ����T1��4�;Y�)P�i0(�\E�1'��*�P
��v���8gZ3m�+�� ��4(̉O�c�)+��
��kQY-��$�&�G0� �TW�Ա�^�\k
�4��`kΤ���ښ��"u�.�b�a��
,���j])xM�p�Y��i�P��A��)­f�+,s)�ʒH�ZQ�@����9��2��	�Lj	�$`n8�؂�J�����?�O����?�O6�N���^:�n�R2��sG|�{W{�j�UZs,�0{�x�ܣ�и4�*#�^ϝO��'i]�k+�fF	1����@;(p�>���Th!��s��b�r���-�gD1���<b[�,I����0!��s'���p�\��M��b�=wL�g�e
���p���sWo�3z���Z{R�����sWiS|�]B=�>`n�nϝ�������Z;�bx=wRd)VS#�^ϝiR�B��l�5��a�ܑ�(�yR���D�j!��s�A�<�4@H�������?�O����?�O����?�O����?�O����?�O����?�O����?�O����?�O����?�O����?��꿫��?�O���<ޖ[�JǪ@*��ҳ@YM���f�i�hX�~������n���.�u.�e@�������9b�)I#�3�5�.���r�MN��z˘N�غz��P�ْ"�C���m�ִ���m�D8F��o^�g���t��xd8�G�����	�ںb��s�q��aI�3  e�Dz&����w3�3FH��Jϔ��?� ����꿫�������?�O��n[*C�3�
�X��ǹ7*�,�M}���L� ���:R���LK���8�iX�T�	�S�JЏ�#�ݾL��E(�^8` ƾF��Tγ���'�; 8�\f\�S9��-�� 0��gL���^3b�|>1�'D�r��J�;D-\ȽL�
ͤ�;�,�S4}��¬��.���x�&���xĲ��Z3-|�J���R����`ν�����U��ʤn+�����ò6�tA��ͅR�9�2턔>���S�ke�	p�	`T������G�8!8 �{�SH�.��k�c�|��&�S��ƓLk��cF�,�O�Ֆg�Q�����h�r�P�2�׮�����=!�P�E*�Y--k6\�V�V�ɿN�M�ӹqJr/*mH%�עay�������?�O����?�OƑ0DD *��M�$��!F|g�\RM'�����,As��~�)��-��8`�g�Kϸ�1_��q��k��@D��ڵN�˖�8 �j�㷟�������,A�y{8M�t:�m6z��U�2W�}���h��}���5�7;���&K<Ɉ�lS���0����+'�R�Ua����GV�L�]a(,AOV�
��VA�+��C����?�O����?�O����?�O����?�O����?�O����?�O����?�O����?�O����?�O����?�O����?�O����?�O����?�O����?�O����?�O��g� ̷�T�[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://d33acfbioaogm"
path="res://.godot/imported/pong-remake-picture.JPG-1a67fe05efc4a234ac315cee438d72f2.ctex"
metadata={
"vram_texture": false
}
 GST2   �   �      ����               � �        8  RIFF0  WEBPVP8L#  /��,� j�Fjv?�G|$"���X���׾���m��q��7��HrT�?����
�=��$���nv7υ���c 쁙L�n ���'�g,/ Rq�m��s�!"&�-�{�С�=�伿$[��&8S%u63��2��d��i�������)w�0���\ɵ�oI�,I�lټ����{�%L��I�$�Q=�sb���'z��)m�v<�ΏI&*;�J׸mwalke{˽���m�3m��	�m����������mc��Gɖ�I�h��a8�|����ý��{`fޝ�L�)��(�O����F��3�ڶ-{����ׯ_f����<Kݗ�S�Yf�27K���I�T۶mK-�ff���Ln)r��p����m#Iܽ�[�oL i��w�	$m|�Ο¶m��nw�
�6`�y� p�� �� ��]��x��3ӛ�K��(��n��Ib�!�1$��l5Yc������?�~�68�y ��u \��@��=�ȥ��� P����Ξ��T:�Pt
���@2
O�U���u�o������M0J �+D�C/��������
w�^�ʾf�ˮE�L��B"�AuPuZ��m�e����q������nV�IP��w��?_"ӟ#��gH.�5m�}�԰2LMj2%��:�Y���>|�������5!��[�>���2{o�K%����uշ��Vg*�C�+ 	�0C�������WB/D)˷ H����|�}���97�"(A 5  ��a��  2��[�e  &��Nu�ͮ��y\�����|/ɳ��`d�='�]�C��.���0� ��ĭ�[UQV���ѭ�?/w��C��LO���,=W�k]5z�R�Dlx�l9!!BT� N�b�.S=Lޥn� Q��w<�~�/�v��_/�����w���L�p�wW�z�Q��jDyQZN�� D��H�V��lT���FĝA6��Ŝ����_���z�� ;|w���򮓿��:��\#���|@�dDѨ[��/�!ӭ��-���:�� ������w��L?
#�F}� c�.�	��|�3�~����T ��]{m	�V*��v}��|!�Q�R��Y��o���[��!��z^�q�ky�-g@�d�o�  �4�l��c`}	֗�A'�Ʊ�(-�ٓo�� ���ۧ�����՛��7=k��  �rdPNxK  �|w���d��N_��K!b�l�B�=W�#"��r[Y�S�YB�(V+�0"�#�� ��vd�~,��Ū��(
CdQn� �2ر$�p��(.yD�Z6"hAuX�&Y�:��
%��PKh�� �G�����$	1@&e�$P�%a�n�"1�BܻٹDл<B�� G��`+5j,�s�s���fJR��,�J3�<X���Z�ZPhC�5&�/�	*�|���|<|�H\5g%&�R�ƴ4@\!!aEv�D���X	�Q���<Y0Mc�k?)�՜��ilbF��^��t-����d���kD���Ԣ� ؤBk��Oy֘\L�9��,�y��U�T���B���:�TKA�HU��c�b�*O���u�>��*P+jߦIcV�<c�g��vg}��%���;�5p1�2m�cݭ��h�RL�v�5�
$�F���1��V���+�&��V؝]�VБ�\����^��W���_"�Q�K�69;]ݯ���ժ%ji�r����K�{�l�j�;���V:��-ӹ��`���˽v&�[���H��VЁ�H�Q�����,`c0eͦԖ�!�Z��R��6��1�������g`0��`my�� �
FE-l����
K:.���J��0MAa�1d��*h�u*��dJ�Q��JFY2�*�l�ʴ`Pq
T��a�b���%.�E$i��5(K5mN7X�T�j��l\6��Mڴ&�c-K^�Z��g]��$�Tf�Q���U��QB��N�*,�.�A�k���VE �?CI�-��.QrѕmU��k��:Z׳y��;�R� ��s�ƴ;u%�\Mv��������h�le/`�����X�_�v�Q����X��$!9��ќ��6��g���6���v�F�2�sw�2?�6� )���
m?'��Bl �Դ����GH���ƌ5aԦe��.����Ya$@X�S=B�X��jq��0mӯ}=�
g�@ӭ�V<�@~B)�W���ٵ������c�V[`�82��U��Q�ԅ{�Z��q��wˣ1( �*.>O�%m�^�}o��T�d�9w�5���Җ����ѱa��/9��V�\�M�QE0�G�ڸ\�#�h�39�����Y �2^�X�-�8$	���F�d�ҝ->A��q��UY�T�-��D4$q�v޲9eB��5�o������er��]A:P`F�ƙ�U��� *28�*���C�f�A���H����QrT��Ӣ� ��	����f���J���f�o�����nT�\����fP�\�+WC;m=L.��u�i_�n���,�;���WL���O�h2`j�n/�f���F��t�Y$��֫(�\�QЕ��rP��l�݃��:�ul�(M;��A�9��v��1;����|Z{mR������dy���>�]B;��U��[�^��o�	+ӗ0���o�(�Q=^�m�d켢��7���8������v�b���w��wq|�5���^|.�]x���H��pޙ��sKw�l�ʥ�#��׼Wp$7z.�kt���[x@�A].5�������<��c��n�w����������.̜��m���m<��䪗����RNv���n?��~�뮽��U��~Z�I[�կ*�Cl�E����Ytgx�ǟv�#�x��^��ȕgu�Լ�"��,?n�EϽٵW:���.]->l�����<�;`+0����u�?m뷯��B�/�<��_i��y��3u��X��_x��k�TO�v��/���W�^�����0@�@t煯˿�����s��o�i|3&0�  ����KϽ�8��Ҹ��׮��~ ��8�S�g�&r��kߍ?i�7/�ġ�iW���#b ��nw�F�&r���?��UO���}R��.Gp������^b����q�z�Eg~W�Mv؞@J�,�����z{�Rޕ�m�h�q�S X�����=>� 4�{��[�#����H��X���U�1�-��ړ-<���>�n����<{��gP}��/|��Y����z�����  �{�Sݦ��Zg���Iߟ����X{����-=t������DkϾ�'���}߿�1��I���Ѽ]�I���Ryzy7�V=y���ݿ�;��x����b.k\-85�������R/}��_��_��_���<�����W�G�{zCo� 2�6���ԋ3 ĥ�˫�̿_�U�k\�R�0�#ު>���z����/�Q����\��՗�x~�G��k�o��m<������ŷk�/8bۅܬ���E�s��>� t;yR�O.߂�{�n��\w�����׾?�\�e�^_�2R P�ߵWU��K���XƼ1� ̋��u�> U��|��
 ����|��/�c̛���\��LC]�ķ��ʇǗ�Cλ0?���)�_M��_���.�#�����"5:�{��V��"�Ⱥ	��p$p03�)v<z����t�Q�T�%���pfJ# A���r�,���� ����$�Rq3s�]vzvV�]f��%	��HM�������ч0H��H��2�M�=;s^�z�̊I�T�;|S��
�X��nv~��1�:-1s�Y��Px��K��٩�N��&�i-Pf��q�5�8�t����^�sV1nFK��d��5�9y`��O����U������2<;m'5���7��`K����\�w�>��1���3�F��u�vw�6���^������=f�C����_����;�}�Ƴs��;�<��������݋�`����W��J���xzp�pg�o�|����ac������'�壯:~�.3����?{��������/��c��q)�޳G1;s�ۿp?�����ߣf�?���|��l|��z��>�o8r�PV�ێ��;�}w����ׯ��M�{���E����_�|�'��ſ�s�G��n~~�G��������:�{�������|'/:,�gޝ֗v��o׿��5W==>{��\��
����{�P�������n�^{�����N0K�3�������7���}�������L�C����xT�C�����?����>�/�|��o��4ߡ`����>:_�����|��_;]W31�h����ݿ����o�?������/��>_U�J|�l0��\l�(���\ۧ&�z����Ɨ���}�t��N�=6����ӻ��v� ��|ܖw'��Q�40�Τ�wǹ�zd�.q�aT�)�Q�uI,�u�V������_�d\�ϊ���3ۯ[����N�ٺ��5)b�r�̎����j�HL�:X�*���U�C�#y�	�VAmNW���H#��U\#�����y�E��罳�JЕ�e���q�S�Jу>��)e���ǻK�4���)�*e<h�L�ТUT��F\C2�$�lt�Ė��h�[{oŭ�$ǥ:�"�	�E���L���g<O[�?\EW���h�r
F�AW��7��7�`|	[g������Kc��R�ti�ef�4j;33F.�.^��w�״o�����K������������b�����V[[�L���)�y�u,t�utP����L�\ɒx�xL���_|(�q�:^�0\0\�`�<=����(a"�����CG�Y��x����E�E�""̔P����G�92tF��V���`�Ƞқ��z�Ar���ng֐(&&V�%=���e�.|r+.�OV�hG� .>-#�Lo-��+ۮ9U$��������H���݊�ŸXgg�Z�vqT�L��02���{w���ן�ڹ��k}��Wd1���	A�F&Z��sn��FJ��m�,�� Ӟ�pqr���pðR]�h�d�:����o�2Y߽�����5��(V|���<R�b+Q��ސ���.1H	Q��j[+�
T)Uҭm}�ƕEYt���ΆS�"��>O;�g��ά�J�Wv��>�.�ʺ�����-p1XG�#$���1V���$���*%&�6����!�3�g{g���&-U
%-�\�����u`�#��4uWj;@�
]U�p�Ju�D�Im,��"�v��=����`�Y��F�\�$ؗ
uA	��ٯ��jy8Q�*�4+1�� ����H���Cn!S"S*.�@�Ѳ$�)%�p9�үDu�8`x�Pl%ד� ������n2W؍ݰs�,*N �vâH�ˇut W竳w�Ϊ�+@����u��u ���U2sq��<��JSp �!
`$���Ep�,�@�(�f.���>��,
�!4墺��n˞:���dF�������_iS��:�����C�ʃ�uq�bT�($�<��}�❘��]}��Ӂ)
�H]������/���V�
1�uF�)+�Ŕ);LL�4��DM��*��f�]m Zͮ��X�1���1��c0����<V�����خ��,Yx_t%{��??�R���`W ,�#UJ��Ju�4��*�51t�+H�h�0�����&�;!��4ܨ����\%?���UY�� �	����_�����80J�p����0sr�;�@�6�8s'sn�I����]��HБ�`	)�(�n�i�'$��Q�eO��}ZI�վ����������ϻz�b���T���������-}[�ǩ�H�#��g�ӷ��|�����m���>-��ƐIB7��?V~�������=~�c���<	٢k3���е'%�!��P��;����/����o���k����=����i�d��č�����-�A�e���'�I�qk��@�[�2#iBv��+�4�ꉫ���yz�D�&�z��8��v┸\�'=�����,U!���l�n��^�n>u����&uS|S|s�Ɠ��/�ߜ�^t��7_�2w��D����Q��F	H����{JVtCכ��Τkd���?4���] 7�}��W~����g'���ͬg�fo��zϖf4�< �6ܪ� Ӹ��}��Jt2���G�l���F
"̪x��	�����@��ye��%R���_S%
A�pT�@~"lI��Ƨ �8�@��am���ϗk�4 _��ֱ��E-�lօ���[�UF���f��䖕��jer�%[�U��Hr��p͖ad4��j�Y�:��"��q�B 9%H�:�YZ9c	s��L���@~C�W��U�!$� �+`Q�jT�6����������9�\9@ș�`ݝ���&��&� u��l��)��_����p
�WU��#$H���keJ�B��h<o0�Lg
�UT�U̓�)���pY/f�\�r�Ҋ�2d8o�(^ j,Z,��+�$?�]V#���E6a�h6!����`6T¼H	D�.�q��PQh#"��  �\.V.�\���M��e2����tԈM�L
�(3�X�H$Qb�b�FC!�Т�  sece�q���e�(��,V�ؙ�+�eW���A� �   :bD`��f �����`����M`�@ҋA ������
|� �	�����J��J~_6: ��)��E��R�N |c�UT"�*�T������Ng����aD�;�@��Mgu��T� �Fc7��#��ۈ�nd����rA� �(b���,��f1��Տ���Ѡ��1�A�b�Fa�*�t�utC�6-׵S��#�aby�ۛ�c��r��� ���]5X�
�f��?���皰�������P�j�RD�?�ɿ����;`��w]�<��Eը�c��*��pq�w>q7 ����ϷF�KY��\��7�9��  �V��)����.��[��3�z2ዱ�3@�VP �96vU  �6y�o�7� ���������.]
ߨ�|������m8�  ������7�'a5�\N ���W~}��{fҸ�AQ��v�V ��wt��j�pG���rw>>��y��:��@������~�N��h`*o�p�ҁ�ɈnP)T���8� 1���y�9xi�+G׿�:܀�s�!4�t���¦	Y%0a+��F�JD.��AP�hUۭ[�� 8h����'�}λ���/F�_  �=��ʟ����K��^�lH��}��* ��z-h#[ͳ��������Z���0j P>�N�zr�7���5[���|	m!{E6��W��k�%�ZR ƿ�o^� 
�gZ/?�q��\3|洰4! �,m ��������g랿M�w@�F�s�`����� ��,�l|it��)u�tS�$K��;d�{�o��م���X��W���~ng��3 �o���s������͍μϵ�K[�l�u��JM!��\l�E��G����Z���^}������}�/���\�ͽ�= t���[�N��������[9~�>v��J�N�.e(���b�x�B��f�����Ù��g���Kk�j��} ܀���x��   [remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://c1kwi8w8le6jp"
path="res://.godot/imported/Pong-remake.apple-touch-icon.png-d4b4b09d5b1ccbcf38450643d3bbc392.ctex"
metadata={
"vram_texture": false
}
 ���Qk2bGST2   �   �      ����               � �        &  RIFF  WEBPVP8L  /������!"2�H�l�m�l�H�Q/H^��޷������d��g�(9�$E�Z��ߓ���'3���ض�U�j��$�՜ʝI۶c��3� [���5v�ɶ�=�Ԯ�m���mG�����j�m�m�_�XV����r*snZ'eS�����]n�w�Z:G9�>B�m�It��R#�^�6��($Ɓm+q�h��6�4mb�h3O���$E�s����A*DV�:#�)��)�X/�x�>@\�0|�q��m֋�d�0ψ�t�!&����P2Z�z��QF+9ʿ�d0��VɬF�F� ���A�����j4BUHp�AI�r��ِ���27ݵ<�=g��9�1�e"e�{�(�(m�`Ec\]�%��nkFC��d���7<�
V�Lĩ>���Qo�<`�M�$x���jD�BfY3�37�W��%�ݠ�5�Au����WpeU+.v�mj��%' ��ħp�6S�� q��M�׌F�n��w�$$�VI��o�l��m)��Du!SZ��V@9ד]��b=�P3�D��bSU�9�B���zQmY�M~�M<��Er�8��F)�?@`�:7�=��1I]�������3�٭!'��Jn�GS���0&��;�bE�
�
5[I��=i�/��%�̘@�YYL���J�kKvX���S���	�ڊW_�溶�R���S��I��`��?֩�Z�T^]1��VsU#f���i��1�Ivh!9+�VZ�Mr�טP�~|"/���IK
g`��MK�����|CҴ�ZQs���fvƄ0e�NN�F-���FNG)��W�2�JN	��������ܕ����2
�~�y#cB���1�YϮ�h�9����m������v��`g����]1�)�F�^^]Rץ�f��Tk� s�SP�7L�_Y�x�ŤiC�X]��r�>e:	{Sm�ĒT��ubN����k�Yb�;��Eߝ�m�Us�q��1�(\�����Ӈ�b(�7�"�Yme�WY!-)�L���L�6ie��@�Z3D\?��\W�c"e���4��AǘH���L�`L�M��G$𩫅�W���FY�gL$NI�'������I]�r��ܜ��`W<ߛe6ߛ�I>v���W�!a��������M3���IV��]�yhBҴFlr�!8Մ�^Ҷ�㒸5����I#�I�ڦ���P2R���(�r�a߰z����G~����w�=C�2������C��{�hWl%��и���O������;0*��`��U��R��vw�� (7�T#�Ƨ�o7�
�xk͍\dq3a��	x p�ȥ�3>Wc�� �	��7�kI��9F}�ID
�B���
��v<�vjQ�:a�J�5L&�F�{l��Rh����I��F�鳁P�Nc�w:17��f}u}�Κu@��`� @�������8@`�
�1 ��j#`[�)�8`���vh�p� P���׷�>����"@<�����sv� ����"�Q@,�A��P8��dp{�B��r��X��3��n$�^ ��������^B9��n����0T�m�2�ka9!�2!���]
?p ZA$\S��~B�O ��;��-|��
{�V��:���o��D��D0\R��k����8��!�I�-���-<��/<JhN��W�1���(�#2:E(*�H���{��>��&!��$| �~�+\#��8�> �H??�	E#��VY���t7���> 6�"�&ZJ��p�C_j����	P:�~�G0 �J��$�M���@�Q��Yz��i��~q�1?�c��Bߝϟ�n�*������8j������p���ox���"w���r�yvz U\F8��<E��xz�i���qi����ȴ�ݷ-r`\�6����Y��q^�Lx�9���#���m����-F�F.-�a�;6��lE�Q��)�P�x�:-�_E�4~v��Z�����䷳�:�n��,㛵��m�=wz�Ξ;2-��[k~v��Ӹ_G�%*�i� ����{�%;����m��g�ez.3���{�����Kv���s �fZ!:� 4W��޵D��U��
(t}�]5�ݫ߉�~|z��أ�#%���ѝ܏x�D4�4^_�1�g���<��!����t�oV�lm�s(EK͕��K�����n���Ӌ���&�̝M�&rs�0��q��Z��GUo�]'G�X�E����;����=Ɲ�f��_0�ߝfw�!E����A[;���ڕ�^�W"���s5֚?�=�+9@��j������b���VZ^�ltp��f+����Z�6��j�`�L��Za�I��N�0W���Z����:g��WWjs�#�Y��"�k5m�_���sh\���F%p䬵�6������\h2lNs�V��#�t�� }�K���Kvzs�>9>�l�+�>��^�n����~Ěg���e~%�w6ɓ������y��h�DC���b�KG-�d��__'0�{�7����&��yFD�2j~�����ټ�_��0�#��y�9��P�?���������f�fj6͙��r�V�K�{[ͮ�;4)O/��az{�<><__����G����[�0���v��G?e��������:���١I���z�M�Wۋ�x���������u�/��]1=��s��E&�q�l�-P3�{�vI�}��f��}�~��r�r�k�8�{���υ����O�֌ӹ�/�>�}�t	��|���Úq&���ݟW����ᓟwk�9���c̊l��Ui�̸z��f��i���_�j�S-|��w�J�<LծT��-9�����I�®�6 *3��y�[�.Ԗ�K��J���<�ݿ��-t�J���E�63���1R��}Ғbꨝט�l?�#���ӴQ��.�S���U
v�&�3�&O���0�9-�O�kK��V_gn��k��U_k˂�4�9�v�I�:;�w&��Q�ҍ�
��fG��B��-����ÇpNk�sZM�s���*��g8��-���V`b����H���
3cU'0hR
�w�XŁ�K݊�MV]�} o�w�tJJ���$꜁x$��l$>�F�EF�޺�G�j�#�G�t�bjj�F�б��q:�`O�4�y�8`Av<�x`��&I[��'A�˚�5��KAn��jx ��=Kn@��t����)�9��=�ݷ�tI��d\�M�j�B�${��G����VX�V6��f�#��V�wk ��W�8�	����lCDZ���ϖ@���X��x�W�Utq�ii�D($�X��Z'8Ay@�s�<�x͡�PU"rB�Q�_�Q6  ��[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://dmlvh55esl1fb"
path="res://.godot/imported/Pong-remake.icon.png-5fbdedbd0a8d4ac33f27bdea71669861.ctex"
metadata={
"vram_texture": false
}
 �GST2      X     ����                X       �,  RIFF�,  WEBPVP8L�,  /Õ�mۆq�����1�Ve���G�N^6۶�'�����L �	���������'�G�n$�V����p����̿���H�9��L߃�E۶c��ۘhd�1�Nc��6���I܁���[�(�#�m�9��'�mۦL���f�����~�=��!i�f��&�"�	Y���,�A����z����I�mmN����#%)Ȩ��b��P
��l"��m'���U�,���FQ�S�m�$�pD��жm�m۶m#�0�F�m�6����$I�3���s�������oI�,I�l���Cn����Bm&�*&sӹEP���|[=Ij[�m۝m��m���l۶m��g{gK�jm���$�vۦ�W=n�  q��I$Ij�	�J�x����U��޽�� I�i[up�m۶m۶m۶m۶m�ټ�47�$)Ι�j�E�|�C?����/�����/�����/�����/�����/�����/�����/�����̸k*�u����j_R�.�ΗԳ�K+�%�=�A�V0#��������3��[ނs$�r�H�9xޱ�	T�:T��iiW��V�`������h@`��w�L�"\�����@|�
a2�T� ��8b����~�z��'`	$� KśϾ�OS��	���;$�^�L����α��b�R鷺�EI%��9  �7� ,0 @Nk�p�Uu��R�����Ω��5p7�T�'`/p����N�گ�
�F%V�9;!�9�)�9��D�h�zo���N`/<T�����֡cv��t�EIL���t  �qw�AX�q �a�VKq���JS��ֱ؁�0F�A�
�L��2�ѾK�I%�}\ �	�*�	1���i.'���e.�c�W��^�?�Hg���Tm�%�o�
oO-  x"6�& `��R^���WU��N��" �?���kG�-$#���B��#���ˋ�銀�z֊�˧(J�'��c  ��� vNmŅZX���OV�5X R�B%an	8b!		e���6�j��k0C�k�*-|�Z  ��I� \���v  ��Qi�+PG�F������E%����o&Ӎ��z���k��;	Uq�E>Yt�����D��z��Q����tɖA�kӥ���|���1:�
v�T��u/Z�����t)�e����[K㡯{1<�;[��xK���f�%���L�"�i�����S'��󔀛�D|<�� ��u�={�����L-ob{��be�s�V�]���"m!��*��,:ifc$T����u@8 	!B}� ���u�J�_  ��!B!�-� _�Y ��	��@�����NV]�̀����I��,|����`)0��p+$cAO�e5�sl������j�l0 vB�X��[a��,�r��ς���Z�,| % ȹ���?;9���N�29@%x�.
k�(B��Y��_  `fB{4��V�_?ZQ��@Z�_?�	,��� � ��2�gH8C9��@���;[�L�kY�W�
*B@� 8f=:;]*LQ��D
��T�f=�` T����t���ʕ�￀�p�f�m@��*.>��OU�rk1e�����5{�w��V!���I[����X3�Ip�~�����rE6�nq�ft��b��f_���J�����XY�+��JI�vo9��x3�x�d�R]�l�\�N��˂��d�'jj<����ne������8��$����p'��X�v����K���~ � �q�V������u/�&PQR�m����=��_�EQ�3���#����K���r  ��J	��qe��@5՗�/# l:�N�r0u���>��ׁd��ie2� ���G'& �`5���s����'����[%9���ۓ�Хމ�\15�ƀ�9C#A#8%��=%�Z%y��Bmy�#�$4�)dA�+��S��N}��Y�%�Q�a�W��?��$�3x $��6��pE<Z�Dq��8���p��$H�< �֡�h�cާ���u�  �"Hj$����E%�@z�@w+$�	��cQ��
1�)��������R9T��v�-  xG�1�?����PO�}Eq�i�p�iJ@Q�=@�ݹ:t�o��{�d`5�����/W^�m��g���B~ h�  ����l  נ�6rߙ�����^�?r���   ���⤖��  �!��#�3\?��/  �ݝRG��\�9;6���}P6������K>��V̒=l��n)��p	 ����0n䯂���}   ���S*	 ��t%ͤ+@�����T�~��s����oL)�J� 0>��W�-  �*N�%x=�8ikfV^���3�,�=�,}�<Z��T�+'��\�;x�Y���=���`}�y�>0����/'ـ�!z9�pQ��v/ֶ�Ǜ����㗬��9r���}��D���ל���	{�y����0&�Q����W��y ����l��.�LVZ��C���*W��v����r���cGk�
^�Ja%k��S���D"j���2���RW/������ض1 ����
.bVW&�gr��U\�+���!���m ;+۞�&�6]�4R�/��Y�L�Ά`"�sl,Y/��x��|&Dv�_
Q*� V�NWYu�%��-�&D�(&��"  Wc��ZS���(�x� ,�!����!�L�AM�E�]}X�!��wB�o��-  �-���16���i���ю�z��� ���B��oB�0������v]���ȓ�����3�� +S�χ�=Q_�����˨�d��|)D>��k ��uȣ���Y[9̂�����! ^�!��r���j0Y+i��΍e(�ț� ���x��
��{��<6 R���پ�b��Y
C����+���������;���a ���,�o��bC�{�?���1 �(��¤ �V�������;�=��I��� ���EI���Z��)D����t=S ��] X��9K�= �.~�K[��Ŋ��,2��� p}>w<n�g h�
�t���R�u�G�1k���!��x���������� �L���|>D�0�Ǣ(Qc�� ����= �ۊ�Z0�^��c �
|�����L�%�d��q���(�WB� ��(	���� �J��8D�0�~$�Dsy�Ѿ!������j�^ ��mOa�8.�qce��s|%Dq~,X�u�������=T	���Q�M�ȣm�Y�%Y+�[�0|"DΞ�j�u�L6�(Qe��qw�V�э���ǂ���!j�K � �:�wQ�dÛ������R�
��C���X�u�`����\"j讀Dq21� �F>B[��[������]@K-���C�e�q�tWP�:W�۞X�z��,��t�p���P��Se����T���{dG��
KA���w�t3t��[ܘ�4^>�5ŉ�^�n�Eq�U��Ӎ��α�v�O6C�
�F%�+8eů��M����hk��w�欹񔈓����C��y訫���J�Is�����Po|��{�Ѿ)+~�W��N,�ů��޽���O��J�_�w��N8����x�?�=X��t�R�BM�8���VSyI5=ݫ�	-�� �ֶ��oV�����G������3��D��aEI��ZI5�݋����t��b��j��G����U���΃�C�������ق�в����b���}s����xkn��`5�����>��M�Ev�-�͇\��|�=� '�<ތ�Ǜ���<O�LM�n.f>Z�,~��>��㷾�����x8���<x�����h}��#g�ж��������d�1xwp�yJO�v�	TV����گ�.�=��N����oK_={?-����@/�~�,��m ��9r.�6K_=�7#�SS����Ao�"�,TW+I��gt���F�;S���QW/�|�$�q#��W�Ƞ(�)H�W�}u�Ry�#���᎞�ͦ�˜QQ�R_��J}�O���w�����F[zjl�dn�`$� =�+cy��x3������U�d�d����v��,&FA&'kF�Y22�1z�W!�����1H�Y0&Ӎ W&^�O�NW�����U����-�|��|&HW������"�q����� ��#�R�$����?�~���� �z'F��I���w�'&����se���l�̂L�����-�P���s��fH�`�M��#H[�`,,s]��T����*Jqã��ł�� )-|yč��G�^J5]���e�hk�l;4�O��� ���[�������.��������������xm�p�w�չ�Y��(s�a�9[0Z�f&^��&�ks�w�s�_F^���2΂d��RU� �s��O0_\읅�,���2t�f�~�'t�p{$`6���WĽU.D"j�=�d��}��}���S["NB�_MxQCA[����\	�6}7Y����K���K6���{���Z۔s�2 �L�b�3��T��ݹ����&'ks����ܓ�ЛϾ�}f��,�Dq&������s��ϼ��{������&'k�����Qw窭�_i�+x�6ڥ��f�{j)���ퟎƍ3ou�R�Y����徙�k����X�Z
m.Y+=Z��m3�L47�j�3o�=�!J
5s���(��A ��t)���N�]68�u< Ƞ��_�im>d ��z(���(��⤶�� �&�ۥ� ��  Vc�8�'��qo9 �t��i�ρdn��Of���O�RQP���h'������P֡���n ���č����k�K@�>����pH>z)-|��B��j���!j:�+������˧��t�������1����.`v�M�k�q#�$���N:�����-M5a10y����(�T��� X5 \�:� ?+�7#�?�*Y+-,s� ~�|\)뀀ap �drn�g��RN�X�er ��@ĕ���;��z��8ɱ�����	�- �
�bKc����kt�U]�䎚���hgu���|�_J{ �`p��o�p�T�U��p���/���Hϑ�H�$X ܬm3���ŉ�U'��뻩t��G9�}�)O������p�΃g���JO���\9�׫�����ڳ�!k����/��9R���^�%��C����T���;ji<�>�KY����;�J��ƶm .P��pT��
@HA��r��98V���b�v���YwaZ>�$oւ?-փ��ʹ|0�.��3���b駁�c��;?8E;���V�B�؀����|%\\s��%����e{o��Z�i�������^���s�Jx������B jh�\ �h�<��V��sh@:���.�ІYl��˂�`3hE.,P�2^����J��+�����p��
�ЊJd��x�*�@�7R��� �"�G="!�� �p����u�o��wV�m�g���~F��?����/�����}~����sо7� ���\,,k�J�T�6������Z�y�rBZ[D�>v�HQ�R��mq�������DD�-6+�V`���J�E�����\� 9!ߑ�`��6���ml�~ZM�Z�ȎV���g���������3?*u3���ctW����YQa�Cb�P�,B5�p0�m�cͺEt�{,��>s9f�^��`OG��]����2�Fk�9_�G�vd��	��)��=�1^Ų�Wl3{�����1��H)�e������9�هZ�]}�b���)b�C��es}�cVi~x���e
Z�)܃��39������C�(�+R����!�j����F�n���<?�p��l�8a�4xOb��������c�8&�UA�|	/l�8�8���3t�6�͏���v���� ����סy�wU��`� =��|M�Y?�'�A��&�@*�c~!�/{��),�>�=xr"	�qlF:��L&���=<5t�h.�#ᣭ���O�z�!�&`A�F�yK=�c<\GZ�� 4HG�0i�F녠uB"���<��c�Jeۈ�3!����O��q萞PiZ&�$M[���(G��e���ؤ���ã��O���5����'�gH~�����=��g�F|8�+�X�4�u���G�2����'��.��5[�OlB��$f4���`��mS�L�,y�t&V�#P�3{ ��763�7N���"��P��I�X��BgV�n�a:$:�FZ���'�7����f������z!�����KA�G��D#������ˑ`ڶs���&� ݱ��4�j��n�� ݷ�~s��F�pD�LE�q+wX;t,�i�y��Y��A�۩`p�m#�x�kS�c��@bVL��w?��C�.|n{.gBP�Tr��v1�T�;"��v����XSS��(4�Ύ�-T�� (C�*>�-
�8��&�;��f;�[Փ���`,�Y�#{�lQ�!��Q��ّ�t9����b��5�#%<0)-%	��yhKx2+���V��Z� �j�˱RQF_�8M���{N]���8�m��ps���L���'��y�Ҍ}��$A`��i��O�r1p0�%��茮�:;�e���K A��qObQI,F�؟�o��A�\�V�����p�g"F���zy�0���9"� �8X�o�v����ߕڄ��E �5�3�J�ص�Ou�SbVis�I���ص�Z���ڒ�X��r�(��w��l��r"�`]�\�B���Ija:�O\���/�*]�þR������|���ʑ@�����W�8f�lA���Xl��촻�K<�dq1+x�*U�;�'�Vnl`"_L�3�B����u�����M���'�!-�<;S�F�܊�bSgq� ���Xt�肦�a��RZ�Y_ި��ZRSGA��-:8����yw_}XW�Z���-k�g.U��|�7P�
&���$˳��+��~?7�k�bQ���g������~�Z�e����H�-p�7S�� 
�w"XK�`K%?�`Tr|p���"��\�a�?�٧ ��'u�cv�&��<LM�Ud��T���Ak��������'+7��XR`��[\�-0���e�AiW]�Dk���$u���0[?�-���L����X�ĚSK-�.%�9=j�3t^���(c�yM-��/�ao����\%�?�б �~���b][
tٵ�<qF�)�
�J�'QZY�����*pB�I4�޸�,������.Т�1���/
t�1-1������E�*��Cl/Ю©f�<,0�S�bf�^���[8Z$��@���kw�M<?�[`��)3)1� �U����:��/pR��XV`XE,/0���d���1>ѫ��i�z��*o�}&R{���$f�JV=5͉Ύ��Rl�/�N4.�U~Cm�N~��HPRS�?G��g�-���qvT{�G _�[ua�;���kco�9�Kw����n����E{d�j��C���,q����Y���cwY<$#�ؤ�m+�LL-�z� �y<{/7���[��X�?�-6(cO ?�XZ�M�������sb�[
�.����j|;d�!0lCIqZ�z�&��~�|7�A���A~��á@�� 417��}t ��,� X�6��lS)6v�G
��I:�).~��8R���#'��߶;9�'���U�$1nC�L��찦3�+b黙u�NJ�����8���X�?5�0��^��[B/+�0�Ur(��J��+Xr�H�����HZm&�#�p	�Y ����*���hM]��m���b�ݢ����G����s��z-�x��������� �J�"���Ћ�g�Ҝ �Aа��?��?6��c�Zx�$�t��{s
-R�E�24�?�{�l�-��1�3S�EJ��v6X]L�B^ ��]N��R�yN��62�����'R�p-�����n2�d�?Th|�h��3X������Rc8&��_,��;T�8�� �hΗv�(7I;�3Obn;��O�!����Lߍ*�E~wU,���n�MN1���Z��Y̖��tY;5�^�<Z�Ǩ�T#�bt�xfA�n�cq����"9GD*�^JL��HJ���4���V�-�܉��4*��u]�[
���,"ҏ�i!�r~L��_�����8 ]j�?x���<k+%w��Bk��=�u�ڤ��>%2Bۃ�Y�n<jBo������Κ�0M~�t>�#b/jZ�}���B��Q��#���6R$v�����k�R$c/:�~���(V�7;)��ߊ[̣0?F��;.�*ݪd������{A`w>~�i=D�c��������Y2�X�q~�r2��8@v=f�?��X��S�"X�j?��@$?�����x�(�k���c7��\�����>A�=fpM?9d?�׻{���)f�.⪝���3�������f,N;"��,N���X��*�"V���"��C��?���(2=���A��1�Ul���h�8Ao(5X�B�X�>S�j��s�!
l����GgGp��>�v;c���V�N1���-��K�S�=6PiN�fNq������,
�3SWx�ei����f'�*�r�rʹ̙�e�7���b�o���>_i��M�_��V�p�r�9��X�$�����B���t5�4#�B(E���3�������`����I�M�e��b6_����{~�f/��@��B��Y����E�4��޲�d�O�$���M�����ݖv�P����TR�oj~��+}��#���"�]1Υ_���nR���œ����^pQ2�7첾b��3�ba�\��uu2�~O�G�����5�^>v������m��?���mC;$eT��C񎋋��V��8�:��
���ʱlt��~e]�cC7dl���.�i����\w����/..F�Q5���œ��`�o���E����E�͛�ٽ-�o�z�"n��/��[�����ͳI���S��Dڢ��V�6��!��esq��AC���ڻ���OMk�y��{7`c0�ٺ���5C5�yiw��`ps�OC��f�X�5oQ�\_*m�f�)稹"���a2$O;�]C�A�;V.���c��iޢ�R5�X��t%�s����ȸ�; 5�����)��X|?����9&��wĽjdn�{��7��/����q]3Ɲ�}�[��yF~�Q0����x��U�� ���˘?����a�;���/yޫ�����6.��C}���&L��9�_�ս�w�o���W�^�;�^u�xoݖ��Q8����4��kW��'����:9>����Xp5H��ONtL��=��_�&�0��H"Q��|H���4!���]�'�!޹Eܢ���}=soϢ~	K�$���`"!]j�+{'e�M��D]��=�>c��xS��Y����X��7�7+�Me̯/���u�Q����i���Eg�9�g�RU��#'��ޑW\r�aS�/3�"/v
IgX���}ٻ���ʏr�r���_��<�6�Gʋ&���z%�Pl^d����㑭v�ʎو�w�[���Q��k�K�����IWˈ��`/�Y�X��9J"��_��V{��je�i��6�<�ZS��� �t���W�Bg��@5���..��X�eʡ��*�HRgkD^>�y裝"�9�+wQ4ABR������^�k3�>2�����x�C�l���f:��#gщ�s� ��ߜ��ȁ���+���A��˾�g�1K9Cܹ��:���T"!I������Hs�;���ue��9@#ChE5&!��'�2�����w*a/Q��I	�E������I�w�����?��v })B��GQ�n�h"]0��]Z֑���.}�&~x2��
eĞsF�n�+�b�e�i����0Ix�y��Aѕ���
[1�B�R$$����:�4E疳��#�4���y���ӈ�6o1O�V'��7]�H�.)/)�OwW./�g�l��£���"$d���}[���t���U~�MQԲ�$��~��c��S�M�a���ш=��diH��(N�+U�D����f"V�"�����.ƈ�#Ͼ�eH:�x��d!k 6�J�f9�GW�4����Kp��T��3��~��G�؀��,�zZ��澰؋7����v#� &�r+O�@Ud7͐�$�\�D�O��W_�Ew�ͻ�7��oD����y��,��Ƣ�cƙd	���U�u�:�#�h6]�R
�U~	V�՟R�V������/�:r�F¬�k?|Ī�r\�<.�^9����?��]Aʻ�iT;vg�PpyM���1��},�dY\e8��I��2�wjM��S/�p�1�\^�6$4�F��(:�\nۢ�2�}�Pm�X�'.����U�3��bq�nXK�i_BD�_H}�r;Y^�t�<���o��#gw��2q_�|�^�<��E�h���O�����R�-Ɖ���S�	!��z�1�+iH�1G���+<����~�;|�F�{�}v�;s�j�Q;�٩�;&f�}�������tL ���#��Ъ>;��z���?U˽�~������e��{K%��/:F�/<�n�2k�8�x��S-�5�`��ԗ�H�{���R�y�S�(w��ѥe
�	0���w�޻�U1��7V-Q�̶ꪸ�g�X��3V&�T[+)b����2���(���B��,��z����9���B`��!��o�ע(�W�RZ���m��%/V�&��|g��f��*[_��nn��M�M`�%��)��Z�K$�����F�� ��$r^�k�K,	u;w������X���;�L�eoI�6��y%����~����)���0"�zc�BH�<�kW�E\.�b��R>mٺ��<����͑Թ���a=2X���=/��_;	Ρ�e&o.����]��2!�嫈�"I������j�höR��͒\L�0�e������,)ýf�; ��E��0��<%�Q�Aø�x8�� �]eQL�;|���꼬z�W2
�H�z�_��
/K`J�O�O�Y�~j���>����d�v��%�ެ7�4{%��٥7Z��>����|��5^�\ױ���:��Z^;��U��s�)��#�|�.̡���R2��j����şBб���*cMvD�W^{�������m�D��0�,������#���?O����
����?z�{ȓ'�|����/�����/�����/�����/�����/�����/�����/�����/|� $#��ە@�[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://beonp5vcsmbqt"
path="res://.godot/imported/Pong-remake.png-d99745d5c48407fe384ce0bf2b317f1c.ctex"
metadata={
"vram_texture": false
}
 �(I_���RSCC      �� E  o
  N
  �
  ]  �
      L	  �	  O	    �	  p
  �
  �
  �
  �
  o  �  6  �  �  d  �  ,  0  E  ;  �
  r  	  (�/�` �Y ��X%P ��jo�g>4���vpY^�?�$�k��>����;�8d��E;��_�u �ח�*u۾��*�!0�I�tr3�L?aE���E!��,я��l��K��M�TO'Ҩ�?�W34=�k4��҇u(r��Ư���}!����'�h|Z�7�'(N�b����O���<_6]+���~�$;Q�V�"��7��o��i��L�SbZ�s_n�,]�꿑}.�Q�-�Ԝ�7G��j	.�����AF�
"���9��!F��f�CG�(�����)\���i�[)B��m ���k�fe�A_�|�(�=������T2�����$|d����Kt�m��pG2��f�e:�/�L�|�/1	ߡ�|�n&2�ʡЅ�.��׾ơ;��f�%�L�˼r�oQ�.���w���#�O��D�M��D����י��J畫,*�I�G�(D��fVS��<��6���U�e
��&�x|��&]g&
�o�
n
�o2����x���K*a'�T.���	/�\�n:_��h�X?�Y��gRY��s�$�t�;���7�.r	#���e�������%�H7I��|�M��)<�C�Q��W����O��a�ӿGx�3������ ��<�.`��%�j��p�QhQZ�*8���C�{Se��K�
���r!.�0W�-��?!�����dB�.K�-=�rBB�*�\ZbZzҾ^�M��.b6���n}���,i'ɺ6	�$�Z���kgmO|��SS
u��K{a���U��|$j����*6��]���f*4��sUGL��Séz����aRC)f(��Ky�.�Ky�_��퀻�Ȼ�ҝ���GD1�8*��Y�8j��bևGn}�O��Q5�L��Z6l��c�Bֵ-h��kY.wq��UV!���v3;WW���@pR�n����Eyb6�����qt�m?���?F�@���wr�%�m;:������G����H/%�p9��������8��"ut^;"3z�5&�A��u�O,���8�&��H�$	�s׮��O�dkv�l�yN��������7�`�;ԻT״����n�����쎁~�pzb�
�a�}��"8h�u��8ڲ��1��Ţ�ٟ؆�Vc����Ǟ>^a�?�� �?$�m�|�KV�>��0gS�����0�I���!��Z�o$�����K��]�c�f�& ���F�23����D*��q¼ˡy����f�5S��n�Ћ���P/��G��b�YL�>fUe]�"��x�>�F�?q.a�������#��%�C�G	3<�`/{�bT���
�$F���f�b��	h��d{�h7�ʾ����2���FSiR<~���9t�0�i����h |l�W#�B�S0��Zf�{I6d��r{ӆ�l����Uq7({۫b�-c�r}00����Wjq~@��'��XP�<�4�4iR�Pc�䥣� c�P���D���И��l�ڂ�	��"u&q�@T���tѠ�s�4����:��)([�HQ>�E��`,b���|�� �.��b2&�q�
>ŘxC2��2�O�z?���MJP�Q�"�u-�Mֵ���kcHѡ�u�
:A��?z��F�v|�S�)1drU�@��'��
�D]A#��YG��z�]	!��(+i�L�@��f����4`�60Ī�[g����0�W�+�'Ze����C�i�@�p)���n��Of�dȬR��Q��UR�TVn{�hO�n%Y�*�Pq��< ��[��1��L�!����`�
,�h����u-��u�vq�
���*��	�H�;w�K�e~y��;	F��M�4�c*���O�r@>1�޲:;����x���|�c��)c�6F9m��Yj�a��m�T�`�,TQ`�>�ڐ@��X?L��N+�	�����,_62�Jˋ�%�j����$�E;-C���"��#�l�dk��RsD�zDk!��l�.�um�SS4��x�Z'�����yM�5:4kpF��+DR� ���mf3Q���
J�5^*�JK
���B�iY,���i�n��	�d���
��&�ښ��
�,޵�P��(,� ��'�s~r���Z��|�tCS�Uׯ��]x�kV��C���k�"�\�ε�������U��6���pk�l��p����*�+9)^p�T�B�j�Xo?�n�?[Kwo���#��4��lO\-�um�#�ڞh-f{��z�	\w�w�U�t�'Ǫ���Ӽ!_��oO�s6����>/' 4h q���"8h2Y�ʊ��~C�qy�l"�nf���Z��N�f���E�������*} �
����r��v�Ux�~b���^��G�R�΂�s����f��pW��v�4����Ө� f�4������4�P!eȨ<`�=EV#������-�q�*�o��%Rc�.'Iƭf���B�L?HT��ij����E�' F�M�]n�!o�G�t 3�'j~~��,>���㉌)Y�ߞ��(�X���'w(M��:v���D,���6B�ٕ��%m<TA�ӕp���\D<��Ϸ��>_�ܨ�E��e+�������%������K��IC��Ƭ�4=����7}'�����-m�}��W�5������ U����`����z¾k���J�M_�������:��;gj�#�����!����/�
�I��2����Kj�~� ��f�D2Lb8��Bd阑�a�%��)�j��A��Q��s�7�j�h�9o瀔F�� ��i�����d��EF���DA���J�'� �C<�~)��(��H�V\8����$�i8��I��>�ئA(�/�` -S Z�� O ֲ���ю���J���E لqh���Z�OPO�8&�
�v���J8�l��	��Q~�B����\��ۍD􋶶6��L)���eh��'���'5u�w��N�fF��uhF�ߊ��ߪ�i�HxT���9XY��8rp�
���$���@���8�b�C�T^IJ_Uc��cuF)ɋ
�ġɓ�-'L��c�d	sF���X�V�+)�؛M�*�	K�l֌�M�g$|rj"�|����Ӹ�����CI�
'�Hz@���<>���&�pI�T����8^�[yDb8m�t�87r���8��ĳ�X����AI&���$R���W���5�o��o-Y��.s�;�ڢcV��T^�������D!���C�=���@L���
�4͐96~�G�o�,qF�03L8;m�0�y=[���$�֜���gZ"j͝jo���v~���ٵ�u'E��ou�#�.��|�.���Ŕ7��h�c�(%63��3pv�!������a2��2�Y�d�p�p��qs�,͕"l�ېc�Ua�i��|,���x=t�:崗1-�p�ZӦ��~qRJ9���d�,Nw�i(�d�6W��-<n`����f�tb�n���S`=>>^T6�PE3\��W��������P�����̌�CQ�R&��!]�rj��Qr�Q����,�bLSG�j9�7dq����gZ*�5�`k*i��5Y-�XMm�P�I��������UI�m8 �bywr(e���M#F
\W��w�aE&ך4\�<�J�4+qᕐ�1b���P=�@�r���##,)�
�����6�^ͦڈd�5M��s]�h��~��o��o5_h�s�9X�@��8�c�Z�}0���[�^F�= ��RC�'���T�n+z�	 �d&�
H���\#�1�Sbz��i�v�Z,�զ�m�]+���+$��Vpv����`����@LK�kv������fsw��\�$�q7��U2�#�H�D�o�g��X%�Q���A]�O$���x�ǣ����t�����)"���g��J�V`�Vh�^x�r f�lm��Oz����l�	j�L��c瓓*�A�0u����G+0��.�ܠ�s{8���1��Ȃ����ڀ��F&�(���jMh��*����\�Qs^t9��oa*�K��.[��{�yk�nMR�x��:��s+��|�L���(���0��[t�����<��b����dq�^0�$o"�Nb^���,|�6{A��{�{�s]���mt�v�-��y���/2fx-gy�>�4x�����힬���;�BKN�f�'�!��z'�X"���DD�B�J־Ekf�5}r�[�O�[}�^d���p��YvT��K�,I!wp�I\�l�W_.�ZTc|�e��zْ!�/�VZ0X�ޅM�*W� �ῤN鑚����k�5]hwsw-�Z�U�_�H��&����<�\�FH�/��[��9�t9����F3b!�"H��>x��g_��3-��y����Fj3�˹x�m�K;�;њ�2�����!��z��^����*� Jطm��b�)DXD�^���[�H���&i�����H����ͽ���l��G�c/��0U��M���V��Č�*�Q��k�%̾�~�t��x=r�����f��˹8��\�Rt��o�����!v���Dgk��}5/8=�El�y���a�n�3���_��}��;�2�D�,jb���FA��x�5u@�$��H���𝃕ed�1�c�C�i���!�(�����g${�ۼ�D�ܻ���^�G҈�F�s��e�.��;o%�\����;�TO�W�TO㘖r6����֛[���T�F7���3��GLKx��q�G�3�1겊��~���B���6���m5�m�o�����0��K,j�P�捺�^R��K��5{�d�'K<�gZ���9��]�벇\v���bсg_xv]:��c�yu��W����c��=ӓ=�3=Քi���Vw��p����"�3u�a�C(�.\Vl:����������\~���\`H�'cTz��r�+�o��_
��=�F����R�IIA�p�);�R�LIR�Piq��uIq��dꬤi iPOs+���W�Ɔ��6��D8�<2#.����/K(c6�V�1��I��&qtϖ�vK�(m�L>g��	lU�=���Q�C�R��̜�kF.�f���EDf�^��	 }B�0c�f�&�k��p�A�!a�)�V*�>,�d��.�I@��$H}n6n�˵� os�EL0_��W5�2��B'ϸ>y�{�������5V�t��IF�d! ��R��̠��_$-�'��a�وQ*#WH1fu�H%��>��V��6j�k�I̔G��D��JÜ$4ҟș�����ƪ�1��8�L���d����I�d������Mm����āx�Fs&�V�+�@�5��5U�n���܋�� �m����E{x�΋7�
����ڭ�	M�&���Y`&��u���9�)�C/��%]'W�l#Cb�F�m
�,`���D����ֲ�6f�4��w��	��������6՜��8ѕo%�Sک�V�t�!�~H�&7N����^����!H(�/�` %R J�0 Q0�*���������'qo\��+#�x�+��@��[��x�{jj����~J�u���ش*�ҩ9@���������R���i���gLB�%�+D�]jE���$�#��$�/d*�l���x;6���O3��WmK��k��S����ˋ���-�9��A�U��
�
��FM�U[���wy�tW��,��$l<(�0Յ��D,h�T��%Fj �R���!�UM�b-E�y�y�01*�1rĈ���J����ztq6W���X�v��H��f�؞{��.OI���zJ��xѡ�˽h��ƆbA0-��Wm�b��Ƙh�Q���}�UJ�]_6�����&ϰ��X���K/G�	��	E~
����xzx#Oq���=%�0�>{�Ӵ���������EIҁ`[4�(�4#h���,(�j��f��ڒ�F��Xn��h) B8�s�|�tG���]�V|�Kp"�!v�翛81��o�ņ&�� ���b�=L�)*Q%%?1����cF�x�%��+wȔti�-�;6����<��Зy;���<�큿''�:����F/
�Omt�W�]��U��Ҽ����Z� ��8�.�*δz�n{�������?4#�
��[��݁h��ߏ�<�6GZ���@� vN`u������0�t�Mߥ1����.�R$1����5�M]ᚮ)�g������x7������#���ր�6o���]�z��O���6��L���s���5]on��s��v������n�/�nc�<$��(!�������
���u�,c勞N�x�w	�t�a�y�c�Ng�$�9V5q��桲�)��!݅�d���h$�Ǩ���27�$Lۈ�0�D�-O�]���w3f�6�����!p �%���.�xU�BE6��G��A�����X�C��<i�!Q�#���|��?}�>�73a&Z��_ū�*~^��I_�Ma���滌�t��w�@#YTt�	�q�1�7������R���DKK������_��@��.�H�"�A~3��N#k&��Q����O����OL���'�1%�lk!�=1�2���e4"aÑ:E�!���	��ܽ�[��ۍ����������vŎ��uE���V��Ë<�N���놞-�װG�����T�>�����c�~��#��0E�xa���f(B*]
�8[������.M�&����ި�
U�rݖ����#��ʃ�d�@хק�W�ʇ̘�D�
�l��c��� )�N@H�8ۭ������Fm(L�諶h
/�C�D��]_�{8B��<t�W�C�n9�ye��\�s��U�2���2�"4���a���۱�� ��޵SV�^����e����<\u�&��L��N����A&�9m���5J�F�&A��piR���ޘ�����W����%�`@�B��$Οk�%� m�¥a��-gKs��;T��̝�cM��[�?�Ee��E�-�ֶ&Z*��`�EsG�ѐ�gZٖ���˽j�3�h�E~�GN�NdA髶�nG�5w"�H��(Q�d���/�j�2�#�xj�:vI�y��D�`%Q��xV�Bhh*�߃32�؛5#w8��v*��jKt{���[K��F�D21ݳ��ޝ��O9_�GF7�b&k������A$B����e�	��������\-"|d3��,x5�HH=_R�O#)�C�*C?T���Z*����d;�>�@}�3����8�yV)�q	_��v��Md�/^(�$�H�}og�p���vSv-ͷ��7j�L���\{V���X�T�C�L�Mn:feq��M��Q
=�y"O�̔��wS6=��e�[��&��	G�c�����(��9�W�wy���B �Nhᅵ�>���Ev` �J����b���M&U3!%.-�l���#��@HEz�HW�(o3��>��{�s'R�@,�ٽ�Q��U�R8�ut�� *F0��+̘i"]Ϝ����m�X�hFa���Eӭ3��T�Q~�	��C
�H$HA�6�c��| =�$�C�s:|��8�
DwP�2	�	 �_^3G�Bw�xlN0�5�^��.X@c�@�j.K�E��w�z��7e8�c��K)��%,u�l��;ѫ�#���;U�0CO[��GY�����%��ͥ�������-̷^���.��wȁ�үj��mp���{�in�RѪ�zGp���0"M?��*����F��gf�F{�<j�A�@^`v����ę�62���'
3����v�R @&n�w�;�v3�O���	M�GQcO~��l8�Tۂ�/'m��6�9��n#mF�P���&f���<��(��z�\�eU[)�=Ƥ�v嵵������r�+��=�#	Fx���B��(�? ��B�S뒷A��5H!�h�ה�B\N<s�ƙi{�wi��R�'0�=5m�B�qVdv�~� P����dM+�Ș_V\��4��T�`Z���_�c���&��c��o7;;��^��k��;\���D�z�7���n]E~�Z��Q>J�8}��a:/7�~��1(�Ơ��-��*(�/�` �W �0#O �2��d��qŪ͑���i1O��%�:�p��+�]q�11hi����G6��������B���˗ܺ��U�����R�$$;���@��#T@��J���"K��]zZ�͢J`s=�"�Eg��;��$�r��]�㝼]��"�$na<�F���+_���kp� 8%0N9�膻q����������:��=kW�w���Ē����yb���գ�C	�w���)ǦB@�ʓ�!�����K� �����h;p�x�7��Ҟ��? ���u����CL�9"pr�9[]>R tb�!��}p�¬|t�r��+!d��m~c���'�J�Z��1o�YEX���A�gZ�C텄�9�09�2ǹ��eE)�*=��u��PGHZ�V3g���ln(]��٠�mb^�U��N9�B�$rȜ��\�������7���N�ho��5���m�~�@�u���?�� ��n������3X��2��E��>��&<�s�̆�h�Ţq(�vn�}p������W7'�CB�%�&����^���+u	�I���'z��ܳ6��?��r��	�5�iYV�c�N�]*P2dsm�/=�pmf���,̺��l4�[ؔ<�ӫR�7�gwʱ�s�IdH�YSKM�v��A7�����f�}�1c�0�e�Γ�lK��ږ��Z6u�Fc��Xw�K�X�8����8%�h_��SxV���:�̪�+�����E����{��k{G��輪�O����O'��/Cx~�CF*�P�CiNL�`�E�Vr��$��5�ϖ��h���N�-��i����5�����a�����&Pj#����M���v����2���������R�7V���:i�iL�� 3L5iHs�6j,L�~���9�jn�:G��H�h��.ʉ�A����>�?a.b74�1;�1���?�h��O���L-^<jY���ϖ7���6���o��ԧW|�O�l�դ�r��S�3<�%0���Ź�pq0^�d�0aVf�H���l�'l"�=�ߘ�oL�c�h�_���ܳ&��Vo���
�jF���SO�k���Q��8;��Y��.�2��M�\W�}5m����W~_7n~c�n~cݞ�x��!Ƿ?�*����=�� ��	�-/�T0u�9Cr��$�b`� �.1ȴ����=�E	��h��g�"w[u�]�Sݣ�dt��#�<U �u�H�ڕkO"��H}5��L����/ⴁ�Y�z��U��2G�`�Ç�oc�v/"�aa����V«�-J$"x�	Â�m��ߙ��^5!x�e�=�)a3h<e���;�V�EW���]i�J�1���h7��Έ��/C8�kag�0�ެtxp�]'I���⹳�}��RA0�I�P�"���`r����v-��x�\<��"�VMS�h��M��+ە@}U͟m=�������Q<f���
͓F�(*���Q+���@_���:Y'l�U��'��t��-^�͗:�����k�[4�l!��c+ŕ��8V��4��XbB��aU�"	 �,�*g��&�Q�ve�W��(G?}��L αeh����+��y*�Ŏ��<K�Tf�-dy�u1q4g����Z���k��x���X�ul��1[��qQ��p6xV}s!5���r���ȣ׽�u�5M�C}�5�2/����.��.cf�	c�=�������#��s$8!�=Fu'O��'ߵ�))GT�郓8��K�gn�#�-�H,�H�y]��y%v^D��ʇf�]��Vۃ�m�%]�s�L̉�8�1qi~�%�r��'�V��I���E_�"��Y���Gbb����gf��\W��j�J!>Ƕ�G��ۧA��$���_�e#�hE���М�UDE0���h�Õ,���d��':nHE����¸ N+�d����� ��e�>h����V��eUebR�d�\9���,�4b���R����ن�%Ph�tP�����3躼�Ǐ\^��Xեy�ue����G�y=�ۭE�I�k��k���w�D����?Z�w��/Cm�l���#�٘K5�4�����Y�eeV'lR27J'�GE����*�m��r�d�q8��v�Uj�]���R��Sj����@kqy{,̶�-��D��o�c�+��A[�A4�q�Q����}G�����q��Wh`_Dt��ed�"�,�*/N��dt���-WbT�B���$g�����$�4"2#"")hs��*5SNը$��������EJNrS� �=y:{���ؤ�G`�y��!5[�
����ßW//'y��$1IDG�s�g��O���څ.א����ԝ�Vf�§صg 7��#퀯0�s��p�,ZhٷRڄ��t����
�c��ei�,�ߣ��ڏ�)`�%��4�X��I�[����AV�K��
��fr����L/��M
���r��s˃9ohf�[�� +c�v���b��kմ��G����"#A�S��HD�hn�Xn'��T��pc�L�%���j`^.ePRǴ���@Z�%�G�������ӴB9̓2������lIBO�`�� qTau�@EY�nI��ݙ�s-���cGjv`�3�'�aI��Q�5��ں��_�%���.�g.&No6��wȉ��Ȋ�g��Đ�7D G�a�]������I�t@[(5w�X�M�O6`a4b�Y�?H�M����p-��.x�;`�k�]D�nS��Q�Fb� ��Os��(�/�` �Z ���$P 3�.���T �S� <�����l�`����]�Vݟxr� �=B���u*�1���G���sqdh�ѽ���݌D�H�R:7&����vt���y$K��'�H�_7oW�[O��k����[�Z��s�2�z�P�-��`������AܧN������3q��N�8�l��j�
��9� �4����R������!>�`�	��9ر�&����k#��)�G�j��#���8�<_o��;^ω]���f�]�G�nI���yI��;��TZ��������'�jDf��5*%ᬬ�*�����I��^Uos}�R9�tqJ�$�]����V�XDA�f�|���Ӈ��6-7ݹF|�o�Sl`h�E�k�E�g����i4]��{m1~�S�h�.F��_������1��(*+ob,]�h�4f����IC�tM��s�Bb	��Ơ`!s���-g�5�b�i�;^�E&���|���s2>�<4�
�H���[t(�"�}U�FzUsg�:�)]��I7B'4�B�n%��`� 앉��D���.���*t��˰�{��5{BVJ%�^���W2|�2i�D[�n
��*��#��9D>��xv��:-��o搉����9f���[|���a���ċk�\�����,4v������o�	.�9��s���q�B\w "�e!7�@�BG�a��g�*���t�-Hí����O��AD۝-w� �<8��k�	���j4.�Ba�]� �%�@7hHH�&��d��1�B�E1NY3Y�F-����
᎐	R�0-R~���0آ�v5����D�$d�J�\��ݛ��@wz�.�o���x�C�/h ���-���V�z��z�yge'�Djy{�kwt��cB`�J�HP��J�H��RQ4�f:YVU[\c�T1;`jlʗ�- ST<������H^/E�O�/�^��cBz�������*�O����VJ�~/��0T��\�j�-Y,����N�hA몡�ѢFP�,��I/�?f[?�rPq��7ld6�x�#w���j.�^��{�R:���^��3��V�s5g�,O�;��"�^k�m�Z,4�提Ob�B�$�Y>�qe�,��"Q�nEs'�{ա��}� 5h+�rC/�r���p"����^��%���"ddt���cb���0咸�����h���Ξ��q�E��Uӭ_Wh/��覺�j���|�A��&l�p%�y'�mQ\����s��g�����T��sh}Z���y|��X�����?Y$.q�^���A7X��$�z{
�9G�,g����lZ�|_�v(@	�(���D+�c9x����C"���<�[�j�-u��ެ���{��䮎��t�$t��]���:'�}�H�Wώt�`���dF�9I>��L �be+i��r�ԉSM�tG.�2.d�,�5�o�SfdQ2��|:��$Ms��/�U՟�a��������VJ���H*t+�R��[�9�JS��<;�]�,����w?j8d^͹�t�z}§&� �{����ok+Uw7!����_~�`2m(��͜_�;Փ}�#{�oC��ok�&\Yr X��ؐP�ìM��.s�&K0��&�/�؛���G$҇y='�6Z_����Vo#�7X ?�i8g��G�� ��\��õ|#25������訃p.�,K������/��1���J�2u�l� �á�HD���U��>�ge��*�eio�.���/0¡�%}�a:�zNF�)��z_$����/��jn�� ��H^%a�i����	C��@�ݖ��w�cH���) q��d�����|	��g�D��%$�]Or�ZXm�<��m'F�!D^�-j<(ǖkpÄM o����T��@�Y�A��-8DE����L���vi��5��Ą��,���c���Y$.Slu%���nJ
`|ݨ��v�mwh�Cp���R���&�@�h��ݪ~�B�r��'݄`:A���p�N'�ʪ�G,JX�rD"�DTˡE�H
bT�@=��GN���)>�\}q#S��*�(��lS�A0��GdFq�%�9i�˹�ڲEb�W=O^�D���r��D��&Bi�|�(0�}1�#�>��fj���Z��� M	bb<���?J�t��������ʦ='v�"�UU�}�?����z*�t��>i��i<����W��^@��wb+{tY���Zil`�8dU�h��SВ��Pv��t�|�e'B�E�|Ƀ��˚#D����[��������i��V�>�,�Ƥ�ɸ�;"Wa�M�����wi�Gi	�j�[X=�ꨑ �4#"���$I�`�)�p=R�n��j~T�|��a�T9P9-����]��c��Q-��1��U~L�G��N��8&J�&w���$�s7���{�[��E���%-�Ü&��b�X��$ړ.�Fy|���iq��3�W�w����+O0�H[��(���7}:.1��;S` "�0�8q"�*J(K�+{�h�b΀Eh���Ў��&���d�:?hO�!�S���H2���2�j��ihӾ���I	���Xr�lC�!��25z������U~�pB��"T%���O�K��%�	���v���Q�=�=��j��c,��G��7߬��d8=�ͥ�B���(`�ܱ������[��I�Ǧ^���7o��ضŬ!��s(x�`簛 C���3"nr��)�> (�%Z�R�<6��E ������v�C��Ǡ��9%�L��T#�j��רe�l`k��aR�Y�Un1@�>!�?��G�j-U�ԗ�@Hdf�e*3:�,��:S��^��<� �(�/�` �T z��!Q �2����3f�9��>2�F���J��c�+�M	���+��m��� �������sc���o?���Z[i?�q��-e
�7]���Nջ<��֦_�յ�mkjc�y�؃M����O�X����vrؐ"��G4�1~sђ���INa'qz U������%�0p:��
2qЭKѥ`�Sr������՜$佼칗�tZ�c�/ۖ�|���y�����o��<'��y< �?�][y�f�~K c�`�#vl�+_��#J	�u�P���{����+B&y�i2] �A� 6�L�O[yFB~��A��\p�\Q頂ұ�C�r�hiE��TwXTT���<�u��P��Sr�ĥ\����i7�yP�B�{f¥���`�җmS)�����Q3������|�H������am�2�/	�L�-�蔱D�.@Bj�E�d%��ӢߩꔈK�7��$�z�<�]
�Ƨsݥ�m|Q-h�o����;G;.��P��_�����v�w��Ր��bUC���� ��du@�#
0�:��-#���&eV~\�yvfMvX��+/AMtw�z"xf�WΗ� 0����"@�`����吨��t�z��E��my�\� <�^S>�T��c7��F���<r`/�!��RKK��(�Q���˜��<�4'	s����W
�1�R�z�;^�n��O�j4�	h��eHиQf��e}�2��k��gh7�v���-��}��)�
/�dC)}uB�$�E�X�yF��Y�ݴ8DS��K�u�}:�n�ucO���g�/�m�?Yh�k�͸�_�$�$��^ܴy\'G��^��9ɐ!K�d`�nvS7e¥g�����'��)}~pf ֞[�>/��������ige���}IB)���yA_~�������q6HBe8��Uz�Hڠ�c�)���ԒQj-Y��u�	l���R7u����R`
\ݜ$�uc��:ߡ/W��켧�r�r>�����\�p��zԞ�m{�n/�ް~��������P��b�@#��<�2-2���(kq�;��_P�LM�H/Bb�01o��A�"80�xa�E%W�fwu���/�)���a��3L�9IX����n�u��F��)S�������ق�C<�H�X�8ɍ���r�kd	�'�b'^��L���%�:R�,v�x�Ʃ���S
n����|� �>�����$����>��|�	�:.zx���<�=s����q��H�*���E%�$�I�tE�R7I�w�f�ݯ�z���^�����	�g��B�<cfy�LBE��PC5U�!C��%H*G����B�&�a�,aYR�l��y�D��;[K�a!l'�c$`�)��7C����>�����-������շ����}9���7ظ���
u�ۺ݅�p)z�V�e[ ����x�]��H�{�=���Q}�E|�X,g���ĶyI^�IZ����]�2�ZNa5"��a+֖�[)Ar�ƃL�ۚ�'�Vrg
��3���6qKiP���ϗ$z�O���S��-��8����m/�ڌ���
�Ky��s��)��:��.tt��U�BK�ic����@V#UQ�^�0�K�`L������tJ.q���L��WfX
����m���˶3���7��~�w���Xٍ�����M��(ZԊL%\1ʩ�kߴ��S�Ń��֭d#3��ǐ���
�t�E��Cd��9�>47{H,W7-�\^��='\���s+/��m��=^�K�n�XY!�̈�D�)�8v ��$zC��fj���UNCĤ'eΑ셥�UV���=���i��Զt�I��嵞��_�0˫����9�̱2,b�#��2�fd¬9���±�	�I�.,e�ti!#$��"%=,�Z��V���j�mOu��˶*۹,Ra�_�����2���>�(�'�(w�5�QF�OTV�@AbR`奔ò�p�[�b��,�c�3u�� R>��A=.xb3�W��rd�%��@�q|M��9�ӡ���D"��0��~���LTӻ��ƉX�a���:�̱2^�j9r5ltA�#i9�s�`.h�m�;W8dݜd0�!VE�
[Q ��Diw-.�!P׍�n��������z�v��l�u/��~>��ޯ'����ѠRN"�I���p��0)c��LE���Q7�\���B(�A��ƒ<Ȱ-u����;�R.n͇<+�lV�,+�I����x�ىX�^h����2�����h����.��Qf}�䄳��:7�!U<C��R��l~���2I�gk�7�#a���lmb���2�i"�/����H�%DP�������������R���Ŀ'� s��V}e����'V�;�l�FNAAa��8qp��Dp��8|Ϙ.G_.]�M�n���y�8*��g<#D�nrwq���a���^{Ep���eO����,���d�Feh�,lO�#��Մ�������d��r�:�o:�����a=�@�;`4��d���jcC~m;"�M:�jGH�'�=�~���}0Ag����������'��@8�$G*�����U���?����x���W�O #k��0�����:���f��$�r�7: ����:;��)�j*6��
�����D�a������!�\r�?�`�
(�/�` �W ���#N �2����JV*T,A����_�{���4W�M��X�~��C>db.}�t4	� /��-:IE{�[v_5/�;��Z�[n)S
*V����j��L]� 蒠JKM�a�+������>k�j�YnM�E�����rK*O������0���-���@���$Ȫ1��` H��BE=qiY���<�N��S�&�u��Zuhk�[�ۥn��쓟���v�߯���VOXA�`eyyem� j��OVx��V���S0����J�z�r�x1��x�z΁X��1$�����U��z>&&_��J�{
�X �����A.&K=Q���X:�n�2�m�����, ,���
�O9\'��B�47I[O�5���B�&��lH(.�Kג�ܪ����<��+Z!3N=���bN�Q���.Ξt��_?��������'m��g�'��qH1/��ć�EW]2���<��K������Y"6��d��hsͻOr}o!�{SnMn���C\<�w2T�6�p#ʊlL =�X��	0��9�AvQrdAF�}&Aa
EV@s�N��A$`p�T�9\�F�~�3��%T��ގW��4���ӭ������m��C)��G�F� h�N��U��b�>g�̅Ҍ��<O��<��SVD9���Yv6j��W-�U��K���-Yr�U���c�yGvgڙ̟��}���P�ד�[TCw��EՂ\u�t&Ͼ��t'�G��I؁�[��,�4*)�h45�`��r�
0������bQ����նC�����V�W�-Ty���-;T������L[5��,�B�<���}Z��CJ����J�IGLn�"�O�	۪���A�sHm�Neް��������8r`yb��ʊ@�h�QC��z���zh�C,1ϰfU3=C�قdh�^�6�*Shې]GF.n:���=�cY���K.;S�Z���!�ߋ�9��.��{��mL��Eڷ��X��y��K��!�0���R�  Mae0u�FN�+'�+�@���dH���%ڪk�X�D����=L��X�����8΁\��5/�b��lZ�lڲ�U��ɝ�$�������������>��y�>}i���x�w�#�mL;��w�7{Y��"yį;�68����y�Ňa}�a<�a~�`���D���{(5�Ѩ�0��h�v �h�i�s�����Y�ew0�C���36Z<K>��xD�����2'x�0�5-�̇���&�}�0"�K�S�������R��pY�D9����E��(�!�����R�,��{��ͥ��͕xsH9ۘ��X�,�Ū�,Z�}�x;�9�w��ݵ��u\���u���H��{Q�ب�ᾚ�����o��H�*'#X��w=ˡr��R�M�9�^�߁�0sq��0������<DMU��*5U��ʕ�����iG�Y,'#~���|g�%�An�H�!�F2�����m	��?�y����N?^uo������W��KϦ=�V��nڥ7���M�����Mӿ�B�"ɏ-WOqMRQ���K�����V�_�E�`����)zw�{�D7�)�t���ҎG^\V��I�93ZOt=��Y�c�k��q���b8��bpc��;X�Q�nQ�3]�Ǌ����=V ��N;�+�3,�B���p!j���գ)��*i�Z7"a���M�tI��ą-B��;_�%�r8�����(�3�v�֖ `)�������i��>S픲?�ɑ\W�z�rlm�1��ު�sE�(G��	i�|�a	�(�>�C?�K�Euy�ܣe�w��W�*3�P �
��Z/��ɹ����F��&.?��9��-*V6�B0M_: A�7����0?Ԑ��d�L��q��B���ˡP?B�<����r���X���W��U��B�N��p6�/y�g��ծ~��'hy)�As$�������9��30m�1�.&`���x
/�����a�J�!b�h )��Ш�"���W�r��z�vm�X\��sV[u�vt�[u�ۧ��I��D^���S��_w�	´A�D���6l �߃��p�V�)�->
�_hDت��
�>,`!k���Zh�S�&�+O\5U͋K��J(�=U��D7\���B	�nC�_����}��Qq]O�Ҫ�JC�U�mG�N�z&;���3y�~��y�AB̄Uq<��ۘ<X���S�	FDD
��`���p-S�l���-Qr�c槸�J����Iӗ^ U��x^�g� }z�)	P)�%o�$)�e=����}e��I O�)N"Қ?�$V�u�i�I��DJ�WfɈs��SF�"A���,�'���L5-���_� .X��INR���X��wˏd �&ʘ&�v*�yt��G2Z$�fU���Р+�Z<�ɦזX82���L ���p@G�%t-�֔��_����P��H��Q�H��!�Ճ��Z���:�O���Ϧ7o�����W�x�h~�NaO�G�X���0H��
YII,y���� |3Sr	�؝	�c��~�������/��$�+��4�hZ�|Y�/�pP��:X�J�GK ��������bh��a@-���w��.R�_�x�������e�bh`�5.c�|�������ck/N>��2P�`2��{D��Q��rL���U68NG�}y�T�1"�k��75,^��߬iDE�E����?��z�����%��_(�/�` �W Z�d#N R��
%osd�Meg�B�MNP�Nc���'��@|�f��#�P�_v.�-����֣�b[w��8DDMD�K����)*,����i���7=/�T�ҥr^Ʀ{ـ����@�O�gN�>Ef�m��"�P�O�J%\S��=O���N˗Nq��N��/�#Í�u�Ƒ�]����pZf]w�S��k��WT⚊h^\t��9-�����}�Os�j�&_�������e9l�t1�a,֜��m���"mէ�T���GtZ�ʝ�yq.�Ѽ�VҼ�ԭG��~�I���A������,��U��V(�$���
�Kٳ���^�"�$���BEX^���Dzt,�o�P�?�P&o(ۺ���vOI-���Dt����y��9N�N�M?�X��^̦�(�Ǝ�v��P2k��E�gd��֠!�ȐEQ!K3�poqrX�1j�谑G��CY�L��l���V�-����֥�2Xꦤ�Vu�'�f��ߜ�ӡ��jUY��\k<;�V��y�t�f���r�_�%c�̾6�Uwqv�������Qf1;W��o����p?����vC4/���~��U%dk(�f�R-�����Z*�M����@�Z쪀VP,0�WL���R���e��X�
-��6��@�b� ��#�H�2�g�"��nN�w���;WG�b���u��V.���2w��AO2.�m<�y�J����u7=��eP�R�d��a@�����+Q��������R�)�W�U�=���T]�5���YfiB�Ax��#�4��'i��Q��2�4�a�Ft�C���0a٧�TX����Qw��Gܜ��t��X����T����f	&[Rh�K�TFDə�cJ��SOZWA�P+!S5ʒx������;��X�A�BP�.\�(� O[E�	{f���-Cƒ�/q(�'�2�h�6�/��%w����L՜N�f.+ץy�E�b�y�ꄉ���>�y�4������@K����#���!Tx �Ϙ��\�		�P�� +*i��qI�ޭ������������~_*ݔT��u��oF4/6¥4/Ny�\�Љ�$���*3 ��(��5��h�b@�]�8�U�-�{Jʤ��pD4/&��Gz�	s�d�s��	]��d�D[���zgS-��ɹ�$Il$b4�O>IZ���>��V&N��e�z3���F�E
6f@d�0�K� ^�$� 	!�A	E�.�C��|h�%R	�b�w:���s"�O'�;�L���F3��%��~>���;E��uCm����z��{��sJmF�;��k`���`a�I�Ú@\}WW��U�z~ں���+QU��=�6�������B��`�,�Jq��p��)�����*%��b(��v�>9���	k�Ӂ���&�1#�&�z�@�H���۳���.{Cѷ���0��3�|LBRi^��P��J)pDZ�����h��^�z�υ˱�'��O>I��ᷖ@M2_����E|�,L"�u��
K.�TB�u۴F���J��2�
'.�+�R�ܠ�Q�S�sqţ�P�2���2���TK���g�z�	���A���$!�D�8J�i%Z[ԬɢE����1څz�&6�	ᡦ�0[��a�e�{>e��uᥖN�ҙhN�`Ku�;��Fs�������	WJ�!�CW����`�{��O>�/3fNo��q��N��� �Dm4-�=m-k|��7͙t��M?i��C���SB_�������t�,[����}�:�����>*�9���/�;f��_�Wˬk��Wݵ_�:~�z�ӣ�(��em�E|����	�N#���<c��"z�F8�Ab�5L]l.+�)cb��{(�m�ULX��&��HT�s>���ݝ�#�1-����~>����DAhe�t�MF��77��s����nk��� 7i� HĂ�5b��0�z8�l���i�(Tv�E�KX�{>ζ�Q��|l�c:s�P�\V�!����}�9UK�����k�1ciF� :x<d�9/����\�\VTLIQ2�O�>d��cA�Jb�XM"QW|uo�U��o��w�1�����mӮn�MO�4b��I��wG�W���/jB?;������n�����Bw����I�e��w�Ԝa��@�P��ʑ~�~J(@	a���B:|V�����"Qm�r�������M3:�F���?t�kB�DT	5�"����c�)""""#R�vp"��1S
II
Ɵj��2<f���,F�"et!�F��j�Yo:Meg�2cYh���#�Vڤ����L�z6%R	�)���JS��iY�J����Ȼ����X�G@�aQ��z mP�L�ᑳ�O(M��Y)�|ޤx7��iwݐ��nC:�@�n���kKV��F�7)D�pf:s��k�<������n�^R�ak�O8����Pt���XX���,)8�ɢlA|��a���#��4��j)����W�ź�sܢ`�=�D��FspX�D[�n�Ɋ|��{)���f�8th/B2��$��>��u�F4�<Ȗ��panw�J�����l}yy��E�.�&���-�}�Fq_,^4�����������l(k�"���I������60�W,}� �̆�ZU�<r �����Y�P�����}9�()ч�,�W0$�By)ˎ�O�i&hZo�dtQ%�v ���Y؂k���2uI�c��4���Iog@�JH��? ?(�/�` J �~,>@*q��$��&���u�a��P�-I,�Q��H������a�g)����O˚����MdJ�����d3�4)���g�3��	�f}}Id����<,tu6X�ڪPX�nn���N#�ds�!� g����&�C��Fr���03�δ��`�44k��PP������^]��:�z�+ѷ��V}K��;��6��,tZ�:��\���Iݗ���$]��V�i	�L�"6:�Z���z��ic��cN&ӎZ�9�<�(��3���v%����X��]��Da5��(�EQ17��犣�
]5
�QU,,tY]��j������}���~��O1G��r�LS���H�K14��[��8;ܼx+�N������V�Q��rQ �؈_�)[͌�f��|��x��\b����咁��ٴ>�+�E@]E\?�lwS�U_ X}���'� �	��;X����bל|"o������B7w"B��B׷���`�����Id.v4��nZu�����|��P�5��04'a\�C������@�o��8c�G�*D�P6fȜ�a#�K!f�LK45���I�W�h�O�3t ���l���U^][���7��b��eV�۫�O"�`5�
����#����?��=�c�Ů��->au��np���x�p9i��
���h����\FO����an<�$75v6c��@�����]���o�vm?��bW�}qs�U�U\�D�֫\�֫n�:��|'���Ym��h�x:�ho�Γ�]�`��!��#;89�8����b�	��)�P�O���.��%�D��*���n�v3����m�ڥ`�+��7���n6�r��|�CR�9��RD	�1y��SDov�a�IΐnA����y��s��h�kr��y� ��:W�t��Vu �t�
��������?J����AdC��B��Xhݩ�\�]e�{�5�;��s�L�b���ԑ�����ʼShӂfb�X��t?|�B��m�f`�u���>� �':O40vV���l]`�����ǫbk[������6�����4�0���z�Z(9�16'u���+�Gs����R�_�� �kP�37��>K��
��|��`�47�a�@�&�ِ�<��/$ ���cc��/C�4�O��oV\����z�x�YJ�z��U����Rjc�U������E�oq���6 ����\Վ����]�`�Rmw��y JA��x�#�Sy��,����Ow���ǭ���PZΝ#$K�� &�#B�øGVR�����7��Xlm�$R�]mﱅ=(�5�>&3�Q������h��W�i#Խ@j��P�Pi;���d�@�wmm�q� �T��bgE��.܀}�U��ֺ\;�0���� �$�������!������de���������� p��i+W���J|�Yʫ�o����ݧ������bP��}���,�Q8́�{5Π��/�Bީy��c|Ys�CDO��'��<}.1�#� ^X�3��f:��<�c[Y��U��.�Z�M�����"��r�b���'�DXEY��{b=n��=��K��z�l}�+v{=���W�؉=�r�:�Jk~\��NW �p����4Fa󁗍/�k�ӆ�OM�'aE$�� �d.�2י�B[��A�C��������:�k\��U���D%Q�d?�Ty7��ub�t<�l����^�i��W7����7�BwH�:� >��v�Jka
x[������|�N�N&���T��~���:�OD�a�����T����@����!c
�� )HI�p�*;@d!KS֡%A�$��g�cc�B/�%�	�:��K���`�Y��u�(��Q�BkrnL(�����s;"����=J Wx�n�G�1�3���\�����	�&-a�'����lX2�����H]u�P���^�5��0 �LnSD�"]b�+-�(�(�-!���U��m'4,kF#Ot�]<�	@���c��Ǜ�KUZ��x��}��1�h~DH�mA�����Xa�_��Ѯ�V8�e(Y�,�+�99���-�t�y�~~�TM�x�!�K�c7�FR����{��aWNRaVY@H�3:�$��T���ߗF�5@�F� �M��Y���QH�,p�y�7l��\�6#a��+�������
H���P9x�P���+EH�ek:+n��?F���%YX�����k5jh6�<�z9��(�P5�s�����۷Ob��q�>��ts�=�I�ײQ �y�z����Pvj�tq�,��!H8r��E�6��T���:o̶��V�hU�>o��H}~	��\2�/�A��(�/�` L 
�:0jq1"��������`uf׹2���l�闔��U 0`a�<	�.&�5��y��*�{����q����z�^�qK�U�]��=�g������c"� V��?�����:�M}0��+�E�A��_d0�{mw��fw7۽٥���l�����Gc_L5���.p�WC`}�B,��Uw'�`*�VQ����V���w�eg���Jc���1{�u�d�V�.��#P�aS��ւ��鯸�X"<�mX�d+�R�d}�qw��[ۈsϑ�DZ"?J>2�䂻���/���ծ�����T�ݟ]������i|�O}�Ɋ���Ų����O��Vd���E��4.�k�������Ʋ�6�?�����wv�Y�"����8��d�X�0���Aa��H��Kx�� R�Z�	�^o���2_�%��E�nN�87;\�ܙ�a@O�$X�xr��=h	��~4��V������õ�ܵ��m�2��s���-�m�á�Ri��Xo���I���J�n��z���j�Թ��R�vT��L�`�rW?,���*�&Z�a�f����K%����e�2w��&Z���u�c�Z��uoM��C��(y/9r|����꧟j�ֶdm۲�kҸe�v�6�S<��Ԝʝ�u�Rd�dۦ9�;��,�f.E������/��z��fc?m�u;��<����"Zݽ�-�d��!$��7=b��pZ��i VQk�ޖT9�L4ә6�lh6�0��q6~�]�M�	�]`2�kn�C�	�-��J �;���[n�E?դ[�M��d�,�dK�I�䜬ŀ����+����1��^úͻ�e�T*M�ܦ9D�u[�T���O��3n8�m��и弔�[�	���_~�W~�~��_��J1��z���f�u�W���ݲ�Lu��Xz��l�4v����X��Ƹ}ic�V�Ƹ�Gs��Zۿ��"��~�U�dϰF���D}��_�ۻ�V�d%�qn,N�)A�QQEm� ��m�������=R�ѝ�<o�x>��I"*��C��I�*�aM���_/�.�U31��nU�����ٚ���d���j���E���VS'h��S�|�U~�K��f_�S�d)�qn/�HX	<�㧑W��Q�@Z?���pǏnPBU�e�����P��䄓��(?�����J��`}~ư� ���=��Z(i���a\��K݂�~��`UH$���+��/��J;�]�] I��,�v}E�n;�}�F��N���@|�]nto�th����"�z`h����8�ɴu�������ƭ���V���b�����5]3E��/�_�J��^��L��ze�S���zl�5i�s_/�O9Y�$��it�CJ���
4���:)[V��oŵ٘KEc� ������j"����Y-ܑJ�{�ͫ:L��g��c��pK�)'����m�1rl��r;����(��[�Il�1��~��]߁�٭��QЫ����|H��C�#J@sN�v��F�V����&'�=[��ѳŋ�1��}��?I�zBE
��1_��KVǐ�TjѮnƢݪ��3�E�T����~M���Hc`qv\�_��az6��T*QqY2�P�(+Q�Ѽ�=�&�gz��x��@�gR}Ķ�)pd���C�vu!�Ȱ���,��ǲ����O��vd#;َk�����q>�D�u]��[k�[#q���[/�Z�w��<^]�hU�����j4�I�j�+W�./v���6�D����.kW�yхt*�� Y7������
��dy��i��`nwBgg�
�~��"������hW�=���b̙�I
����c,��@%%�c�(,j��ot�ye;d�]��4�xa��ؐƊ�1_U�C�؍>`��m����tU[��5Y�乕�ޢ��2��/�fV��/�I#���eI�Ҹg�֖J���t֔|�( v"Byh�Q A	���h�Ʌe�p{T�(&�q.����";C�2�#߃~'#�t/�q&��7Sn��hn��:�����a�������T����Z��)1v���(�2�H�\�g#��z$hn_9�"� C�DP�2@;�M%wn9����*[x����~�t �//�(B�����?���.�a'?�ͦ@l{ы�cl��pǏ��"�00*f"#��['�<�CȎ�IGBV��64�^�����`��	v�e�mҎ�(�g�[�ydM5z�yed>���nN
�|f��H/��J����Й�:I�.q��$��"��0@�����TSɺ!���a��`ý����.��ȶW2"i�mǦ�J����	�E��-�TB<�ц2lF( �v�5��W�	�!���$!y�3c�{����+�{u�}�b���(7�
(�/�` -J z}(?@hq�i]��Ⱦї5��SqH�\�ǲ�A�u�� �kw{uK ��b<¿z�_�����{K������uV(����=3������u3���s�'�����:��,a��j3L��8��lL��X�);��`�ť��;�f�?a/�,�wP$��r�m[�ǵ\r)���F���妀Aa ��^��`6��~��`���+�����}r�bO��g�Fr�V�������6�OLX��Mh	���!��fJZSA󲳱s�3CS nj�6��8�v0�]���rW���Zn]iea����+l44o�ih�!���6G�dl46O���^�c!̲;v*����z��`��Y��l����|�K��D^�sH	���^���SG�Oʟ8Ҕ�Q<ذ_FQ���1}��*u4eĐ1S1b����%Xt21�0�3_�.0�L*����媎X
Z�r+�BVsS�0��\.[Wke�T��겱�߇0��f��ꎿ.�A���~�z���*^�`:l���\ ����rT����[Y_/�xq�����"��Q�����T�r���f�B�C�	Ϸ�FK�̏Of�����L�A�.�n[ƶ 0�����H�j��R`jH����*��)#UR\��L���Z$�`���	Θ�A�bl�E�;�ສ�v�h��4�9��3���fl����r\�6�"����\[����x0y)���(��+4�0W��bO�]%�M�����
}e�5Љ�V��[��m�m���4�Q������]�
�{fj�2oy�l؈!B���f>�̈R	�lm��.k�C`��`gy��:�+̪O|��R1��>���'��O*�_������\��R�~b.�̔��ww�d-�0��F�����n�ͦ�g����3�K7-�>�d{l�n�l�`���ٴG���o�{i��^�{0{��o�ad�H�k�F��j��`,���u��s0����7p���e4�������r��~�-����L��%� d�Z��l�v�Ϙ�M1��)�w���� ��m{m���5�󬷞<|�,�y�YdVI
��������V��i��E�9��������o����f5W�8BȎX��}�fS������9�<3P�d�m2��eRke����+��k��l�֗��^W����]�k�o�H���k ��V�!��N���ծ�zLcj�F�<k°B�<h��q�I} u:;̀�M�"�B���mN#J�ߖDGʜ��iGpZ:�tR�~�1�%}S@趻��Ga��|V�Y)ḁ`6*��.�u�Qo�Fu�a�r�k4a������[��H�R\�ȌBv󛧓�^�L�hqqe���:�0��lf/ݜ3'�|f�	�&��&�9l��>���Rݟ�*�@].��e�T]�2�C�'����0�S0��T0���^!���(�'����7�%�]%�D��@Ԃh(�M�Ϋ��>[�dg�@5p-�#��ZYH�����s]�꩎tVX��0f��껺�����=4��'J�"m5��={�چ�#��և�s��Ӹ`Е�0XI�Mԏ�53t�|HN����*�@apk�TaV�r���.Y���^��`���؋q�<f�S��4�=����/ʎ��C���f���O.�4�>S��j�Lֺ�O^֐�3T�f�9,�����yD&��e��ʢ�����O]N��������
��\�`�F�Fc7��w?�w���_��y2�.3	M�l�ɺ�$4+i�Ah	Z��	c��)Y�垬��>�y���L��v�:u�j6�=pz�z�y�������0��TfDD$�� I�Q�C$�{@�!�"�E2R�����^J��Qb��2sQ \�%�"�=�`#İ'�\Z����H��:��9�(���d����� ��X�Wz[�'$�
�<��6�N��K�S9�m=܆\��]X1Su��n��uF/���H�KG��K�-<�Q)TE{�Y?��%�\{�a�#q÷3ؔ�����i"��Ȋ��v���X-9�ُ:�p��1Ή��6��C���/bu�7�Z��E2O%�}5��G�U_ut�VA�ې�i='����p��p_`�S�W.�$B!�I>���n�s�9��d�}T�]f�d�:62�&���)��D����]t@z�����c�L�Vs�����+}��S�ڮެ�d�6ĕ -ӂ���4�
T�)%Q�J��S�:���M��C�&̈́ϟ�H��IЄՖK2<�����HL��.�QeF��g*WC&�娡۳~F��Nzo��*4�B�w�V�=�r���!^\�a[����/��1>�LI��5 w���D��x	R��{d�*�{�q�/�cf��q3XU}(ЯH���Sy
(�/�` mX ��4%P ���<}�hdU
��ӝE����{� ������g6�����:�?}��Q�����TPq���im#kkG��&"D&94Mn�g|y�:Dw��n�@�i|�xG��KD��J�z
c��� �{h=����=zm�^�g��b��=1�.���l�n�ꝱ�=�b��g��Փi锛hV�.���v����E�Oױ�̬�V��L9���RUc'�3N,�!pJ��P�Ȕ�Y�#j1'I���(H1�G.7����6��K}���OTRNrҤr������T|��?�U^������[4��k���9��.��er�)Zw�Dhk�*ʱ��x������E��K����ը�%���t��J�̬���ZD�}���o!�ހ,�Y�PFL9�&G  �\f��J���ܪÀ�-.H����cY�}F�\h�'�d`��E2���ķ����&k�o՟�!<l�ǝ��l�#��<��b��)˞�ݙK}O5�����$'M�kL2}q�|6&���b���X�I22e�=��4F �7������O�!�I?�$�J�'�?XVH�X�9�+�]��C\�K\u9	����rڨ�tX.���譇<Q��D����6Ƹ@Z�H�_��y��e���|���5u(f��gH��{�֕�;���f!R��|�1�A\U��r�,2c�kq�tj2�t�{z�L:����{�����S��l��C��}�'Ě�A'���&�?�}B�m����m4K $�`���DD�8@8�S���8cn'�C�/����Navm�������UH���"̮�t.����s��:��3��P,t��\=G<�2�I��D�v���[�8��y�l�pl��eeC?f��Hӝd�vD.���8�'���W|BB��**��Bﴋ�O���k��}Ύ��^Ȓ�;�. �/ ݅ad|��$P�OJ���ϥ9b�B"�
�D5��iP�j,t�4�)	ގ��WhU�A�Sk#���R��e�q���'y�B�g�f|�D�3"f�!�x Bg;�fB��sa��m8[$�՜��*����H��o�Ȧ�o]��E"��_/Vu��k�<����v	JYz� Z�l��A1���d���<uA],tu���UґNf�����4g�i'K�Z������u��=}����R���S����*f�ފ���)�v�4< y3{Xa�#f��g�"dٿ�1��X��nr�>�3M��dN��L-�R�m:}8ڵ�[�&�}Zh�d��H&?f°[NIy�F��Jav�0Ӯ�MwL��$�n������*��F:] !`,t�H:�����'��l����Γv�v�譃J8�
gz�E�2�B�z1C�jiG�v��>zΪ����M�H�&ߛa�ā#�&;��ΩJS�ۿВ���N�+Ȓ 9�A����l��}M@��P^�����ȅ�µ��/�Xl����YpW�Upi"~$��n���_�` ��E��)4��mC��-Ѧ.�zul��j�{ʗ��J��)(��5y�b��7�K�"n
-<m&��;YJe֝���pg���u��toXJ"_#M$chhcF���?)B�g�Km$|-���`˶�a	�̥�0��"�]{l��wW�4�?�.��y��ŶHdS��3^�����9 �IĮQjGŮ���{��>>Cqu�3�OI�����9�� >k��|�����*Њ�d���	��9��Nܖ�^�����h����i��Ç��ަ������==���$����+WΎ����Љ�v��^��������ǧ�J� �٘�7�|fU\��-b���C\�
cY!��ܕ��+�ɴR��/� ֭.�:�]�2]�Ϗ>r&&%���	7p��V��5���;;�%a��\���SM=�:�j�.���{�r`�hg�q���{�O9Ȕ�h�jQ��UH��[���u�U��]��(wu\G�^��(���5�(0�NПGn}�!̮���k���С�1g���[Pk�k��5%����-6��w�K0}FX`�
�����6=$a�t���L9�|�*�k2�P+!W���i+T��:�~}�a��!��-6��;��]�o�ex�%�!T|��I�|�9!�~�l�Ȯ?�f���lһ�z�(oh:[��M����{<��נ�@�c��э��?'��OC���<ߺnx��TSD��U �-�c��¢��Am�rjЉ��E�$� ӓ�J�PYr��Ϫ�H�����9y�F��p%N^��g��۾���@̾ �Ňm�(�D������~�V����D6v�|&���GTD]���"WsNz�9��Eo���b���;���Ũ�$��4$""H "I����3`5!�"jYMAAI��^A�l��"�v/wr�'$H�@��Y�~��޼�����-t)��+�<}���'�^(�	�w��zh��+s���X=������ng��o_��B�X-��J�ih�`�5j�^2� ��M���2o�u445����c���/�~����{�u������ES� c�f:%���af�MR"�~��_lI5� ᐙ�����'?`}�;�abo�$y�޽El�P�|�t�;��Ԩ~Ks��� `�D,u�FQ�1��2��~\ *# �s#wl`�:�J���� K���h��2>0R�y25�{K����KQH�h�SH�B�,㊽�D]
���V��Q����H�����n�CJ_i0[��t�ё�?�-���[�k����*ZB'�%�E7���(�/�` �L �xN uZ�y3AUq10~�Dȡ>z���W�Oɇ)���;��~�`���bቚ��'��޼�)�-IێO��-�L)���;�#��a�Z�\��4>�����"Q/���[�/��d:u�#꥽U�i��bͦ,�(N��4�F]��v���L�� �~wQ�v2:m���p���NweO��Fm����ؒH���Y�;�1�;4weiG�c*��ys)�i��i'�wW�=�dƚ2곿����@w����~�Cl |l̃>���hĘ�9�_����J��������$Ii᤻ʖ�O��ǲO�X JU�@�4��9�l�F,����1W����V����`�(p�HQ ��r��}�XK �9{�d|�43�T��e��9_�3�A'�����3]A��fq��i��Y�fy4��9���u<��<{&�c�0��Nմc�CW�6�q(dB�T�A�P�D�)��CL@�0�ɭ�̾��.������A���z�b�-`�(���̷C���J�noN�����~|��O���a�LɅ�L����
(�pp���8A��X��"p&������wm�o�#�H-iC���f�&�A�,1g¾��IUAO㓸����}2�.u�6��.Z޸�M�eN-�j�]ٜꮬj���$/�kS)_��������	��'�ʬ��N�,.�g΂�@��%���bV2�e�ۋ{�M{��A좲�l��+++¥7�2�z�q�^vw�ݕ(���"��6o����Pl,[P�e^.#n(��f�T;�$EyP%��W�)W�S|1�%�*B���tgb���v����"�M})��q��EQ}&�p���7weo;���(�Q��KZ9��|G�9jSq�C�oȋ���BC.O�� ��6yx#�Y����\(��*VL8R�Ѩy���F �8��tj&꥾��R��/wI'��ݕ��]ْ���C#'�|�ӵ�$�9��+,%��E,K��L/3h CF��,'+$!>�H�9��Ix7��m����#_�ž��o~�ILw/m"�?�̘r�J--/bYB��~����:�k�"\*���o��.3w-G%�ܵip���ٵ}P�e�y�ME�D���
�{J�����6�+p͇|�f�V�=�ՎԪ�ؚ�����O?f����x�/��N5`6�9�$��K��_0�:;+�V��o�M{�"\J{�d~W�A�h4�$K�2Zϕ��=�3>�������1�c��SK�Y2�@�����[�Vm�D�z���;�O�O��q�_B�\J
�����>��U_�y��;:weuZ��c���e����;���M^�G�5FߣW�!��)(ZZP�z(m��_�.�o߇k� N�9�̡}��
�9P9K_O��&�>*����r�8���q�ks��ŇJ0��k��ccacfN�oL&;���*��:�����ݡ�k�7�ڼcn�n��,���2���=������� �isќ�i�5�L��==l����\�U���	�#��k��x�k_�F��# `	c��e�D)�ck�l e<�-F��1�	`(?ʑG�)�)TVa�U<t4�`�+Hl(�`�O.ty#fPH��I$Y���E�N�SUQ���Zُ��������n.�ó��,P��8�I(���wd$9��&M/��2{%%2v`�Xl���`b+!�W���N_���������`����  R@8"�d
\�N�!��@�*Q(���- X(���*���_X��0f�TS"�����Ͱ.U�C"�p:U�?����X���c
�C�rQL���ޝ.z�,��8y���+��FkP#��F'���[�cY��ۼ>\1A����B�B�%҇×'0L|�X�ҽ�W%�ȒL��r(g�˪�*��9�����Oy��ʦ=<wey,m \��qm1�b��߄��� S��$I��)�`55�"��MR�$���|{�6�&=���_�K+n����U�B	��<Kz���$9�X\��k�	���b�/	�,a`���deu�p�C&��kX7��B�������GQR*�5B�l� ٱ�t죩�8n=��R�?��;�#��� � ����l\z~N�b�:w늹Y9��� ���B�F~�q>x��'�k���^pd���R�|tB�"�^��x����q���n
Vv_~��g��/�ա����Ty��c�K̙ ���������OPu}61Bi��q�N;I/�ß��=���qs��N��@ݎ^��ԋ����ZƼ�c����z���a�W�����G�A����/c6��At!��2sT�9W��a`��Eem)�Y1r��gV3#�u�����'�����PY`r��\h��T�wԆ��,���Te ���+�EiB!�?,yl�\�r�9��Đ�u(�/�` 5S Z�x!O ��������7H���o蒒���!`�S1�����́%��U3��G�}���j��}TB'����	���M�7�FVn)S�>d5�p�揸$䡾�w�����4���pض��J�$�\�W��_5���@a�osXu�Z��^'��"�����>�DR�9�~qNaU��=	"�|Ľ�����&�Y�-)gȶ�ɞ�tI(TJ��n��RV]��n���X�?�-Y��R>�N���n����t4��bF�1򒵨�x$��ZX��(����s�*%��^�_����\�)Ja�M�x`��1�����;�d��S�����8�`�N�.A�M���oI�qSD!���īh&F��g�m��/g��)<�M������{0߯Z�r�kt�=��)�]��=;���=���N�sЎ�߿%����*�����e�?�l˹�7����.e�d<����7�LW,��b�~��Т��z��k��u�f�$��������	�W��))T#V)��7o�����Vݟ)� V]��������F�,>���Ğ�F�bN1�b�2�9Y:^[�t*ٸB��y=YRx
��oi�F=���*ƴqo���)�vNNH�l�a>�s=�� �5Ѭ����sݛ���|Í�r���tF�efT9����OAq������_�w���͎�Y>��� ��;����ڑ��_��2����-���;�5&D�~��7t6��	�1��*���R��Z�>Y�m"65s����4+%�`�ۡgi��2��h�k���1�F�P,3�)�a��A<Xuy��Eh���gh�f��	oL��"�� �KgŽ%��	+1�#Ade��Ĺ �eF��W�e6-Y�D��Y�����a�C���[�6a�5�4���G[�m/݆�߅�ϔ�H4'	Lq�C�>�Kp�1���J#�R�M/!j�v<Y��C�C��jוXF%P�A��p͙��%a��-	��~ö
�|����ZɃ�u��`���<�F9��E���l6G*��Ӝ�<9��+Gr���+1�J�A�d�	<�b�d(��>�,[� Ѹ%mKș7���*�����쬳�ed����\�
��Sx�JI9���@0]��9���s<Q������eIt1�f��ؒ���J3@�i�"兞AV�3\O�E7*!)7�뙉EL�"�z
{`��>������~�����Q��_���mTO�B�`�Չ%� ��"��G�fr�e0�� \cG�<t"�+L��	;��a0gtm�x���&�ʓ/�h�	)��H�����WEY#n����왂
�z��6��g]e2���#C�z����FƉ��C�r���&-�C`"��`bF�=�6.r�[���ݿR�K�%�.��	�(c^����k�Y���fX����ɡ��wr���K�����.%\p<��L,[�&N�Ϻ�NC�(�i"o)7s@��p�O�n���'�JI>o
s]/ֽ�Z�r]�!]����]J������׎K6*eZKR*=1����h`��� �*���U���sܲڟ���R�N^P���	s�5ZL�uZ߈���ҚKc���G� ��O{՛�Q�zDD�B�t=|��&A��,���T��+�!�����
BDN-r]�6�aزĦ���my郹����Bn��d|�}Yy�_��qP�Q�0]��X uEZe����n���8qr��Z`�����z�|ӻ�BF��qH���ԭ6idH�>�_����)ȲF@�6&�`N�] �@D?:&�U�蕚�G/�qջ����v;a���([L�#D�2��ZUD�c]���E��e\�̠�(1�(9��ɤ�3�=fD�b>��țY�I?����v�e[��f.�	Sߙ����aS�p�SJ�10?����f���U�t�������Ds~~\������Fv+3Al2�ػ�L�4T�@��9`M��u2��d��jPBDg�N��`!p���t � �X����ֆ$.	�65�5�&�u.��)�$��^��">�ߏ,UXu���?�/_ Ҋ������h�X��,C�D̨{��B�,��I�8�Y�l�K�,[��u(b!�~Ā���2j��h��$4""""�� m�"	����L2��)HRR�4�������܅!��۞��6���3Uy���F»����+_Yͱ�s%�~��� _sQ��O+�\�nQ�1ծ,h�k������t$�6ǫ��$~9Q�ťie�1ۯ�L��`����;)���a[x0F�'�;�5D�x��]��Gs�k�$�aNC�l$�Lr.$�W����
��k��m|G��[�`
Fp�.כ�:���.oS�kbZ�x}v��Kɳ@z�B'}E*���"�!u[U��dgf�7�p�W��]T�{�F���h�O9���e��Ѫ�}��E�K�LG���e~���J���c�G
Іvy��n��0��b�~�&�	`jʡ��v7���~�6���N��:!
R�Ÿ�-3U��c�=4`6�Z�������q�,R�[Z�?��A!dD9���4 y���☞�9#tMH-p�F�D9s��tC�d�G6'��
��`���iؽ�M�Z�*Y�������(�/�` �V ꜰ#O �2��������w�q���WS�&�4�2���щ�Ћ8C���30F܍��b������>����w����+�L))6F-���Eޤ�L<q2�q�ţ�w�<drP"�ES�.��^^C�!:�����p0�2:�����RR�9\����ʻ-�ʴ���N�}�~��͎���wF^��ӳ��թ���-U�G�UNB����ꮭj�s�V���z�"�;��=����{.b�zȰ���J���(�a!gH=B��8�!xY�M�tMrh��+H1,너_�`I�,�94Ϝ��T�RmAs�2����-JwmK� wm��xHޤS�,��N|��h@�I�������*��z
�W����M8>�Y�q��D�u#�2cE�� Y�II�����'�H�}lR/�3�c���KL9\ʻ�lD"Ӱw�9���j�RSh��\�h�\�D��ܵ=2ݵ5��ܵr���I�K��,���N�)=)P��)��s�6�t�e�������=�UO6��ܼ�'�y\{>Y�p�c{LD�i�Ԡ��N��[�1�^�.���W�.�{zM��*>k<!J?��mװ�;ڿUNB;wmwUND4wmi[H�mn{[�C:z���7i0d0�
���ʖ0d4��@��3��s�.+{6�?�/`|���!�a]yV�c���S�fR���\n��B8dY&�p��g��������;rQ]�[Ö�����Z�5�J�Y=k�z�}[HǾ@&	�-��o���8�:O����������*`T�Ţ$m�4w��h4��u�)E x-8��&Q�����7��M��_g�|ۘ'�}�Ζ,y*ic��iB�Y��A��x���cR�f�SyC�y�U���F���v�W�Y�.�J<1/
e�͑" #d�Q�ߛ��P| {\�eh`$	1:Z}�R����erN�é�I$
�CO����L����Em��?����ܵ��^~�
h8�Y�����ɱ�K�ļ���	"`W��>��d든���㐠I���7{�����:a��h�8����3��p���z�[
��	�av�T֜HuQrњQ�]�G�8�6���;k�`���`Qԣ٫p�Va�7A�Aj._TY�G��r� �c�\��+\t�����S�ٖY��S���-�eZ�y���z��y�9AY{fڙݵ�D�][��ǐe.�ccgYY�E����[x.3��5/�<��x�F�F�mL����D����w	�G`*,��_b�l�����<���iސ���"#G��|�<�~�ؘ,P�_w��`�>�E
yb�	Y54�v��A�vc��Z��^%���x��1�p1S�Yw(GigN�<�6s)_�$�^��%�s3�CH�p� |���wc�'�<y���db"�t4���t��wq�S�Fi'�'1�2}���[]����Ow3�(�t��)V�mf�r�'��aO=M��kj���4��Ŀ�H���VX��r6���V:�2RF��h�6f�t��G �� ����$&�'ǑjJ��c7����pyE����nz����q܃���^WP?V�~LOE�d-����~Ȳ�.���o��h���â-��X�V�@��m�ݞ�x�h;�ҍe�̥�xvw�g�IO�(x�Ǳ;Mğ����˪2
��q���-W��P&��,�H@&�}��)"�6R��Br���TI��1N�C���$r�#���4�=t\I�d�SB�B9�}Daqv�^z�I=6��)��#�\To�o���t����k;t��T�:e9K���+��_���?_�RM���8沢{S�I_K)�˝��Sy1�6�d�܁}?��*�'������U�ߺ�V�K|^�{%�?���}�5��n�&Ͼ�C�@��T�
��#\[VK�$M,��J��

ɓ&Gx �Ⲋs��4S���A�EZ1#u�Rh������aC�X�d�PfK����V�E��CH��c� �U"�HE���&�aV�tMm!��Py��5��C��
� �{����(�!�Ss�%�E:\���l��lT�Eɭe��m�m�����Es��mc-G�oKn#����r��挊ܵ-�ڭ��Ʃ�F��f ?��Sy��Bg}�qJ��,&�;II4h$�e%�7c��U"RsW��΁�{0q&���*�S�d�ަڜ��,O��8���	\5 �DƢ���XLa�٤��Su�� Qx���X{��-9$D���ި�A�)"""��H�t��1��E)R(�)T���Cd/JS�}���)�+�] W*���f��se,<C��N6{G������u���;ָ{k9�\�d %�i.Do�l�x�N��p�x�q��*G��|! �ETs�R����a4��R�x8�I���n�ff��+O�fP�@�:��<��J4��i4A���9&��:��I�	dnT���S�,��2��;�Ad�N{92�F	/�F_٧�j����"�y��7
���v���#��Ĳ�:�@H�ŷy�`�@�y���R����:.�	� 
X�}�(A5�\U�9k�YY��'�# ��'�*�����n��.��+QDA�Gb�2[TI���4?��
 ��ɬ����ޯ�f�L��Q9�(�h����ɫ�����U�rxO���Z�/�u�����pvľ�ʭr�F�c�yT�[�L���0*,�(f
hm��x��T��hQM��@�T(�/�` �V j�p"O Z��4 ,
�Q������5t�u��n��]':��A�J������_�X �_	���Fu�x����mkS���i""D�h|@3B�����`�E5$����"Ŏ8P �!���%l��1֐��<��@P�1��%	�H,��tH+�Q=;O�
>}�H�.�j|���;��A<�n}���ں=fϵ�W��庺s�^Ww����֡<k�"���2^���+�����M0TWW�Yo������~��j
� �fMo�7���:�� �b{��Μ9s�
��������45�I�h��
\1��B-d���5�S6�)���J7�G�J7Tg�k�w��k��%w���s�.�
�z�q����4�r=`v��9��N'Ӻ�i<:]�:�������n�v}x�a�r}��^�Ы�M���o�ؕN�I�¢���0�cGJ�ɋ�0��X�(|R�	W_[>��x�2�Q�9�C%ˬ��qݭ�KO��%�T���X���!+\�u�ۭ�(��x�q7��P�?��D�;J{�v��4�\�]���4����/q��Yy̨���.�J7�*j�n�]�g匿���H���PW7�Y�5��ө4
e������9�'�5�����m���f�Y���v=��O��?��Z�̃�����p/��MʎX����Jt	Rs�����"�x�(r�Eյ��{D������7ԳO���S�DD5�������tC�?[����V��Q��ɘi*����Q�]ql�4�p�*`.�cl�|�"���[Y�V4�N��V$��Q�'ʢ�!Ҋ�(�~�Fw:$|�=<�����G��K7xx��yxl]�6ﻺ?'(�5��－R����wb�	j�XVbP��d�7���
{�� r�C���"��Q�M�"�Ԁ������a��Ż�_$R,�RĊ��\T%!��ru�)�-� J8�.�d1�n����+��,nű$+Ԥ&WR�:eg:eI�ԺC�_غH<ׂ�[�H�/�o���y��|���x��z�9{��;Gg��]�y���3�>�ǳ� (���x��_ka�k	J~����=7�fcea���ؐ����Mq�!��C�_~�a��U����*#��(Ue��� _�Yb��Ta)��佂��Th������Hy�W�Jt��iE{=�dwq8�;�6�m�ٸk�Y�u�-���}��^��,S��N
k��7j^I���P���L�+ë����� �jj�
�m�Y!�P��x���IB�����u��MWvu�<�ϷN��6J���o$��STR6HQI�y��&�&������f�2DL�I7n����� ��E��ВB�	���t��3!Q8C�>]��5{-�g����w�\�8�ָk۹?ܧ;���]����qw�7�Dq�����D���!�����fK�)�1e�p5%B�#j��*�e��a� }J`i���C�f,F��1|D<Y�!nIҼTȕ����J\��!�:��<����֟�䴾{z�]�xe�;��g��P��21\h �~����'p��<!@~)�Ք�(���h���@�'�_�F���@��r�`q!���&C���'�W�o%��
L��Ku:�����3���w{x���{Ac��@�>��r��ʏ�@L�M��(z��?�һ�x���EG�.�TC谒der�X�,Gj��w{��P�`�Ӻ%&1�ۍ��K7z��n��{��R��_S�q���D)C#NJ2UE�"%�����120�t\fd��"�4/�"G~D�W�⥍�;����)3�,�Q�qz���0	���'D��V���d��}����ɧPW���ս���%晨HQ������s�Y���勽QB��a
����^"6�|A`<"bl���"^��dK$�#(�F�,��bDoC����٘Kw:$v8D�HB}�G�>��������g�Z�uz��<��lS���,R� RE�CǏ��0Q�ҡI�th�T�a�S"TP (xY��	�'?hed�f�TD=]�A�,8Z��h��M: ����i��Ȣ��Ȕ)�M�N�����&	s�(������.ϚF����I^�i$m��d��n��|'�w�<�x�� ����g�����MYU���$��C#""""IA�)c�{p�R4F���P�#�2f�/�.�Ii;�yVn�iU�)�j<4�iy�*�������3d@1�&D��r��D�,ܼ0Y����s���+<�SWuC�W���$�:QGR)֕��ݨzș���|]}���,��ьDN�ka$O�I1ZqE��_B@���?G؇��ľ����-M�˟9	� C���?O����v���"7DM�2�&��Bc�G��jAT��z?l[�&�E@�ks�-%ڳ�s){�;�%@d/��������Jc!���������-�<�<T�-ᬈF3��
����p'Τ�>nl�����h��E�z�����K�W�43'����A���~E��l,��*����i4�{U�>���?b*�Galr�`5K$��5tɝ�ax���	�.��'�*� ���(O>t�;��_�V�'E�lq�c�َ��V������p�\ϐ�Y�&wZ)3��	��)���OR>��Hĕ@'��(��q��(g�J>9�&���\2�,��0�W�:�>B~
�I���x�(�/�` �T ږD"P X��TAFX���A�y9q���V�2qi��{�кH��]E*�p|>�"��	>��j�k楬�q�=1��ڢXiO7�D� �[�m�͵���B�a(2��w����[�?���6�i��G�ZX��D�g�"�H�"Oy�� ��+�l���k��Z�k�j�ɴn�y��f�5Xmk�?ҷ�n�P���H8ɜ1�n��],�]U�e�eM�����e�yٯ�|NXmϲ��Ӿ�U�����)�o�ta\�B,	*<P��~��D-���)YA�$��Y�y� d&-dj�R�%g3dF�i�.��%��cl 0D�Q4$y"���tw�4={<���}�Ǟ�.�}�"�hg�%I�.��? `��w}����Oo_5餰ڦ�����4�Q����n�`���ȓ��RƛѾ�ba�96�a��eb�-��{.f{�9v��j���	�
��5h߇1s�o�N�x���|LXm��#������3����x+��c�G2��ef��Q���壟�����-�MT�` ��S�hm�$��T�.e�p�q?AB�T,�B�XȕB��z)���5��vAW�;zI�{;��z��i��9ٯ�P׬?�l}s���I84�P)�άE��]������1�ڇ	p|�ƨf�{M]/��kn}Y$�^Yt����۝.��:�u�|���O�ܳP��W���oc	$E-�%�����v�?��X
� �K�X�`PH�X:a�
*����q�(*���&R��S�)+�&?#�v�hB>���Ba��etT� ��ty����?]��mO�{�]�:}��:߽�u�&�:7�f�2~�Kl��J/����� �0Zx&>�q٢�C� ��dE�E�%dY�4�t�G�twH�{�L�/s�|�į���p���N���DB�����"�Dl�����6�x`�$�v�*�ҠA����H�48�@V��C�����)�̮��4���t:��,>�V�]@<)�ӣ�215^o����auV&�ƫ��4�QPz�X!!ߋ$������x��{�N���`^a�渾�.l�g��-�˸�m]ֱ�jk�_��iNM��>ƿx���#���rBVŉ������7AX�`W4N��v_v���H� ���m��p�6���6���b>AK2����Pq(�.pg.㼻�$��E�+ʢ¡.��[-V� XmyVXmW�"]<�5`�b�b�PA�ҝ���h�Bjsj��`0S�(���$�]�o*�w|��`���`����jK���
�-:�9�_�B��n��'(�
%\0\���ñ-&>d&��.��y&5"C+H�E��޺܂�������9����OO/��I�*��HT �쮮��'�KG6�eL�0I�(��l���,�r�����ÃՖ�a��=��Z�]���3���=�28A2<���1�.u_$���a����i�ZNmǽ?�SG���fZ�l������P����EY�˥���=$��d���~���6##x�J��=����q��%�4
���o ����� RId���C��-�g��9��\�����VkW�?}Vۯ���b���wS�����=��k=����υ�˟�k�Ø��E�4���z��z%��?��f#l�x=	�>���.�z{#��$_{�۵��= �/~?55��@��;K�q>�>DUe��3%S���ELq��-[���?g󙭭35��b!=���yh$QTTQ942�n@�#�3gu�%AV��0�&�h[R����`���:Ęj�;�ÐH�"Q��0˼�����2[e΄DE����b �[���ԓ��)�|$ �pL �����N��L �A/�YV(��t}s��7��e��J�tE5�n�:�E]��4�Kw;�.�]4����z��A�tYJ�M���0&]���˶�;�\��T����.��2�.�\J�!'��R]�ѹR���<��E��@�K����b	�LGp;��3Z�.u�s���F�J�
NRE N�yJB�;a�4�c��#���9OX�؄H$& fK��-qG��z��e���.��ڤ�l��Vjm
�b���$6�:��&)Xm�Z���(O�0�Br���Q5%մ�S;��_����{
>�~�?�F^뇟����u| ��H?�4�4#""""I����!� 1R1I���5��5��D��/�9�(�,��MI�&��A"�b�PqK�(6���(%�⳶)���T�K��zde�5Z�m������'uR�$��]C���0%'Z8���.��bC/�qSC!�?��m�~���FˣA�4n�A�1٨�Q��}1�B�u�d�g��![>���;ƹ������yt�:u��R��,y�^���=��di�B��#n8K�CD@ �IO��ՀP��P )<�]0ύ
:T��UR�F���S��R���A ߇SހЉ�T��g�8�[�k�6���K��4�) 4����ol%��$L����r�9)`B%S\�j?8r��f:� �4l��f��bC7���i�
�P[�?"����Ԋ;�b�=�\I[��$�"�px>Y���,3�1}q_�E64:�S�����9ڊ�(y�K*_5	7��=A�O�s���w���<��`xB6w�J�^�(�/�` �T ʓ\!T@ZuL�Ra�$���Du �����S�q-��Y�����/��4�89��2i�+���������x������������I�
��L���X�ټcu��<�ν\��(}y��<��4�y{j��odt�Ue
����!F�z��~`��2�.K�>�D�@�)!A9"�OFG9�G9d$��b�[�a}/�n����8/�wl�鼍���\Zv_�vW��` �㾓ɇ���.` E��*{�p&�`�Pƒ����|`)� �3@2V_��pm�C,��� U\u/{n��ƶ��|y���<�m�=y3'<�]����0]H��,	e=-(+!�!Nq����W�9Ea�Z~y:�/O�=�z;���#�PF�$@C��Ə�\���8i�5Ň��H*�o���_3�m.�~� ����Ҝv�<2��?���_R���ܫ�C�]�gG{y�����<2���3y�}'�n���)1Ԉ�
�QSLb�8�b�u�H�ή��	/�pK�U�����E\�p�LK<-z~��rA���T��Р�[2�;��aԵ�������h��0�X4�FbzAM������摱�z6���տ]�OǝF�
��g�AeJJj���9�=A!�ʐ XJI���Ƒ-3I|��_K	��8�P�s8�h�9U��Uŵ�,�������{_����}�������o��,�=���<�Rt���xQd�c%�J�D�B���ar]AQC�D��5�}��E3��U��B8��"D����1%	�)8�|f<�Ɲ�i���Z�&�xsr�Fbnmw�m���-N���t�֢}y�ŉg6��`*��s߉�a��~�������<������/sF}�t誷'ֻ�0��Q?���E��DI�*P	q��DS��tz*�u��C�"�$1�*$E���_՛�h$�����������թ����.{yZ淟�;y�e����0]O��7�S�d���",��TA��4;6�����nЀ�'P�8�,iv��#����w�	�.��q/;[g6xMa�������ٿ<�65.���x{J�0]	��M��iђt˽_Ҝ��(MUU�_m�<�:�"�;�n7��w��?L�;N�<��Pu8��M�.,�"F�T`(3ژ�t�I+����H0�	����}2�^��uxu^���ٮ���N�C괮��ɒZ�c�f`�%�1׋+�����u�V�S.�U��6����qn����К��X�D_ȗ~�^5XR�v��Y>�9/�zifA[�z�.[�F3��@�0wJ �4w�=�@� 	_���;K�Ƥ)iH���h�YR�vLۚ�1�cv�Uث��>�z�Q�|�U�,A2@�B=
y��Fbخ��&jt��V���`/��_�B�Zh������S\(��.�OC�"9�s�mhڀY�1x�U/�ʄ���
��8y���	�=�N���7?IH����+�(����	Z��LB��Dd���-Y�9�� W�:��`�nv��m�����v�s���/��)g�ґ���5[R��}/e��?x'_�S�|�#uI�;����j�bA�;^��m��3^�ӭTt��������sCQ�(*��$D��)sG�MPYG��h�X�fk����j^6�m{�sHX�mǶY,�6�
������(�λ�p�|Q�c���^��K����<�9�5gI��ꟼ�KT��a�H��O`�C^�T����ra0��\ʻې��Bj�W��]]�5��ȇ�_�@N�j�i�6�2H�.E��C0UбC���3|��9�O���fp���o;���k�y.�'���~�C�s��!gz֛�f���c�s���%��a�R ��C�<HI���i����cL�ٜ�lL�i��l6��gM�z��������i�*6c����TU��ӭ��U���kCd�ȩI�r���Q*�J��� (@sU:Tm}{��^7���`=��l�u���s�_5�	U�ߓ(r��.��,=bhRͲZ�\m�'�)cȘ��b��vz�n����%�"U��TU�g�n�{����h���\�']�D�|�7�PZK���-�2�T�:�t�n[��rE�z��5Y�cX����$�5�����HA�6`1���1)�d5RP��u����u'�����'��k,/��Z,>�����k�@�o��.L�-�!/�S Om2����PM	xҀ�u2rם�>�e���y�j2j�Bso�&�)�&E'�H<	?*t� ��QG~��]��A�l�T��p��+��j=%�l�X�j||�Eje[��h鸥�&*�����(�⺐��y9@��fG|�,�T�����NE�9����:Q�.�Y�K�t���a��}YԾ9���B3-� ?��9%]�ͽ�_(����&�ǂ(j�vzdO ƀ�w����nQ}x��T5���W�r*�'*p���!C�a��pV�� ��z��:BW_�_����i����E9x��T|��8��t��	���!K����f]Y���<��]��VLB���[�k{PΑ'C�F�F L��B+�a��:�	� �O^F&@Z�"�A���' �{+� �; e�V�����ǡQ�#��sM����4��5��,�o8|^R���������_C����l���B�B@��� �(�/�` -; �_�B`�M����WO�}����������\bԝ�1��.]>D!��&��L|A�1[�o�m��m�eJ2A@gO���i~��"�c���ȳ7E �駉,�ڹ^�'ќ�����J�5\��<�|Lw֯���^27�dw��稓9e\w�7ڄ�I����}��m�c+�"���!WO=KG�:=s�������+��+>��瓭t_��Jj�8���e�E�hq�v�R���}���ex
����o(G�͉d���F@G�yͷ���v<�x(�¬
��e`i��H�k��b�i�j*���C�2�u��J)�.�JM�b3��{v���[RB
]�A��)�G�{���֨�>Q�N~�7'o�f���~�ѧ�"�w��R� "�w�@K5>�
�ɧ�/�hN�r���T�i��$�I��z�*p�+^������	�흿�h�Ҫ<��R�#e��v��k1��HIITY[dՠ.#�T)�r�̼�Ļz�WI�Xi����ߵF#d�q3� Q�v��ܸQABJK�$>�3ghT}i�C�i�0,�x�iO\�G,�:
ՠ�s�"ji����N9]s�)��w:=�΋t�� ���<� ��W�K�+N e"g��*�ݿ\ի_�RDY�"��<�\����h���g��7���6�K�������9�:�!��i�3�c���ɐ�ê,�+(��Ū,SмM>_��bUb1��XI���@�cf�2��{�ٍ��F<}�X����J�#�� ��v���W�s��ж�m� P|+od��[́1�(r'E~6	z#��m_��~�X�^����|-8���@*� �+ �bFt�˽�o;�^1��g�]]wA)ľ����FK��r̯��Ωe_�x�%���Д͏[;.o\B��Q��V���s`���m@�F����\c��>���|·��O٭������B���wa��~�9~.�y��M�L��N�w/����c�G��Dң�x D�J̎-ڢ������֖L^j�� �X������T© ���":5����uz�iU�1�:�e����\=�w^dT�^qT�^qVN^]?���>f�)M�'�J��]�Z<��!��n���5ʧ[���<���k�!�����aB�=s�-?X�喖�b�E�H&��ޟ������~���ΧW�K9B�@�����d�h���U�P�
l~�������B܅����.�T�1}��,�Z�!e�!~dZ�+^���^N�8W�N���xS?|�O0��o���a�̷m�3��M$�k\x��qʽ�6�����i�p���������2htѻW�$��76�9|w@��=�8�,	xʷm�A̅7�7��D�$"��H�� I:!��(cUv�s5
�2���l���%���V/�D�K~�LA���I�;i�����9n�e�H�t�q�߃��}*���5T�B4��?�2���g�lD�0����!j�>4���>��YQ2/������*�KK����T�����²'i�t�����+Za���km�FF��\�Z_�b�<A(/�Zd:�&�M���n
y*(m�e��*<f�6�	��3'@��z *���|S��h0R�LJP��x�D�	⣈�d�[t(�9r��,9b�N�ǖ�F$1���ZNoN�uEG�P�`\�o���=7�)����<��ƖK�)��]e�f�'+7'N �ƕ��6L�*�9�������3�=���~��������,���:J����7��jy)�~�"�=s^�4ܣ�G1�p�!A��G����U�}�B���4�"$yW�Î�z�PDɿ�?qq�D���fV�v�iq9�#|_��75\�sVk�7�\�]L٠$]�#1>SſJ�����z�'B�FV(�/�` �> �a�@P�Mc	gn����Ϙ��}4^��}y,^�V�&���N�~�h�O��f4Z��:�� d���)OW9_�j�Xf����df��K�ռ��Y;K�^������p�e�{jQ��}�[�V����w�B�5���w��f��1�^�+��KwO,�L����ic����,�/3Pee��=��>�k���[�;Z��G��5�:Ѓ[�{�,�}��2��m�z��/�{~��6���}���W���N�e�����{��f���o����D���̬BC_��Ħ<f��z��#�-��(��7`�����8���L����7D��}QtÊ�${��RF�������<&H
��H��J�N@���Ģ
�D)+����r�R�J�&0^�ѵz�eE oF¿���p�٧�fu��b�N"��*V@q��F��2����̴zu�6��z5*�N�4��(�jTG��C�* �� ��u��^2��˳����/�F���FZ�Dى���Ⴃ8!B��$��E(��8iQ�N�1C6����a+�AT�T�4h�=k9��p�n֐]��ˮB�����LGd2����DU���D�	�ߘ��_��γ:��?�V�xp�ys��)�����S],��"��~�|�^�jr�^���-�JAP]'v������C����8��+�O��K��������7ݾ[L�Tؾ�y	­
H�V��%��KB���-&��7���~�*��PԲ-�O:i�/�����,��,��A�b��#�ӫ�z;�ջ��t��],��N���:�c֙������Tb��d���{�̼ �[���]2�=F�]1��^۸BӮ8n}5ʖ��6v�dc��w*�ju@ƺ���s �����)l`�?(�X�����,����I�gsm����gX|d;s\nkp��@��{���^�z4,~�������z���+�����9Á+��+��SCV��UQd�������Fݱ�>Ѷ���'���j�MQ��n�#6����U��H�s��/e�%�wO,����{xu��||ۆ�g���������;���w峌����w�Jrez�z���rN���N�+��ؕ�O����'zZ�������_1�{Ωn��­�����S�VI������)���'gs}\�L�$���_;��C,����!�
�g5�i���{PÁ��cU�X~�����O� ��?q�,����=i��k�D�b߻�~�k׊�f��X�}5�6
�%��,���մ�`l���˚^ݣ[~�����/ł6Y�3B|�E�L��_��s�*範��ʜ$��pR�����o�X��;�;XV��\ *�������n�t� ���nˑ���{*��q��0Ę5#��I�$�!G9F��4Kѕ4)��(|z HB��*��Kr����j���6��)1���V����<. #�lP,��{
�|W�����H�1���9��/�_ɯ���O��fJ>�~{*���d Î�>�k���zHגM���}��&~Ϧ����*3�
�L%3�Bu���ʈB^��e��w��7�,y]}?�+íIH����$ԋ�f���&wqę��7��C�R+�"���}��:=|�O)���q%���h��S���_ne�U��R*DjH�J�Cj*? \=�i�A0�ZO/%�ɣ�$���`�F<��#d��Aא��.�7~������~@!ɐ_欉��N�ʮ-")�K�Ez��i���s�y�r*�o"���.�q���>A)�����sdv�8o�4�ϯGI.�'������I{�
�q�������
Y�������D0;²�*���e_`ُ���h�l)�kMX��B8�1N	tꭑ.@�1�B�����y�]*h�D�g����?�l��'�cS3�n�&��A�e�[@磌<q�zh���wg�C�$�Ę�tG�׹ë��Ho�x3� ����
��KWح��,
+�c���sgf�(�/�` eA :f�<0�M�Ѯ/����CJ>NǮ�,\?��ı��Q��):Q���r���1����[n)S`IlX�������r�;ݣ�iSwe�	U~����|{� @�+����\ ���XY�:<ϘN7�?#��tW�~v��<��Ӟg#�i�/��_N'+3�K�S���f>�RT��1'yHu��	)���#��똆��u�����*ٴ�K��O7�
�+�J�ܕ���rWv+��,qU�x�O��#�'���Y�ߙ0O��N'���0ta0�����	���܃�q����J�U�[�:�e�`"��<L�qU��兞!�ܫ��geGU�7�U 6�� n��q�VA]
H�f��V�hW@,U+�ԪTwe�a���UX��bũm����rp��Ѯ�^]�r�s}{�i"/��7��	[�`����K��hS�����y����3�]J��I�MW��˨nn��"�*b}:���<�����*��.�y�����[���n�l��QWF��-@�D�#�J��3�s��]G�%�q��a���}�$���������s{��x��~+ we��.�üy�Ul����u���������%����?>ZW����\���{_b�y>n��{~ cϳٖ���z��i�zb�sr�����O����`�3r#��[d�]Y�;lG�y� -�Ǎ��<�w('��`kY�����Irc/{�vWv��Lٮ��
@��Vf��ߖ��0��r ��xf���Wi��ʢ><Ͽ�������UM�'��)�Q��s�4QF�!�EߗWb�(Ң2Lp�q�g���;#6L�<]����(� �&��J9[��ɱCQ@A�����$Ӭ�8T�I��UԪp8�CU���Y�e�/d��}q$sS�(-/��M��Qm��
�ej�+���l�؀(��{8g�^v�Jv��?3/6�M��zy�gJ��^v"��u�=�ղ�OW�0G����z{���ީF�nh�Y�|ՉM��~������ig���7M�]��}PW�@VP��Zq�WG�aI�0���L\�&zVv����DbY�U%�r�4�T讬�tW���*�~�����m����\���c�x�.��p�K/�ܑ�9Ak�$��@�6���J^߻��G�+y��y�� ��	�L�3�@��ծ��ʔ��Ω��[����oO*SS���4�d�w����4�+&R���Q�D;�0A��vjܦs[�,�1��G���<?:��?����}�{�ԏ�����$��5}B��d�s�K@�uFo�|��N5�?������4��~���b�GS��������C�F,��w�*#e�=.6��c㌁r�1�����ò��2��^�\u<3+#�i
��J�+`
e��V%`+UNx���w�e��!���#�$�e����,d�g���\v9�9沓��=��?��ߘ�6|�~������G}.�X=�CO�h��@�5""$I�R:�� ��D�I�$�v0n�,?�,"�@K,��ʠ>�N�	�G��c�Ȃ��#������=�.,ˀ�U>"��U�7�5BF�������[r{�=����eB��~�J��q|�׹�k�z���~���C����qĶ�Nq�U*DG����x�XE��]�hby�Q#�Ze��w~�1I� o_�KJ��V�kžcN�3�9I��K%0oj�ѥ��>���b��0����%7~l�4ۖ����϶u��/���z���˚)!S�(R�2����4�F�I�V UA-�/���1�*	#���#����4���S-�-ꨈ �g;�=�D��1�8�P�r���� �ݯ4�� ,�7�9m`��ϵO�Ok�*�Q
J���"3��1�iE�Y{V�Me��K�ߜ���$CO?1��u�dy�I��0�ïy�m�6Ӗ,:a7���R����F�_oFl}�F�}�����	�������i�nc���o�� o�'>y�]��քk���V���T��������0>�;��c�ď8聨�&��D���^�J��]K��(��KH�0��r��=6��E�0F1vhl�	��{8�� p�#{I���l�(L�{���(�/�` �5 �KTA`�I:���>��G��VO��E/�{L����������{6���TL!�JQ�Pi�l�	�)� � � �2Z��)�!�(Jh�T�j;�v��T&�?�o���5#���G�}�)�Y8#ي��%[�<�0�����+e,[[<g09J�麛b�f��3 )����<�UM�U���͏�Hb�N�����$�w�m�iȶ?�9kA�{�� &�w2=�ѹ�m��������, l��1�"&��_�]�;tS�#�ƟJ6�:�C{'�{����pT��s��4 6�BB{'>v|�{u��z�zS����@�7E,$�V� |vX�y�8�.o���Q�3���~��J7V�m�yI���$3��)v�TV�fP}�8ҏU��}V�:(&��U�ڐb��h�,e��$���Ơ{��e�s�J	������4k�I`���wx7��Q�)��S�9Ѧh��H5��'O|��	I�ͳ8�Nȯ8fs\5��AU�MH�`h9������o`7�!�fTs�>->�]]�W7E�����V����;��p��ӕ\�b=w=�*��t%��wKz�u������}��Ea��s:p�,"�i(��*'���'���m3��7���i$v�_p�$�BA�<�)���E{���r6����;���v�^q]X5�-�h�$-tz�~� �PN��=�vc��lt��r�6�ܚ��n��c��)��o�Z����cr�c9����w�	���Ҏ�Ʉ5�2�2��<���8uJ������$8���
meC)b]\]�6�\!��.��%�:s�Y~r�}TIh�Lj�w���.�p�Ӫ|�"߁<�(�8�kGNI��t�f��JM�eW�§�Q6 �Һ����V�lֳl%�VnU��[.�BW{���r�1Lw0��a\6�?��M�?D��)���	��x����N���.9{��/�pZ��B.wKI̅��Ƶ`_��˃����S�G9���5u���u���{�J�WA��'O�;lI�����5j���b8�Y�K����=Ĝ$� J��nE)���ґ�g����Rh}��y3�Q��nD��Ƣ�?^Z��4T EQǹ���s|�&���AWH��_b�;r9�mt�|:�=4���'���K�^uu��J��ܚ�A�+�����G#�"��f�3��Z?��հSq�dH���[��(N�E���8L�P��wsHO8�J��c4�9���0����QrK&��4��32���G1A#e��%�lW�_��������J��Z��7��kr�*�����n��^���e����/�,?����'��y19)��
C��ceC�g����7_I� Y��f��}~�SFJ4!�:�q�24�X!�\ߛ[	��12�e�J)8�h�C���q��v��C�9j���;yh��F���y��,�A����}eR%k����E�&��N޻���\Q:�4��΄ڽ�?��Ǒ�0%���8�����BF��`P�{��OxN	d2��K��}?d�i!4u�T�5-�w&�S��z�gU�XYf�<芜h;E��'�,D>�/G��}�J��J�k܁��]�W�}Z��1����AV�;p,���Q�-����.���P�B^���&�"tSn3h�u��$)����eS�%��\�����V��4��|�������7A�.�-QV(�/�` 5< �d?P�Mhn�sV�%�TU���N���q
�_��wd� I/��z�-s�<m����]���5B�4���2�JS[N+8{�<{b��boq
���[��^��1x����!T"�sTyxV]_��\.�g�$�VJy}�e�G����*��y�����>��:G�����&�C�Ӎ&6�l.熨��q��5<w�xDx�N��c���Na?F�Ī�ӡ�͋�Й�ۍj�U�)	/�qD���k�v[I�]H��l��S^=���}"<�g{q��V.�y�:�w�v3�ś�8|���ޏ6���h���xω���N�y���9�,��妊T~���"��s��#��M������C������݅<�;/^G��v����ե,��Ī~���rY���=̮����/?[�р��DC�@`z>}�;��nD���Ǽ_�y���,�n\\��^1tw�|Q���K6����3L6659��^�WPW)���$������w}�˪�����#�s�߸5%Y�,����QӃ�
9��2�����Z�0VZ��7�8y�x��**X��*�+(����
���\�W������ޜ��SN�A��H�F*��2���ήOK�'��p�Uץ ���dTsJ�����T���L���}����R|�3[�s���C�:o�e߹�xٜm'���[1N��ެ��d
�HSL8=����.A���əpz_?ߠI���G���4����!1�>Rug7���u��O�F��]3�.��r�=��C�;.��{Ƃf�<:��_2B��&v���c}򧔃��}��<�tE�)Sz��zYu������3ؚDf������<�=����_ *�w�ie^Z^Ro�ӫ+��&�eB���謺zpx�Aw�٘(��䤡9hR�y�A��E����<�_���8Rk��4�q	��@�DV1���T����$��|�[:�6?ey\��+Z6�6@�A+i�=�h�v�L�Z��D������d�;��N�T��r��c$��#,b9w��\�oƻƑfz�>}��/ֿ�X����	�sr)����fwRY�D,�2�f�`r��lbVN��*�݇de��W+���*�l��5�Z�n�h+//^?�ܻ3m��<{���Yy�Ī���2x���$Ҭ�Ax�x�&`��5+��Xu��w��ŋ�tc�{���`����������UPt��PV]Ѱ��c	�x�z�����t�AV��0 �Lٕ|ķ�ù�xG���v+
�p��8�5mT�z�����C8t�˜T��O��p������'v� ��lw�(Go�s
���=���c�.4Ŝt����kB��oh)��a�)G����펑��>�V����iH�N�e}�#����0�5""5R��B:1��0Sw�����2ժ?�B�x�dQF�,�.��������80���	� A4�no��z:�UiS{�bnbo�l����/�K8�M^�8[L��i���t�Ūg������%5[\���DD�iU��l����/���ɖ�0q.��~�]�"t�1̓1����PH�#	F�+�#���`QS���ik�R��5Y՘4�tBaD}��ꊜTvK���s�y�b�|�s��|��$8:����Gf�Ƚ�uCF�BuQ��j��@�Y�iS~�F����ul�5W@jU4�%I���v�����[@��o�x�vBc��9խ�D���N$"�����陓sc�z�9ݓ>o쓸tL���R`�5�9��yq�U�
��/�����l�Xt�!Ơ����	_#=.��	��� �$�m��B�Õ�!�\מ��'<����i6_~�Y��{�]�4�<j�� ��EA��HN��g$9n�?(�/�` �j ��2I ���B�0Ŵ�r���ū,[-[���	h۶��$�9�>'�%������x^Wt�Ϗ�¼ś8�rd����; V,�Ix�Td�a��%CoC[C �~�r��a�������8� P
 % �����*> |�>d����=5=d�<J<�Lٹ���8�`����h',�X�Vx����B�
H&�M���֩�#�ΐ���G�&N�no�7p7n��$4I��F�͘�ms� `j|���\���D� @�GsC�$B4�Ufr�H�@e>���X�l\n��%�r��S.���E~A�e=B� _��������o���Tw����dʧ�����������$�o��*ّj�_��`_5���`TDSN���n�L�V���pA?S�dP�����g��R.��S��1E<R���C��H5��� !y�:�J.�2R��;uG<R�d�	�G��"؎=M{��}���;���,���:=��YB� "�r��_�]v�ϼ�,�]r�� ��3o��}Dm�����#j�^�Y���+>D��뵘u��g�C������k�g�.
�'ja&=Rm�q�i�x���x��A~w2������I��y�XB��S�h{�4����!��g�T��]r�g�o�(qЙ�<���(#�� yҒ2R�n�+<ؑ��3�#�a�BE��F{#]��,�h��@n��y)���g�R�*��5	i���'w�i�d��'����S����7�2�"	�����7��Y�hvv��;[�����M�����3�W�]����u��v�3�y��=R����_����h<�=(��I�z��$A���2�"�RE)U�Cz'=�fI���9R�w�.Q*�$QsT1Z���~E��LQ��L�Ka��
х���½¹B���F�A�
�@�@�@�.B��=�Zj��@�<�<�<�O��Y�{�x�x=i�k��F@�&��vB!�`�^�~�<g�s�I��Lr9��;N猓�`A4��!7�ڂ\���
��( �N6ف��lGz:�tpɡ#�TH7pt��q ހ�����#�`aC?"~X?B�.?*�$��0jh����E_T����8>.>|B|K>�^��#-�zQzXf����"o<Ę�Q�k�sqW�y�N�N�ݺn��������u��BW�N�n���N��]�:,sQ� �ۚ[�-ʹ�!�/���� ���$��޺��A�)�1�,�ɸ%�Q�A���f�0H���lal�6����D-��5"5�'i:�h�ɥMAsB�r�w&t��̈31�n�-+Q�TVTT�S��L��̆���ċ%c������+�%�uؕ0r�X�2�� �B��}�|u�Ƽ.x]�r��\<����bE�(,�X���[h[O`�++�V𬠢B��\�S�6K*+�b*�(
Q8�� �U���5���jq��R���Nl11gb��ת�
��J��R5����+����)����ԗD	
$�H�Iy��F=E}�"T���e����"�D4���t�$�\�hg &��ؚ�0]�N0���χ�#B�Ԗ$��J5����IwIUI?I� ��H=�Ɛ��v��4�4�f͠��#������a;�u��`6�2�R4W$S4� M�D'��px�Ɓ��z�u��L�Xh(����A۠o��s��Ǚ|��s��ݙ�v�:/�7�{����y��33��lh�3��U���@�y�줬@\&,���\�rU����ܡ���S�P�P� /<�p�������G@G,�*�d:���E�"3� ��s�a�V�J�>Ɖc��9�1���Q�=�}���d�F!��Fl��Fc^#\��ƨF�8�a�����⪸O�&V!n���IF'�
0�����|�t�j�-�70�0v�H����E�"ߢڢ�b�bТ͢�.�V�(6*Zu(�)z)V)*))�(zI� 1H�7љ#q,�*�(�BbO���^f ���aa�pZ�+|"�.
�'�e�� ,	� 	.vW���?����Nvc ��u�Kp_�N�|�_��}~w|��sߴ��7�K�K����|��/���K�
zcx_x��U��$/�7�Bw��A7I��=����u��[]�.T������t���"r�7�{�;.7�+���fq��O\&��[�k�Ur9�R�m�U��E`��]�n�R��[/Z,�(Z8m�VL˥��.i}�J�d�I6Iv�l:KΆ���4K�Ց�����eٲdY���,Q�'��ͳ  rA������E�x�8�h	q�F��ЂC#����C�C"�2V�ub��0�]�*�6 l��Z�:���5���^��2�n�׫�ҵ�گX�X%��>Z�VA�+�Յ�ʪd���X�T�T�T�T����W}��U[T��EU��NU�

U	�L]�f�N*jU��D��P�L�L�L�L�S��9՛�M��"�d�'�"�	��ait�O��~~��{�÷�W?���W'����k�H�{���O��;s�O�Q�ׁ|bn�y��y�7ˍ�0G��:����o���M6�)�n̿�����c���s����������Gb~������³/��=P\G��'����_?���܁��M�9�!��G[�}��v���|�qn
�Է���_ľ���G;������'>��xp��!J�'w�{���WK�g�c<��k�u�$��,��8�[�����}06�W�o߮�x���[�S����?��W�;�W�6%��z�ű��}�r���j�#���u�7��=��xz���?#�����Cl���]oz%8�[��^F�|(��Ӻ���i@�����1�^�_?�K��Rq>]3�{<��h���z�o��oO���[?���U_���~;<�[��[l�߀s��F��?қ�Jz�%�O��O��H�z ���<.}����7��T�����&7�k����O̟����FO�`O�S��Jy����_���Z��-N�5�׳�B�v�7�i��>�g}\��q=�q���u���0>�?~\�������k`'=�=�u�(ހ��i��[���e|�����5��>�s=�~���|��>�����dxf��	
������ː�����FHx!�)�%������m�w��4���Ѝ�-Z�Dۡ���A<��E"�Hi�
���"���x����w�!�7{�ϩ�2��!nK�<��Q����*�7P.�+����W�dR�-2Y��kce�I����T�O��Vt��!�/^	�	��|f��W4�Ѱ���"y��,(�����������I�or���rh���l�"����M6Y֛q;۝��bO��Zܳod��o��w�IT/��p�?��CC��Dg/�(�/�` �D ���M@ڝ�1��K�
@��� �D�a�>����S
�L�����9%>�f�b�j�E3Q���m�A 0�m#dK�%I�z����:>�6pM�2	{e%�2	�@�e$��6�8"�r@��P'O�P�c��"v��Y=f�<��5j[��L[$;�X��O��fm��9h}�A�ل��;��Vju��#�z�bV�"4�N�Ι�9�YҼS���������)P�	ب[�[&��ig3��mh�=����h1�����:���βJ�C��ŎQ&�X�c�H��T���������b����L�����
��q��:c�5k5��uP��"��Z;�ՙ�:��`��:h���Q�h��x�S�5p�'j�%ZL����Y'>C����*�_��}م��'�{Y�ͬϻ:[m��Vh*�暎���z�k�r-���Y��6�s��E�`���W���O�ae�����#l�CϠ�ij���JK��2�b9�'8e(�O ˔��	$�F��|�l'��e�|Z	4rX9,��JK��R�ÒvX&9,q8,�K�1�Tx�*yHy�'��5(�ܥ�5J�@�mTj4i(�뒆�<.�&��D�R����D(��bWs8���7Qj��p��^��el�����
h�i�����kJu1����<���9?�lE�\5X,�<�6J��rh-���8,��L@+O%
C�/QF��B�0R��A�7d&�h&N���O�ī�l����{��(�D���{�C�}e�/���e������ֲM��?lF���b��zn�E�5�z�:�@�g$��h"��R���n� 8J���ح�X�oD�����s��l���D=��⼞%߸*�� 3��H?���\\>!�\Dߔy�;��L�Oe!vj����%qG|e8����yP]��+ļ�[a�h/�z�j�ק�<�A ��vR��(�4��R29Hk����P�l�2�Rh,����2��l�7�>;���ȷ�C����R��X�!tI�Bc�D���t6��I�����RTuWz�ǂ}I��,[6�%q�}t���.�h�k@�,������
���(ųD�}q<K+�g曥��ƍ�͒�qV|��Imo1ݤD\�2�����A:���#N�V��a�W�qW߸2�'4Z��!���(�E�^Z�\��7˱o�c�%�gi;J�l�.�l%/�
}(�=�,B~\�PP�g����i��Q���|dp/ܤ7ܤQ'�FpR_A#���1��e�=O;��j��Nu73a���B���]�v��[�
�,��]S�����P���;Y'[�����<Y'�������:o�ƍ������y���]��u�c�u1v55��v��n�T��q#��ysw�z�u�*�ԅ.�ns�݌0��v�p�����jj�Fo�f��1����f�&�U3v�03_kdp���s��@��q�$:�;����iG��p�!�K��1N����=�������L@���0��E}�lRƺ��o�0�56Ƹ�H��+w� ߍ�Ͳ�QT��IKQ��SKQ-�ԃkztM_��O�D΁�/U��g��Ki�3�j$��@��tQ�g��a#��)��q�Ȍ���H�$���)�$�v�GÐI 4)(J�"��������.<�x���H����&'��]� �� 	��a�J��[z�c��:ǜ��t����bO{��I�o�UhK��U�c�I���J�(���[� �vh��~>�?�I��1O�`2?�W������kK�����`���I�HR2�t���n��G�J�Xu�8RI}I�����A܁r�2�_&,6x�!�I��3���å�>��3B�8X����|�i[�7an"��x}��ۘfS�|�n��2�n[���
�4��[�/��ï&���ì-����F�Q�=>ov�� ��o���k	�y��ā�+�	�11���znN���Y���7jN���9�����q�E����U{oGá���c�t�?����gl�ɃG�1휗�I�k��+���7M�5?:>v@��]h��az}��1�u�}�����5�f��������۪�$aY�=|�(����z�:@O��&9��\�1��m@��%�cB�9n[��1��MU,x����~���9��,�G�$'�������Z-��M���?C�	������1#U�K�R�YuU(�/�` Y �|'K V�I�%���[���g(��y��E,���4��h�c�	|4Jˉ��U���vGàg0e��k�Z�Ro��2��Tq�Ix����iw�m:��x�����	Sc�D���} g�\
rY�^���MNȜ����Y�+a)���͙����o���z�c����1:����n�:,u�����:2uyu6ם�@�]�g�pg�pgk������;���.��<�/�dQ�^�˂�.x`���1������|.'ϋ<3ɓJ��q;鶎����q��$��Iy]�N2��K&���;��&�H��1ULu�6T�R�G}�I���F�>�U��?-~l?(�~��0׼S�)ݔF�<�Ȳ�d+���fe���*�J��ezUC����@G�U�S;�fӬD�������[��W�Ѓ�tSa6>�8��/�b6�d/��+�0sg�I�B�Bb i	�T�$�4���H\�&�	8�4�=T��V�Զ��rP�jU5�+���H�W�4j��S�}��������f�y����d�\Sne%�Z�,+���V�S�T��H�54CO��^�U����Rzjg��4{fǬq�k����y-�r+��O�#���u<�4>�y��ql����b/f��Hs�P��m�^yS۰M��5M�g��i�f��fi��%���3{foy|[����^���|�%�����Y�f���յj����yU��)��ɴ���g��U�L?�\Gh���Ӄ�ߌ#�nE��3�O;˯P΅v�<��^v�=����
n�<�)�-r�(�VzDT ��?�%x
�����9�!��Q4��@W�B��[�2��
DO�&P�j�l4��C��Ǡ>��	���8��t�7]x��@���|�}����-z '�����Yh�}�9��t��n��+g��*��n�T��8ۅ��;�[)���-l�Z8�mca:��9��rl��������X(��ub�X7��Fa#��B�'섗�&��&�n��2�#��Ͷ�V�k��%b��$�f�p�5]�"lf��V�4F�3�q����}X2�ÎYn����Y���wX6����au0r����as��e�,�n�a��{:���7����Ov�ղlþ�5֋g�:W[v�JY(���`l�eK���2�+.�KVl�l����[q�E�^۵G�k+X#;�)�"k��N����U��|�:Vi�6�S1������~`5-���2�O���X��Y�Jq��ޚ[.�]:��.~�\|�۹/�H,��׬Mfm�am$kg����o���]@3�L�}^�G/I�~��Zb++�����F�/'����d0���M�r����f�rv���6s�p8�	p7���bF��g���_�z��eNs����Yn��_��g�2��в\=�1#��&'1�p����2�yW�p?ه��f0���Nl�2+�2�2P��ܛb%�%��@^.�6���Vb_�M�L�<B�`���D=>� �P�0��a �
y2,�rk�]y@��]b4�b21�%p��8�<l�}��$i��#ȴ�����!����lҤI�Q+e �^���$ڋ� �\�
2�BXH��H�K<@@H&��h���T��I��Fҏ��x�D#��C\�$9J)��t]@����l�%�q��2Z�0^�Y�7�QF�/�e ��?Gz����)4V��%�1��[�����I��ިԳ�<��fv��������ĥ����*��pc�9�VK'S�Sh��d�9�F Шʪ����V�FF`4��,bA��U=�����kFkkPN`pm��ӈ�,j�N!����C$��U��Sh4����"V�iU�@#c�iT�,)b)ѳa2O!���kI��Ƶ`1�2���h4~Q����*fd�:��-�U���:׾�Ŭ�WX�J*ϣWX��k�q���3�6D�)���!�����������5��),Su�Τ �S ���G�$�L#OkPc�>����8�i2ҤFX
kԑX��,�e�Sx,���CǑxE�Fը�m�lA%���p��t����P#jPtV�65V�& ;�;7|7Τ�Τ��Ԇ즐D����1C���)  @CD�H�Ոel�����B�H]�pb��Z2D3�e���PB$�����x$�u@q�즊�!�� ���Y�!@=�.�S�Bk#�dg_Ln%��y�)������Μ$Q��WU����>6ܿ���؉M�:�t/�bl����\�����|3���o9ԍ�\�z�@���n��@o,4��@ԇ�<Ԥ7�w{��`�}g�ػ�e���-�w�ְ7�-����m���ɜ�S����~����ؗ�{��㏿��o�W����DN䷐����]u~��P������Nz��H��� ��>�������o<���r|Wa*|O�)|ә��;�;	'����}�!|���fl�������7���f7Sq�[��wc�C��A�f5�R,�wG���N|s���N��������4F�BDHH$	�i[���q:���4XpBdc��Eg����O�9�=�W1Jx��a�G�E���)����lm)K�������J9U�4$a5-%�A����:����}}��?���&"��_'���_iByj1)fWj�e%EìE�H+��Z���>I\>�$c�$��8�m�B�Zt��
璊�NJhre��	Q����������V3���I*n��YL�2��"?PC �u�R���4� k�G�$���G��}kpjYeV��b��l�W`<F�c� Z/&�;�F��MJu�*���Cm8���,��Q�(�/�` 5A j��M@֤!'R���k%g�Q#���%�X{
�ʹ��Ý��Y]�4l���mL.4�@VSr�������U�O�w�f�@��2���a�����S݊���p5��<�[|�Y?�;�s}��8�w�ͯ\q��q1n{�i�}���ڕ���|�_ܦ]ͧvd��@�s(���dk�p������9ǽ���v�mn=�>���q g1�Nr��.^�X��s�ӷ��v��f�<�����V������9������_8q��s=���4�r��ׁ�0���}λ��,���^t^�dnO���!n�lC���9�m7n۹u�����͹�x�o��yx�p�}8#m�T�yM����]y�z����G4"Z�юhZ��U��)�S�'3%0iU�R��p#̮jQ5��M͢j^@�F���̴�����V5#��#����j<��d��i�V�\�\S�}������|Q5�益uz}�ZS�T�@%F�}�Z���[��jQ5��	�Ѯ>�/WSq��}m�I�4Z�JQ��h�c(
Es�AmP6��K��3����u�6��*h7�&���Ec&�Dϸ-A�0	J�fy�.Q4�D�(�EPt�5�O��LgZ�#zD��5�T�@#�/�@�(.Rj����Ba!�i�h��b��J'�ɮ$�D�)��2��M��LJ f�Q��H�����kY���<x����G�HBq�$�7�(�r��P�`���,@
�1��|b��.x�a|�oX�tL�H��6��7�q�r�30�ǰ�a�f0L��b�4KY�G�_\�[C`.�b"�b,�)�b#���(���8�In��C�K���X���C�`|���Ğ10���fS`��Cld ,���B��N��x����R�aW�1ǌ8��8s�ɮ�@�aw��7�{�c{�F�� ɍ<���/��$8�{��ρoOb�i��#���{�ރ��Dr:�7+s������ֳ��Le=;�矕Y�z��1i�t4�9��z�B=G���P�W4�'�S�	H�8�e=d�٬�Ok�j;��.Em���'Iۿ�]˶g�v�wx*q�[��ڭ�"��m�H6�f�H��֊��3���Z��"ͬ��"���F�Vk�O䘭Z'R̊�&rj��K�Y0�%�l�%�j��.�e�H&��b�-�e��,��>��>mi�:�S�;�Yö�=��*-R:YpE�	�Ȇ�Fk�d��GI�>I�,���~	[�βgu,��[$�r�Q�Q;�@~�
I:JG����dN��(��= �(% �h�%5C��5�?YFɨOZ��²J�tGR)�
�S:�q�F��B���K�Z�ZT��q��]~�'�O��K���x����A6�����x��6�������h�}6>�ͽg�uo���i�oh�r4�͝K�4��Ʒ���P����Yzg������V���{��S��b4���4w,����՝��OQ݇P��Tf)*s��A�e�x��.I�?��4�H�h����_��h<��4��@�'�x	4���ND��ۍ4�z���Ds��7��3��/��+��E���i<�C�4~ ��4�����v!�=����ۃ�v ��Go���w2<��o'û��2|��^%�SI�S�{Sƿ��+d�
)s��� e�2�(�d�d�P�����x8,��eβ�d8��㯜{�K9��źoq��G¹��ܙXw�Ҩ�&5##%)�����=`�@�t�8C%RRXTTH��`�T �XȢn.q�jJ�:l�0"U�����@���쳷������T�o����I�T?Nᡓ_N��Q��#2旚��j����d7򁞷@�ߓsJ'A��LzP�	(��8Ey��/���K�h]m�y�;��Qs��;���(M��E��T%�B
Ih̓�-"U*E��,��u1�zT#�/�����pj�x���W��/��cƾ�rwa1��z%0"$V���#MQV������9|�����}Y�J�y͹1[���:�����Li�< N�b��;RxL��>�o̓��Z,���U4�PZ�|��a,�-��(-�1TR-vp����(Ό;ݓ��k�*&w�`�,��l$s(�/�` �Y 
 �,HPN��S��7i��I�u�d�}~|<�9q 
06@Aq`
���� �x�x��}���p�2>�l�g<6<ɽ���Wn%�T�A§$\J£$\I$I�H����yp2NÃ=x�z�>�����pp9ޅ�c��`����C��eq�v�m�v�f��HTۈjQm2՞��c�C��T;L��T�K��T��jU�I��T�H��T;�
I �'�����R{��yR{�����C��%����PjgIm,�}%���6��� �����Ԏ��JR;Ij#ImR�H�5ȩy@.�rh�;��<m2O���-���<���ݧ��i���p�r�vN��#��8m�v�=䴹8��3�\�q(��SM��&�D��#�~�I�ɤ�d�Sd�k2�4���t�4�� �t�L��KZ���s���q�E�8_Ѣ�h�mZ4-���H��qNe�jd�gd�ad�[d�Yd��d��d��Ȣ�8���\����g����+:�g+.�T����t5R��GS�;_��U4u������j"M�'�1᭄+�S�Z�L}F�#So���H�yg4yg3yg(2�y�ޝ����;�ܝ�\��ڊ�3'��VU��q|����6U�sʚ��N�H�Q���wE��T�M��T�ST�k��4�3���L�E��DY3Q�J�5emDYQ�B�5e�CY�P�e�:�����ɔ�e=��c(k1e������"�B�^�H�P�S(�(����	%�K��R���4���H�P��iJ�P��Dg)�"�h,E:�}�H�P���u��-ȣ���j?ou����[-�[��g��g4	���j#�h<Ώ��e��c��CpF_q�)pT�ŖS�%��D��(v���A��b�P���C�q(�ņRl����{�b_��Gb���`$6���!�yH�2��%��$v	�MBb{��$6��Ab��D;�� ��؃<l�;�����f�<�$���>r@���s��ͅþ�a�q�8�6���]qq=����'���������������8���8��-h�I�4>@�W���8#�p2�C�y�x��w�8����q2�A�;�8� �d�H��8 o�yq^|����xq&/��œ�x�?rF\'�Źp�+\܌�{���8w�@pqU�}4��q7��i|J�R��8�Хɥ���~2�'�I$�t2�EƟd�I.��-��-��-��-}��x|���m����-]�[�����S�?Qx���7	w�p6	�"�k�&�/$�����^$�U\��;��w�6��R�3G�ά�;3�#��l�D�BD�>�C�e
ϡ�
Ǡ�'���p9>'�?$�����&	� �$���%\ɃqJ�N���(��(܈(�L�3>��
Sx������*�_PxP�L
_R����g	_%<O��H���%|Kµ$\(�Y�%���T���f��S4���N��h��LSC��N����V��H�ڈ^Q�B5E�CQ�P�e�:�����dz=C���:�^��u�^����^Wi�JUO�j)U��1��E���
���A�f��%U�@����HU�x{������ꤌ�ɸ��Y�$�W�#Q��qU^���v��ڔ��$�9�ڍ����k�j-2����L�&SS�����j����D�C�u�x�!�5䵗���-y�%���:K^c��+ym%����y=%���u�T�$U;��dj
2��Z�D�$QG��!H�$ꠌ3�k%y�$���5y}$�˼k2���ü8���^ˋ_y�^ʻn򮃞jj%/��?��qqB\������|\\�.�r��š�c<����R����wM����e��M.��p��8���Nu�Z�K텻��]c�T�q�ap�Ÿk0.�C���[pqܵ	�r�\�n�}ܞ�p�pu�s����z:��>�����POo�i-=-��YzKO_�i+=������!y�(O�������i(yڂ<����N�y���ӂ���^zA�yA�yAK��6��N��N��NS��V�䞸�f��/zt=�M����W���������C]����t�PWg�j,]}������IW��	�����<�O�����h5�h4��3r�yt���<z�<:�\�A���F4��f�i�����-��a���_�]��4;��L����F�]����,�W��'���l/�=��[2[Kfev��ƒ�W2�JfS��2{JfK��(��$��d6��f ��dv��M�e��^v��������l:\�W�e�q�]�l,\6�m���ⲇ\67�3���>�zNM��i75ͦ��h�5m���Ѵ���������)5-����45-@�\H��O��O���4 ��N�6�i:�ڍ4�E��"[W���dk*���ZM�~���d�
�5�z�l-A�y̓���4�h��<���v8����p@��K��3݆k�3=ƙ����ً�s�D�w��uݶ�mS����4z���nzͦJOQ��T�4UM�6S����Nt��n#�m#�MD��t{�n��v���0���/ݮ��)����(ݾ��A�f��%�F��F�]��t;��B��~�O^'�v�׀��*���vRiS^�I����5�Z�TڊT��T�M*ME*-E*�&����Pno�m-�-��YrKn_�m+�M%�?��)�-%������v�JW�JS�JO�JK��Jr;In#�mr�H�y�ó���4�h�ϼ�2o��ۦ�m��&o;�];������;��v�:���p�s8=��pu���n�m�qJ{ᶻp�X��1�����m�ර��!���� �g"n	�ZU�}4~�x���kSS�)j6z�F�e4�E (�/�` �Y ��*HP�m���of��m��ԍ�?K��~�^Q��T�g}�K�I�٢��k��z��A����lj-x�MB;��H�S�����8͉3݁�ˆ����� g: g���"5�HMR�o��E5�iXM�j����j�t!MsV���ڧ�)�j�3OM��l:����Y��CM�P�1�4�Y��4��(�yԝ�t��N%l������H�^$l.����$a/�MJ�$�"�=��3��B�w��2�5�z�Ma+A�I`C ����R�Z�:Ka�P�:����k�u���@�d��1��皊s�Ĺ��-u���u*[#��d�[������c`�-�5���C㢶j�-m��9䢺�
����{�|瑫���9�9�9*��"WS�o)�E����L�j%r5��K�6"W����7��!�Z�C�o�w��!�2�[J��$Gm��.��䛃\�$��{�|G����m@��Q�7&NA��A���Q�p�!|�p��Q�:�'\��z���q�dpu��\��W�m�)��
�O�w	��S��(����'�n��%8�5	�� WW�����#��|;���� ����S-N�p8�������m�{���;��	�m�{S�F���v��ӽ��;}��7U��F�Q��[�����������7]-C�,�W�^�o+}�P���S#��������Z�]\!�4.�Э��i U�G��#U����H�R���������f\�0�R�8�]p����r��{��NKq�
���{O�����w�T�{ W* �!-����T6U���������i�l��FKU�o1�����,BO��t��C��I�����fP0����}2{M�.��1�-&U�I�]��-�B�$�f�C��DG��T�������`6ڄ��@�n��3���U��l0�����j��..��k��S݃#z�s�ŽWpo\vG���c�-�9q�p\T�����ԡ}�z�f�i6O��R�"�����iv��Pm���I4�I4�I�/Rۋ��"���v��^�ڤ� ��P{�S�f6�}j�A4�A4A4{Am%��Owis�U��:�Rk$Nך �sQ�8+���<զ�Es�*i6P����?�f��yM��IӦ4�F�\&M��@�I��d��s���"{�"��Ȟ�H�Q�2�I�v��M�5��^��AH��iRI�>���Mʞs2[�L��4�iZ���������f���~��av
M�i ��<���&̾Mρ=Á�����`�f��00��<y�<A����"�4hZ4f+��$hz�w��휅��3�����8��8�?��>�4�ഷ8�Z��,�t�4δ��*8��8m*6
������:�g).0��X��U\j��R\j'n5 n��m�ij6M=H��B�i�4���Eh�):J�4#����d*Lf[$�X������+I��$5�$�J�zB�ZB�:B�:%I��7�LB��$Ge����9=��2��*�9= 3#I�"�Ü�ʃ�9u�� �h`�$�f�~��v��n��8H�G�Gj�#5�H�9R_�T�#5	�S$�*�A��\v.�Z�0��bq�[p�+.eťr��S�ԉ�~��j�# �6���J���Uت�@է9eӜ�*HNӐ�FIU��"4�S���A�(�S��I���v�$ZLn���.r{�|�$_3�� l�$l#�C�>H4|m�m�n���0p{���D{�m����¹����!6Gt���~����Oc�!ZMc�)�<�`��(uAC��S����k�&�rd�m��e�4�zL��?�ɟ�ȟ*�=E�����n"�K�;�|�o.�."�C�;�,K��B��B�z%K������R�RO�RK�RG�R�d�:yʻ�|o��$Y*Y��sN�q�M@�6��.�?��4|�oA�T������R������,����������i0x����o$���F�{|���*�F�!��	���,�,�,u������7 �N|�J}�Ju�J-r��\�0W�˕�r�&�JE¹>���Ž�p��*�F!� �>!k=�u��>Ys��+�m�S�m*�}n���#������(����v�^��-@� k$���� ���p��^ ��m#�6n{�}�۶�mS�XK�X;��m��v���rt{�n��m�Z�n����m��*�&���d�.���ڊk��N��i�*�Vhl��������^dl.2����$c/�ؤ�-@�F]�A�n0v���)�}�&���`�$�Z�:���s}������q�!p�	p��������8������j���)��Hm1R;Jjk���6��F �3�A�j?��P[��P{�.��@m!PԞ ����-N;�Ӯ�i��ep�T��N{���q�P���݁#��M���i�i/RmD�}H��t�jǪ����D�޺=ԡ[�.��vt;K�g�vՆ�R�zM�.�����0���|�������g�|���� �/����A�UKMY���e�4�5��G�An`�`0�/�d��C�Pkq�ap�����8�(���8�Nk kWQ�P�)�A
� ZMQ�iД�T�5��L
-&Q�I�]$�-��N��L�� d�#���D���c���f�m6!j80����6���@�cPh0(����q��p����A��Z��8 @1�r�����X{c7���ޱ�
�ӡݷ�$�x��S��H��f.P(���g��h&�0�T[��a���	m$��5��=�P�sc�@��w"kuQ���&Y��d�Y��������s���L�6������6�@��/6�����D�&=���aD\9m0�dWI(�/�` uW �8)G �:I��IL�Qs��,�lM�yHq��~�$=`f;H�t�'�B���6�<�¼B�|�n��R�Yq�LFd)������T�s�\�?S��(�<��P����g�X%����T�U��*�d�T*�(?gƟ��8+�y��H֙��m��-�<lA)Vg8���չ͂?���,��	��OfË��C��]>̆��,���e�cY�Z��_e�SY�S6�j�l���G������l|�d�)�x	6>��du>�:Y��6<��������ӂ��>6��Ꜵ�w��l��u�;��;��;˩�q���:R��4���O�x4/�:���a
���GÏ��b4<���R�P�
މ�o���(�	�/���(��oD�Gi|�'����CTg!>��@�Cix4���gR�>< 
�����;4~I�uh���'i<���tg6�����YM�&���&u��:sI�[	��d�W	�I�����S��)u��ᙒ�%�M�rf�|����e��a�c$>f�v�s����s0��3�l��8���❩~����[��u����8~l��l��6�k��l��l|
�Ɨ�m'�ma�¶�k�f�f��e�6^��c�x���`�l<�����I��D6�m����x����Ǳ��[|K��*}*�.�Y<�x��#��)���j0�j�J���:גn��N�i_�iG�j�J1^$�ޔi7J.���5ސ������%�y��yɇޔiD�a��yKzV�U���.N�~.�~gBg���v3:z��Nf��n��x;��_�JC�r�L�����~�?e>e,�{�w����Nfyayay�Z��,�`��/�;��}Ⱦ9!�]MyS����y��h���蛫�o���>Fy��s)�A���w(�] ��IygJ����U��C9CY��\e!�{
w3�r
w6	w�k�j�i�:�U�+�K�s�N�\*�8Tf��8�p�44�^Nó��.d�5^M�O��u�9�;�;��g{w����ޏl�F���������=i{7����7�_��i�w��8���]�&���ϒ�~��N2�H��#�(���l�n{���+�݊����~γ��V�q�����~>a?���������e?k�g�s��Le?O��IV��g���~v��@��n?��Ϻ���@�9M?���T��~�@?;��M���<�~V����3���~>�����(�̤�}�g �s��C�<&�+?���[���d�U:U�J~n�j���A��S2m���3��9�߰��i�ʴ��gf������e#���ky��-�˟�8I����1�,f�v,�0�"8��$se��I%�%g8�s-����U��4�$��T�9���Q��"��P�Ûr��e
���>�5���̻!�p7�y���C��Ynf2�c^fNf/����ͫ����2gcނ���!7㯹.�]�Q�_��Q�a-q��L�u�K%�8��0�kI��و�Y��<Ư0����{�Y��\��.	�[2ЫRЩ2Ч�����g�a!n�b�weٽdٹd ��s��s���M�ďr����l��d��/[q-'y�\���,���;�l�T:T�%���u7���Gf���Neu�JB����%]**�(�ûRʹ��]��oID�J1n�d��2�ʫO��J��9�׼�gֳ��Xп�v�v-z�� �po�c7��1/3�����\���	��w�ث����`��_;[�,�^�s3^�]��-�=�_�l��8�#��wV{q��ɨw�se��I-���K�Ӓa��CsVI���;UN}I�p�D:�T���"�ġRɛRǏ�Fi������?x�wܐ���<�6�9�mx���gsf^c�����|��,hn�\�e��qҫ����ֿ�l��[0؜��̙qkt9�k��X^�[�+�+���l719A�Vr��Qё:� ��|�%�G��F^����6�$Vr ���p`�s�pZ�X�d���d���ȵ�E�ڊ�D$��_��C�����fk�<dٖmI�z�[��!��;[C�Y;;C�-'�윍!��'�b��R��Y҇�a���êI��M�4,�&�l{&y�[3�f�l�,�e�+ɬ˕]��V�[Vj��-�$�%�Ir�
Yj����?VH��oH������Sz��i��i �H)S�C
@�7M�2TM�2M��y�~T��2E�d�Gϰ�����wT�a�qS0]�=B�\��~܃ڠ�iP���(��nԍv�6�F�0
�na6�F��]�YX��Q3��,({����5A�0	J��yA�x�vQ0o�-J�;����h��+zE�lE����,��T��F�):E��^���R��FQ"�D���@��Q'��L�(�8fL/~K��b7)C^��&9p���Y�ʬ�b��J,o��v��G��N�I��$���2���HB�d�'��./p�̑Nl#����93�V�K,g9S�7�yr!C�5����pn���F��~�>��x�c.b+l�p����Mx��8�������WL��؊��X~�����\�&Oy���-�'0������ ���d�����Y�? ������r -��;���Q�x�8�!;,��0�L0���j�Y�C'ҩnpw|_7Jhfq0���ؚ/i���i+����d�����C>�D���A��t	l1W��h>�e�}�XP�Ā�s-�w�����b��Xņ�t���G�&��#�4(�/�` E# �!jC�6� �ꊑ!��PdW�`JŔ� "�9����\�	p7����"�TT��MWm��	��&do�H Q d sw��ؗ�T��9[���M�f�j�Ξg�ťM��>M_qMrʛ�����i�W�]���fdl��>�ě9kl=�Ԅa�&Ǩg�&F�uE]kl��q�.v�/ޢ��iX�Sq�ۺ�W����ך1��7g�㎉�e�UXw� ̿-�4�Ͻ��/�ެ�tS�;��"��es��oϔH���$B���92	�,B�:�hX��A�e���"�ш�OD ���G%����JT� �T��@0]:���{^F�M,���g:0B{i�]B��
�/���4J9�dV�(�`�
�����2jG:�O�@1z�����cS�)����� �|�[��Aүģ@��GJ��ρ�~	lX�M����1B�0II��t1N��� $)	�!$3"""RP�2��2��J�/�����S��Kx��������nbu9R�}�uݤQ�lЀ-dm�P�D4�`ޒ��g-ӾW�ӧ�ɷxHj�zO������1T��6�����)fO3��d� ��3��jZdԥ��rLN��Ȝo��^Ù�-�~�^��5��E����¿]�_��?_�$3����j��C>K���c{yw��>���J�{u��*U�-��ϝeJj2~�а�.F��4�B"�I�RCF�j_��r�X�߽��6	G}ȅ����zxn��e	?:���_�۪��_W@<��W�H���ܡif�u|��;^_�whWy!6Zި�y�x��?4(V`���f��ʶ��m�߬�Q-�����?<dld��g�cv�{�9� �S�qG����X��dv៱����cF��#�yZpTK���Cj��k�J��V������7�wHV=4�)9, �1���\��{�K�R���-F8���J�~;=���U��_rbJ���^${�ɥP�e��T\�j��#�3͛�D~��3��j�����o3P��K�Lg��è�ΰK��o�í��z�Ew� x����>�=��d����G�f���pmS�- .{>��k�qkH�2�[���&��	j4�a+���`4x�rdv~��s�4����A,J�.�Tp��ܧ���:'7�01(�/�`��' �MT8@�*td��q�^���.�H`����򺢶Y�@{�rrݝf|Ӗ,��4�2�� � � Vz�͖�r�/��H)��A5�H1�u�Y~��<�G������:�SV�`[m�]�~Ӽk������V�B�6�+p7�B����,c���$�[�����R�,�����.*/J�˕��i��~�~WsX��U��t�~yH_tA���]��������#��/�����W�?\ù����s�C]��Q@��{�T;��,JE�ԉ��F�'�#5�H�H!��k�Kho��{v�yvΪ��o�Vo�V���-��ۢ�vn�++e��:nݖm�k�V[5r�m��id���F���d�[��%۰�Z۵ƻkA,����h	�`�v��W{/X��ڪ��o⣜�L�7�җ_���'���Վ����(��O�����=�b���/��,_s9��.g4��lG�n����e?���i�&���=�_G�m�����_�F����\�Nb��r��Iϭ&*T�^���hɁ�&� �Co7����*�!���c�c���ZЏf���=���7��F�6`��, ��a�I�%�X'�[7z�ex�*}�٤oMJ���ET<�!��7&��S�N销�:�6�����)[�Vȉ6o�Y6�$Z�^���O�[�6�p�m�͢�f�Y6�>NSl�b��%f�!f��aJ�f��zk���ƚV�jJ�Ϣ���v�i�N�L{��[��kt'�b�)������"�0A	7,i��0p���Ld��33)��?΀�X )��1�\������w�kpWqGqcp��|�M����7S��8�e&���	��2����L�U��rgp�\��?� �aƧ`
�/��(�(P�Li"�D
\$G���]Sk�;7/z �
��_m9����J�[j��h͑{s�d�N��%kW��[A$Bp ٭3ZO�����g?��q|l\����ۛ�2
ĸ��;���ڨ1l�DDD$�$)I:��)�6`[�5�Pf�Q�g��]�ύ�yc�їr�'�ݸ����EC�0D��Yv0��U'�#toy:E�9����`�0XsVtXͦxt=��%h�&���^�b�pA��J��]�f�9:pn���[;�
�['�I"
�k�#�;j�@q�j�i� ��h������6�'we+���>�g&���a:�����Z��:��y��ZE��\�i����HKO���Ta���;�������2�>�E� �*�,�߹��#�2�%���o�-7`RSCC���[remap]

importer="font_data_dynamic"
type="FontFile"
uid="uid://dctssaf45teat"
path="res://.godot/imported/Roboto-Light.ttf-5cab08b888d7029a314f96d1d7a3342c.fontdata"
 rz�8#�[remap]

path="res://.godot/exported/133200997/export-36103047ef9f34a3c5cf69fc3d37133b-PongGame.scn"
���=H��J�   �����A   res://pong-03/PongGame.tscn-8ֆ��[&   res://Pong-remake.apple-touch-icon.pngĵ�d`o   res://Pong-remake.icon.png��[�Km%   res://Pong-remake.png�Q�,��e   res://Roboto-Light.ttf��w�5Hn   res://pong-remake-picture.JPGlECFG      application/config/name         Pong-remake    application/run/main_scene$         res://pong-03/PongGame.tscn    application/config/features(   "         4.0    GL Compatibility    "   display/window/size/viewport_width         #   display/window/size/viewport_height      X  #   rendering/renderer/rendering_method         gl_compatibility*   rendering/renderer/rendering_method.mobile         gl_compatibility�