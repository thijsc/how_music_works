samples_per_pixel = samples.length / WIDTH

# First pass: Cut up into slices and calculate the averages
# for the positive and negative number
slices = samples.each_slice(samples_per_pixel).map do |samples|
  # Select the positive and negative numbers in this slice
  positive_samples = samples.select { |s| s.positive? }
  negative_samples = samples.select { |s| s.negative? }

  # Calculate the averages
  positive_average = positive_samples.sum / samples_per_pixel
  negative_average = negative_samples.map do |sample|
    sample.abs
  end.sum / samples_per_pixel

  # Return both
  [positive_average, negative_average]
end
