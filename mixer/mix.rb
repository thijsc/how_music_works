require_relative "../lib/all"

bass = read_wave("input/bass.wav")
drum = read_wave("input/drum.wav")
piano = read_wave("input/piano.wav")

# Sum a number of tracks, we are assuming
# they are all the exact same length
def sum_tracks(*tracks)
  tracks.first.map.with_index do |_, i|
    summed = 0
    # Loop through all the tracks and increment
    # the summed sample with its value
    tracks.each do |track|
      # Increment the summed sample, but first
      # make it a bit less loud so we don't clip
      summed += track[i] / 1.5
    end
    summed
  end
end

# Sum the tracks into a new array
summed = sum_tracks(bass, drum, piano)

# Write it to disk
write_wave("output/mixed.wav", summed)

write_waveform_image("output/bass.png", bass)
write_waveform_image("output/drum.png", drum)
write_waveform_image("output/piano.png", piano)
write_waveform_image("output/mixed.png", summed)

`open output/mixed.png`
`open output/mixed.wav`
