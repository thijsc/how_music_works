require_relative "../lib/all"

# Create a new oscilator
oscillator = Sine.new(880, SAMPLE_RATE)

# Create output array
output = []

oscillator.each_with_index do |sample, i|
  break if i > SAMPLE_RATE
  output << sample
end

write_wave("output/sine.wav", output)
write_points_image("output/sine.png", output)

`open output/sine.wav`
`open output/sine.png`
