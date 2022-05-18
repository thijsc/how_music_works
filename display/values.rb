require_relative "../lib/all"

cymbal = read_wave("input/cymbal.wav")

SAMPLES_PER_SLICE = 11_025

cymbal.each_slice(SAMPLES_PER_SLICE).with_index do |samples, i|
  # Convert all negative values to positive, we
  # are just interested in getting intensity.
  values = samples.map do |s|
    s.abs
  end

  # Calculate the average for this slice
  average = values.sum / samples.length

  puts "#{i * SAMPLES_PER_SLICE}: #{average}"
end
