#-----------------------------------------------
# Hotswap
#-----------------------------------------------
# Mau Magnaguagno
#-----------------------------------------------
# Swap hotend and bed temperatures of G-code
#-----------------------------------------------

if ARGV[0] == '-h'
  puts 'ruby Hotswap.rb hotend_temperature bed_temperature {filenames}'
else
  abort 'Expected integer in hotend temperature' unless (hotend_temperature = ARGV.shift).match?(/^\d+$/)
  abort 'Expected integer in bed temperature' unless (bed_temperature = ARGV.shift).match?(/^\d+$/)
  (ARGV.empty? ? Dir.glob('*.gcode') : ARGV).each {|filename|
    puts filename
    (gcode = File.read(filename)).gsub!(/^M(104|109|140|190)(.*)S(?!0)\d+/) {|l|
      n = case $1
      when '104','109' then "M#{$1}#{$2}S#{hotend_temperature}" # Set/wait hotend temperature
      when '140','190' then "M#{$1}#{$2}S#{bed_temperature}" # Set/wait bed temperature
      end
      puts "  Replace '#{l}' with '#{n}'"
      n
    }
    File.write(filename.sub(/\.gcode$/, "_h#{hotend_temperature}_b#{bed_temperature}.gcode"), gcode)
  }
end