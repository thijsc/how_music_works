require_relative "../lib/all"

cymbal = read_wave("input/cymbal.wav")

image = ChunkyPNG::Image.new(WIDTH, HEIGHT, BLACK)

max = cymbal.max
factor = max / HALFWAY

puts "Drawing waveform with upper limit of #{max}"

cymbal.each_with_index do |sample, i|
  break if i > WIDTH

  if sample > 0
    x_top = HALFWAY - offset_from_halfway(sample, factor)
    x_bottom = HALFWAY
  else
    x_top = HALFWAY
    x_bottom = HALFWAY + offset_from_halfway(sample, factor)
  end

  puts "Drawing at #{x_top}-#{x_bottom} for #{sample} at #{i}"

  image.line(i, x_top, i, x_bottom, YELLOW)
end

# Draw a line through the middle
separator_line(image)

image.save("output/waveform.png")

`open output/waveform.png`
