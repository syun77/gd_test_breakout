extends Node2D
# ======================================================
# メインシーン.
# ======================================================
# ------------------------------------------------------
# const.
# ------------------------------------------------------
const TIMER_READY = 1.0

## 状態.
enum eState {
	READY,
	MAIN,
	GAMEOVER,
}

# ------------------------------------------------------
# onready.
# ------------------------------------------------------
@onready var _ball = $MainLayer/Ball
@onready var _ui_layer = $UILayer
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
	pass # Replace with function body.

func _process(delta: float) -> void:
	match _state:
		eState.READY:
			_update_ready(delta)
		eState.MAIN:
			_update_main(delta)
		eState.GAMEOVER:
			_update_gameover()
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
	_ball.update(delta)

## 更新 > ゲームオーバー.
func _update_gameover() -> void:
	pass
	
## 更新 > UI.
func _update_ui() -> void:
	_ui_label_speed.text = "SPEED: %d"%int(_ball.get_speed())

## 更新 > デバッグ.
func _update_debug() -> void:
	if Input.is_action_just_pressed("reset"):
		get_tree().change_scene_to_file("res://Main.tscn")
