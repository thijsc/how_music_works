require_relative "../lib/all"

# Create multiple oscillators
one = Sine.new(220, SAMPLE_RATE)
two = Square.new(220, SAMPLE_RATE)

# Create output array
output = []

0..SAMPLE_RATE.times do |i|
  # Get the samples for all three notes
  sample_one = one.next_sample / 3
  sample_two = two.next_sample / 3

  output << sample_one + sample_two
end

write_wave("output/timbre.wav", output)
write_points_image("output/timbre.png", output)

`open output/timbre.wav`
`open output/timbre.png`
