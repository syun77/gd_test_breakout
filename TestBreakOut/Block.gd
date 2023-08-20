@tool # エディタでも _processを呼び出したい.
extends StaticBody2D

## 色定数.
enum eColor {
	WHITE,
	RED,
	ORANGE,
	GREEN,
	LIME,
	SKY_BLUE,
	BLUE,
	PERPLE,
}

## 色定義.
const COLOR_TBL = {
	eColor.WHITE: Color.WHITE,
	eColor.RED: Color.HOT_PINK,
	eColor.ORANGE: Color.ORANGE,
	eColor.GREEN: Color.GREEN_YELLOW,
	eColor.LIME: Color.LIME,
	eColor.SKY_BLUE: Color.SKY_BLUE,
	eColor.BLUE: Color.CORNFLOWER_BLUE,
	eColor.PERPLE: Color.MEDIUM_ORCHID,
}

## 色情報.
@export var color = eColor.WHITE

@onready var _spr = $Sprite


func _process(delta: float) -> void:
	# 色を設定.
	_spr.modulate = COLOR_TBL[color]
