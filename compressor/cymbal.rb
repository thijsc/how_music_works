require_relative "../lib/all"

RELEASE = 44_100 / 10

cymbal = read_wave("input/cymbal.wav")

# Compress a track
def compress_track(track, treshold, ratio, makeup)
  # First pass: lower gain of peaks
  gain_lowered = [].tap do |out|
    # Whether the compressor is on at the moment
    compressor_on = false

    # Count of samples that are below treshold if
    # the compressor is on
    release_sample_count = 0

    puts "Compressing track with #{track.length} samples"

    track.each_with_index do |sample, i|
      if sample > treshold or sample < -treshold
        # Above the treshold, turn the compressor on if it's not already
        unless compressor_on
          puts "Turning on compression at sample #{i} level #{sample.abs}"
          compressor_on = true
        end

        # Reset the release sample count, we saw a high value again
        release_sample_count = 0
      elsif compressor_on
        # Not above the treshold, but the compressor
        # is still on, count this sample.
        release_sample_count += 1

        # If we're beyond the release turn compression off
        if release_sample_count >= RELEASE
          puts "Turning off compression at sample #{i} level #{sample.abs}"
          compressor_on = false
          release_sample_count = 0
        end
      end

      if compressor_on
        out << compress_sample(sample, treshold, ratio)
      else
        out << sample
      end
    end
  end

  # Second pass: Apply make up gain
  [].tap do |out|
    gain_lowered.each do |sample|
      out << sample * makeup
    end
  end
end

def compress_sample(sample, treshold, ratio)
  positive = sample.positive?
  sample = sample.abs

  if sample > treshold
    above_treshold = sample - treshold
    compressed = treshold + (above_treshold / ratio)
    compress = treshold
    positive ? compressed : -compressed
  else
    positive ? sample : -sample
  end
end

# Compress the track into a new array
compressed = compress_track(cymbal, 1000, 128, 2.0)

# Write it to disk
write_wave("output/cymbal_compressed.wav", compressed)
write_waveform_image("output/cymbal.png", cymbal)
write_waveform_image("output/cymbal_compressed.png", compressed)

`open output/cymbal_compressed.wav`
`open output/cymbal.png`
`open output/cymbal_compressed.png`
