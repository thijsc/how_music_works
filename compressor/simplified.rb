require_relative "../lib/all"

input = read_wave("input/cymbal.wav")

def reduce_peaks(track, threshold, ratio)
  track.map do |sample|
    if sample > threshold or sample < -threshold
      sample / ratio
    else
      sample
    end
  end
end

def apply_makeup_gain(track, makeup)
  track.map { |sample| sample * makeup }
end

peaks_reduced = reduce_peaks(input, 1000, 8)
makeup_gain_applied = apply_makeup_gain(peaks_reduced, 12.0)

write_wave("output/final.wav", makeup_gain_applied)
write_waveform_image("output/cymbal.png", input)
write_waveform_image("output/final.png", makeup_gain_applied)

`open output/cymbal.png`
`open output/final.png`
`open output/final.wav`
