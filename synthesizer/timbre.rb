require_relative "../lib/all"

# Same pitch, different waveforms — this is what creates timbre
sine = Sine.new(220, SAMPLE_RATE)
square = Square.new(220, SAMPLE_RATE)

output = SAMPLE_RATE.times.map do
  sine.next_sample / 2 + square.next_sample / 2
end

write_wave("output/timbre.wav", output)
write_points_image("output/timbre.png", output)

`open output/timbre.wav`
`open output/timbre.png`
