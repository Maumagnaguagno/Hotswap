#-----------------------------------------------
# Hotswap
#-----------------------------------------------
# Mau Magnaguagno
#-----------------------------------------------
# Swap hotend and bed temperatures of G-code
#-----------------------------------------------

filename, hotend_temperature, bed_temperature = ARGV
abort 'Missing temperature' unless hotend_temperature and bed_temperature
gcode = File.read(filename)
gcode.gsub!(/^M(104|109|140|190) S(?!0)\d+/) {|l|
  n = case $1
  when '104' then "M104 S#{hotend_temperature}" # Set hotend temperature
  when '109' then "M109 S#{hotend_temperature}" # Wait for hotend temperature
  when '140' then "M140 S#{bed_temperature}" # Set bed temperature
  when '190' then "M190 S#{bed_temperature}" # Wait for bed temperature
  end
  puts "Replace '#{l}' with '#{n}'"
  n
}
File.write(filename.sub(/\.gcode$/, "_h#{hotend_temperature}_b#{bed_temperature}.gcode"), gcode)