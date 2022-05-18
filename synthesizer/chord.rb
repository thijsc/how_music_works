require_relative "../lib/all"

# Create multiple oscillators
a_note = Sine.new(440, SAMPLE_RATE)
c_sharp_note = Sine.new(554.37, SAMPLE_RATE)
e_note = Sine.new(659.25, SAMPLE_RATE)

# Create output array
output = []

0..SAMPLE_RATE.times do |i|
  # Get the samples for all three notes
  sample_one = a_note.next_sample / 3
  sample_two = c_sharp_note.next_sample / 3
  sample_three = e_note.next_sample / 3

  output << sample_one + sample_two + sample_three
end

write_wave("output/chord.wav", output)
write_points_image("output/chord.png", output)

`open output/chord.wav`
`open output/chord.png`
