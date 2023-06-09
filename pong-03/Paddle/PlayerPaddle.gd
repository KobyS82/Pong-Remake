extends Paddle

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
