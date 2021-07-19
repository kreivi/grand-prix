###############################################################################
# Copyright (C) 2021 Severi Vidnäs                                            #
# Distributed under the terms of the GNU General Public License v3.0          #
###############################################################################
class_name PlayerCar
extends RaceCar
# Car for player.

export (String) var accelerate_input = "accelerate"
export (String) var brake_input = "brake"
export (String) var steer_left = "steer_left"
export (String) var steer_right = "steer_right"

func _physics_process(delta: float) -> void:
  if Input.is_action_pressed(accelerate_input):
    add_throttle_input(Input.get_action_strength(accelerate_input))
  if Input.is_action_pressed(brake_input):
    add_brake_input(Input.get_action_strength(brake_input))
  if Input.is_action_pressed(steer_left):
    add_steer_input(Input.get_action_strength(steer_left))
  if Input.is_action_pressed(steer_right):
    add_steer_input(-Input.get_action_strength(steer_right))
  pass
