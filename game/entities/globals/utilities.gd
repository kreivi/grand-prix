###############################################################################
# Copyright (C) 2021 Severi Vidnäs                                            #
# Distributed under the terms of the GNU General Public License v3.0          #
###############################################################################
extends Node
# Utility functions.

# Clamp unidirectional input.
func clamp_input_unidirectional(input: float) -> float:
  return clamp(input, 
      Constants.UNIDIRECTIONAL_INPUT_VALUE_MIN,
      Constants.UNIDIRECTIONAL_INPUT_VALUE_MAX
    )
  pass


# Clamp bidirectional input.
func clamp_input_bidirectional(input: float) -> float:
  return clamp(input,
      Constants.BIDIRECTIONAL_INPUT_VALUE_MIN,
      Constants.BIDIRECTIONAL_INPUT_VALUE_MAX
    )
  pass
