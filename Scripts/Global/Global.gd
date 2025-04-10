# Script enhanced bغ 38roob = عقرووب
extends Node

var FistJoinToGame = true
## the player camera i think, i'm not who wrote this var.
var camera: PlayerCamera

var coin = 0
var score = 0
var last_score = 0
var got_it = false


## an array of all levels. they are in asceding order.
var levels: Array[PackedScene] = [
	preload("res://Levels/Level_1.tscn"),
	preload("res://Levels/level_2.tscn"),
	preload("res://Levels/level_3.tscn"),
	preload("res://Levels/level_4.tscn"),
	preload("res://Levels/level_5.tscn"),
]

## the number of the current level
## NOT THE INDEX
var current_level: int = 1
## the index of the current level (0 is the first), it is basicly current level - 1
## NOT THE LEVEL NUMER
var current_level_index: int:
	get:
		return current_level -1

## the scene of the current level the player shouold be playing 
var current_level_scene: PackedScene:
	get:
		return levels[current_level_index]
## the scene of the next level, uses current level index to know
var next_level_scene: PackedScene:
	get:
		return levels[current_level_index +1] # did't use current_level to make more readable


## returns the player.
func get_player() -> Player:
	return get_tree().get_first_node_in_group("Player")

## returns the player health manager. use it to get it and damage, heal or kill the player.
## or do anything you want
func get_player_health_manager() -> HealthManager:
	return get_tree().get_first_node_in_group("player_health_manager")
