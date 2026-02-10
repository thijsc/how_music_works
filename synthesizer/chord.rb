require_relative "../lib/all"

# A major chord: A4, C#5, E5
a_note = Sine.new(440, SAMPLE_RATE)
c_sharp_note = Sine.new(554.37, SAMPLE_RATE)
e_note = Sine.new(659.25, SAMPLE_RATE)

output = SAMPLE_RATE.times.map do
  # Mix by summing the waves and dividing by 3 to avoid clipping
  a_note.next_sample / 3 + c_sharp_note.next_sample / 3 + e_note.next_sample / 3
end

write_wave("output/chord.wav", output)
write_points_image("output/chord.png", output)

`open output/chord.wav`
`open output/chord.png`
