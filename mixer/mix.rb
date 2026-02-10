require_relative "../lib/all"

bass = read_wave("input/bass.wav")
drum = read_wave("input/drum.wav")
piano = read_wave("input/piano.wav")

# Mix by summing sample-by-sample, scaled down to avoid clipping
def sum_tracks(*tracks)
  tracks[0].zip(*tracks[1..]).map do |samples|
    samples.sum / 1.5
  end
end

summed = sum_tracks(bass, drum, piano)

write_wave("output/mixed.wav", summed)

write_waveform_image("output/bass.png", bass)
write_waveform_image("output/drum.png", drum)
write_waveform_image("output/piano.png", piano)
write_waveform_image("output/mixed.png", summed)

`open output/mixed.png`
`open output/mixed.wav`
