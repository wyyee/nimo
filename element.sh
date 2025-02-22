#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

# Check if an argument is provided
if [[ -z $1 ]]; then
  echo "Please provide an element as an argument."
  exit 0
fi

ELEMENT=$($PSQL "
  SELECT elements.atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius
  FROM elements
  JOIN properties ON elements.atomic_number = properties.atomic_number
  JOIN types ON properties.type_id = types.type_id
  WHERE elements.atomic_number::text = '$1'
  OR symbol = '$1'
  OR name = '$1'
")