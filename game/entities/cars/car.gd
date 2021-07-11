###############################################################################
# Copyright (C) 2021 Severi Vidnäs                                            #
# Distributed under the terms of the GNU General Public License v3.0          #
###############################################################################
class_name Car
extends VehicleBody
# Base for all Cars.

# Amount of throttle input between frames.
var _throttle_input: float = 0.0 setget set_throttle_input, get_throttle_input
# Amount of brake input between frames.
var _brake_input: float = 0.0 setget set_brake_input, get_brake_input
# Amount of steer input between frames.
var _steer_input: float = 0.0 setget set_steer_input, get_steer_input


# See Node._physics_process
func _physics_process(delta: float) -> void:
  engine_force = _throttle_input * 200
  brake = _brake_input * 5

  _reset_variables()
  pass


func set_throttle_input(value: float) -> void:
  _throttle_input = value
  pass


func get_throttle_input() -> float:
  return _throttle_input
  pass


func set_brake_input(value: float) -> void:
  _brake_input = value
  pass


func get_brake_input() -> float:
  return _brake_input
  pass


func set_steer_input(value: float) -> void:
  _steer_input = value
  pass


func get_steer_input() -> float:
  return _steer_input
  pass


# Adds throttle input and return the input value after addition.
func add_throttle_input(value: float) -> float:
  _throttle_input = Utilities.clamp_input_unidirectional(
      _throttle_input + value
    )
  return _throttle_input
  pass


# Adds brake input and return the input value after addition.
func add_brake_input(value: float) -> float:
  _brake_input = Utilities.clamp_input_unidirectional(
      _brake_input + value
    )
  return _brake_input
  pass


# Adds steer input and return the input value after addition.
func add_steer_input(value: float) -> float:
  _steer_input = Utilities.clamp_input_bidirectional(
      _steer_input + value
    )
  return _steer_input
  pass


# Function resets all per frame variable to their initial values.
func _reset_variables() -> void:
  _throttle_input = 0.0
  _brake_input = 0.0
  _steer_input = 0.0
  pass
