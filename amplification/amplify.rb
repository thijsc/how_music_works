require_relative "../lib/all"

drum = read_wave("input/drum.wav")

def amplify(track, ratio)
  track.map do |sample|
    sample * ratio
  end
end

louder = amplify(drum, 2.0)
clipping = amplify(drum, 4.0)

write_wave("output/louder.wav", louder)
write_wave("output/clipping.wav", clipping)

write_waveform_image("output/drum.png", drum)
write_waveform_image("output/louder.png", louder)
write_waveform_image("output/clipping.png", clipping)

`open output/drum.png`
`open output/louder.png`
`open output/clipping.png`
`open output/louder.wav`
`open output/clipping.wav`
