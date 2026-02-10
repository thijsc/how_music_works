require_relative "../lib/all"

RELEASE = 44_100 / 10

cymbal = read_wave("input/cymbal.wav")

def compress_track(track, threshold, ratio, makeup)
  compressor_on = false
  release_count = 0

  # First pass: lower gain of peaks
  gain_lowered = track.map do |sample|
    if sample.abs > threshold
      compressor_on = true
      release_count = 0
    elsif compressor_on
      release_count += 1
      if release_count >= RELEASE
        compressor_on = false
        release_count = 0
      end
    end

    if compressor_on
      compress_sample(sample, threshold, ratio)
    else
      sample
    end
  end

  # Second pass: apply makeup gain
  gain_lowered.map { |sample| sample * makeup }
end

def compress_sample(sample, threshold, ratio)
  return sample if sample.abs <= threshold

  above = sample.abs - threshold
  compressed = threshold + (above / ratio)
  sample.positive? ? compressed : -compressed
end

compressed = compress_track(cymbal, 1000, 128, 2.0)

write_wave("output/cymbal_compressed.wav", compressed)
write_waveform_image("output/cymbal.png", cymbal)
write_waveform_image("output/cymbal_compressed.png", compressed)

`open output/cymbal_compressed.wav`
`open output/cymbal.png`
`open output/cymbal_compressed.png`
