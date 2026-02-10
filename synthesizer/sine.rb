require_relative "../lib/all"

oscillator = Sine.new(880, SAMPLE_RATE)
output = oscillator.take(SAMPLE_RATE)

write_wave("output/sine.wav", output)
write_points_image("output/sine.png", output)

`open output/sine.wav`
`open output/sine.png`
