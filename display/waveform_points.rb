require_relative "../lib/all"

cymbal = read_wave("input/cymbal.wav")

image = ChunkyPNG::Image.new(WIDTH, HEIGHT, BLACK)

puts "Drawing waveform"

cymbal.each_with_index do |sample, i|
  break if i > WIDTH

  position = if sample > 0
               HALFWAY - offset_from_halfway(sample)
             else
               HALFWAY + offset_from_halfway(sample)
             end

  puts "Drawing at #{position} for #{sample} at #{i}"

  image.rect(i, position, i + 8, position + 8, YELLOW, YELLOW)
end

# Draw a line through the middle
separator_line(image)

image.save("output/waveform.png")

`open output/waveform.png`
