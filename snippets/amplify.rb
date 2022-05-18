drum = read_wave("input/drum.wav")

def amplify(track, ratio)
  track.map do |sample|
    sample * ratio
  end
end

clipping = amplify(drum, 4.0)
write_wave("output/clipping.wav", clipping)
