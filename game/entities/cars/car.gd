###############################################################################
# Copyright (C) 2021 Severi Vidnäs                                            #
# Distributed under the terms of the GNU General Public License v3.0          #
###############################################################################
class_name Car
extends VehicleBody
# Base for all Cars.

# Amount of throttle input between frames.
var _throttle_input: float = 0.0
# Amount of brake input between frames.
var _brake_input: float = 0.0
# Amount of steer input between frames.
var _steer_input: float = 0.0


# See Node._physics_process
func _physics_process(delta: float) -> void:
  engine_force = _throttle_input * 200
  brake = _brake_input * 5

  _reset_variables()
  pass


# Adds throttle input and return the input value after addition.
func _add_throttle_input(value: float) -> float:
  _throttle_input = Utilities.clamp_input_unidirectional(
      _throttle_input + value
    )
  return _throttle_input
  pass


# Adds brake input and return the input value after addition.
func _add_brake_input(value: float) -> float:
  _brake_input = Utilities.clamp_input_unidirectional(
      _brake_input + value
    )
  return _brake_input
  pass


# Adds steer input and return the input value after addition.
func _add_steer_input(value: float) -> float:
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
