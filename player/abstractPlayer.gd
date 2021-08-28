extends Node

signal life_changed(value)

export (int) var maxLife = 5

var life
var coins = 100
var tucas = 0
var score = 0
var have_cad = false
var have_coch = false

func die():
	queue_free()

func get_hurt():
	pass

func pickup():
	pass

