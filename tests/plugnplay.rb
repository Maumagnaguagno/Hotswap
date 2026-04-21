#frozen_string_literal: true
require 'test/unit'

class Plugnplay < Test::Unit::TestCase

  INPUT = "\
M104 S0
M109 S0
M140 S0
M190 S0
M104 S200
M109 S200
M140 S60
M190 S60
M104 other S210
M109 other S210
M140 other S70
M190 other S70"

  OUTPUT = "\
M104 S0
M109 S0
M140 S0
M190 S0
M104 S100
M109 S100
M140 S50
M190 S50
M104 other S100
M109 other S100
M140 other S50
M190 other S50"

MESSAGE = "test.gcode
  Replace 'M104 S200' with 'M104 S100'
  Replace 'M109 S200' with 'M109 S100'
  Replace 'M140 S60' with 'M140 S50'
  Replace 'M190 S60' with 'M190 S50'
  Replace 'M104 other S210' with 'M104 other S100'
  Replace 'M109 other S210' with 'M109 other S100'
  Replace 'M140 other S70' with 'M140 other S50'
  Replace 'M190 other S70' with 'M190 other S50'
"

  def test_replacement
    test_input_filename = 'test.gcode'
    test_output_filename = 'test_h100_b50.gcode'
    File.delete(test_input_filename) if File.exist?(test_input_filename)
    File.delete(test_output_filename) if File.exist?(test_output_filename)
    File.binwrite(test_input_filename, INPUT)
    assert_equal(MESSAGE, `ruby Hotswap.rb 100 50`)
    assert_equal(OUTPUT, File.binread(test_output_filename))
  ensure
    File.delete(test_input_filename) if File.exist?(test_input_filename)
    File.delete(test_output_filename) if File.exist?(test_output_filename)
  end

  def test_missing_arguments
    assert_equal("ruby Hotswap.rb hotend_temperature bed_temperature {filenames}\n", `ruby Hotswap.rb`)
    assert_equal("ruby Hotswap.rb hotend_temperature bed_temperature {filenames}\n", `ruby Hotswap.rb -h 200 60`)
    assert_equal("ruby Hotswap.rb hotend_temperature bed_temperature {filenames}\n", `ruby Hotswap.rb 200`)
    assert_equal("Expected integer in hotend temperature\n", `ruby Hotswap.rb a 60 2>&1`)
    assert_equal("Expected integer in bed temperature\n", `ruby Hotswap.rb 200 a 2>&1`)
  end
end