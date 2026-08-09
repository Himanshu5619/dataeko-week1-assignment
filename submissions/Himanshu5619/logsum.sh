#!/bin/bash

# Check if exactly one argument is provided
if [ $# -ne 1 ]; then
    echo "Usage: ./logsum.sh <logfile>" >&2
    exit 1
fi

# Store the filename
file=$1

# Check if the file exists
if [ ! -f "$file" ]; then
    echo "Error: File not found" >&2
    exit 2
fi

# Count total lines
lines=$(wc -l < "$file")

# Count log levels
info=$(grep -c ' INFO ' "$file")
warn=$(grep -c ' WARN ' "$file")
error=$(grep -c ' ERROR ' "$file")

# Print summary
echo "LOG SUMMARY"
echo "==========="
echo "File:  $file"
echo "Lines: $lines"
echo

echo "Level counts"
printf "  INFO    %d\n" "$info"
printf "  WARN    %d\n" "$warn"
printf "  ERROR   %d\n" "$error"
echo

echo "Errors by service"

# Count ERRORs for each service
errors=$(awk '$3=="ERROR" {print $4}' "$file" | sort | uniq -c | sort -nr)

# Print services and counts
echo "$errors" | awk '{printf "  %-25s %d\n", $2, $1}'

# Find the worst service
worst=$(echo "$errors" | head -1)

count=$(echo "$worst" | awk '{print $1}')
service=$(echo "$worst" | awk '{print $2}')

echo
echo "Worst service: $service ($count errors)"

exit 0
