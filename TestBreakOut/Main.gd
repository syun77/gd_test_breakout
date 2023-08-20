extends Node2D
# ======================================================
# メインシーン.
# ======================================================

# ------------------------------------------------------
# preload.
# ------------------------------------------------------
const BALL_OBJ = preload("res://src/Ball.tscn")

# ------------------------------------------------------
# const.
# ------------------------------------------------------
const TIMER_READY = 1.0
const DEADLINE_Y = 800 # 死亡判定.

## 状態.
enum eState {
	READY,
	MAIN,
	GAMEOVER,
	GAMECLEAR,
}

# ------------------------------------------------------
# onready.
# ------------------------------------------------------
@onready var _ball = $MainLayer/Ball
@onready var _spawn_ball = $MainLayer/SpawnBall
@onready var _block_layer = $BlockLayer
@onready var _main_layer = $MainLayer
@onready var _ui_layer = $UILayer
@onready var _ui_score = $UILayer/LabelScore
@onready var _ui_ball = $UILayer/LabelBall
@onready var _ui_label_speed = $UILayer/LabelSpeed
@onready var _ui_caption = $UILayer/Caption
@onready var _ui_label_caption = $UILayer/Caption/Label

# ------------------------------------------------------
# var.
# ------------------------------------------------------
var _timer = 0.0
var _state = eState.READY

# ------------------------------------------------------
# private functions.
# ------------------------------------------------------
func _ready() -> void:
	Common.init()
	_ui_caption.visible = true
	Common.damage(1)

func _process(delta: float) -> void:
	match _state:
		eState.READY:
			_update_ready(delta)
		eState.MAIN:
			_update_main(delta)
		eState.GAMEOVER:
			_update_gameover()
		eState.GAMECLEAR:
			_update_gameclear()
	_update_ui()
	
	# デバッグ用.
	_update_debug()

## 更新 > 開始.
func _update_ready(delta:float) -> void:
	_timer += delta
	if _timer > TIMER_READY:
		# 開始.
		_state = eState.MAIN
		_timer = 0
		_ui_caption.visible = false

## 更新 > メイン.
func _update_main(delta:float) -> void:
	if _block_layer.get_child_count() == 0:
		# ブロッがすべてなくなればクリア.
		_state = eState.GAMECLEAR
		return
	
	_ball.update(delta)
	
	if _ball.position.y > DEADLINE_Y:
		# 死亡.
		damage()

## ダメージ処理.
func damage() -> void:
	_ball.queue_free()
	if Common.is_dead():
		# ゲームオーバー.
		_state = eState.GAMEOVER
		return

	_state = eState.READY
	_timer = 0
	_ui_caption.visible = true
	Common.damage(1)
	
	# ボールを復活.
	_ball = BALL_OBJ.instantiate()
	# リスタート位置に戻す.
	_ball.position = _spawn_ball.position
	_main_layer.add_child(_ball)
	

## 更新 > ゲームオーバー.
func _update_gameover() -> void:
	_ui_label_caption.text = "GAME OVER"
	_ui_caption.visible = true
	
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene_to_file("res://Main.tscn")
	
## 更新 > ゲームクリア.
func _update_gameclear() -> void:
	_ui_label_caption.text = "GAME CLEAR"
	_ui_caption.visible = true
	
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene_to_file("res://Main.tscn")
	
## 更新 > UI.
func _update_ui() -> void:
	_ui_score.text = "SCORE: %d"%Common.score
	_ui_ball.text = "BALL x %d"%Common.hp
	if is_instance_valid(_ball):
		_ui_label_speed.text = "SPEED: %d"%int(_ball.get_speed())

## 更新 > デバッグ.
func _update_debug() -> void:
	if Input.is_action_just_pressed("reset"):
		get_tree().change_scene_to_file("res://Main.tscn")
