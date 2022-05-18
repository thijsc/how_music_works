require_relative "../lib/all"

# Create a new oscillator
oscillator = Square.new(440, SAMPLE_RATE)

# Create output array
output = []

oscillator.each_with_index do |sample, i|
  break if i > SAMPLE_RATE
  output << sample
end

write_wave("output/square.wav", output)
write_points_image("output/square.png", output)

`open output/square.wav`
`open output/square.png`
