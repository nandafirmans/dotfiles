#!/bin/bash

# # Get memory statistics from vm_stat
# vm_stat_output=$(vm_stat)
#
# # Get page size in bytes
# page_size=$(vm_stat | awk '/page size of/ {print $8}')
#
# # Get free, active, inactive, and wired memory in pages
# free_pages=$(echo "$vm_stat_output" | awk '/Pages free:/ {print $3}')
# active_pages=$(echo "$vm_stat_output" | awk '/Pages active:/ {print $3}')
# # inactive_pages=$(echo "$vm_stat_output" | awk '/Pages inactive:/ {print $3}')
# wired_pages=$(echo "$vm_stat_output" | awk '/Pages wired down:/ {print $4}')
#
# # Convert pages to GB
# free_memory_gb=$(bc <<< "scale=2; ($free_pages * $page_size) / 1024 / 1024 / 1024")
# used_memory_gb=$(bc <<< "scale=2; (($active_pages + $wired_pages) * $page_size) / 1024 / 1024 / 1024")

# Page size in bytes
# page_size=16384

page_size=$(vm_stat | awk '/page size of/ {print $8}')

# Extract the necessary values from vm_stat and strip the periods
free_pages=$(vm_stat | grep 'Pages free' | awk '{print $3}' | tr -d '.')
active_pages=$(vm_stat | grep 'Pages active' | awk '{print $3}' | tr -d '.')
inactive_pages=$(vm_stat | grep 'Pages inactive' | awk '{print $3}' | tr -d '.')
speculative_pages=$(vm_stat | grep 'Pages speculative' | awk '{print $3}' | tr -d '.')
wired_pages=$(vm_stat | grep 'Pages wired down' | awk '{print $4}' | tr -d '.')
compressed_pages=$(vm_stat | grep 'Pages occupied by compressor' | awk '{print $5}' | tr -d '.')

# Calculate used pages (active + inactive + speculative + wired + compressed)
total_used_pages=$((active_pages + inactive_pages + speculative_pages + wired_pages + compressed_pages))

# Convert pages to bytes
total_used_memory_bytes=$((total_used_pages * page_size))

# Convert bytes to gigabytes
total_used_memory_gb=$(echo "scale=2; $total_used_memory_bytes / (1024^3)" | bc)

# Calculate App Memory (Anonymous pages) in bytes and convert to gigabytes
app_memory_pages=$(vm_stat | grep 'Anonymous pages' | awk '{print $3}' | tr -d '.')
app_memory_bytes=$((app_memory_pages * page_size))
app_memory_gb=$(echo "scale=2; $app_memory_bytes / (1024^3)" | bc)

# Calculate Wired Memory in bytes and convert to gigabytes
wired_memory_bytes=$((wired_pages * page_size))
wired_memory_gb=$(echo "scale=2; $wired_memory_bytes / (1024^3)" | bc)

# Calculate Compressed Memory in bytes and convert to gigabytes
compressed_memory_bytes=$((compressed_pages * page_size))
compressed_memory_gb=$(echo "scale=2; $compressed_memory_bytes / (1024^3)" | bc)

memory_used_bytes=$((app_memory_bytes + wired_memory_bytes + compressed_memory_bytes))
memory_used_gb=$(echo "scale=2; $memory_used_bytes / (1024^3)" | bc)

# Output the result for debugging
echo "Used Memory: $memory_used_gb GB"
echo "App Memory: $app_memory_gb GB"
echo "Wired Memory: $wired_memory_gb GB"
echo "Compressed Memory: $compressed_memory_gb GB"
echo "Total Used Memory: $total_used_memory_gb GB"

# Use sketchybar to set the RAM label
sketchybar -m --set ram label="$memory_used_gb / 24 GB"
