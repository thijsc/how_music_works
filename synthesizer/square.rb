require_relative "../lib/all"

oscillator = Square.new(440, SAMPLE_RATE)
output = oscillator.take(SAMPLE_RATE)

write_wave("output/square.wav", output)
write_points_image("output/square.png", output)

`open output/square.wav`
`open output/square.png`
