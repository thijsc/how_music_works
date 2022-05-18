require "chunky_png"

BLACK = ChunkyPNG::Color::from_hex("#000000")
WHITE = ChunkyPNG::Color::from_hex("#FFFFFF")
YELLOW = ChunkyPNG::Color.from_hex('#FFBD16')

WIDTH = 1920
HEIGHT = 1080
HALFWAY = HEIGHT / 2

MAX = 32_767
FACTOR = MAX / HALFWAY

def write_points_image(path, samples)
  image = ChunkyPNG::Image.new(WIDTH, HEIGHT, BLACK)

  samples.each_with_index do |sample, i|
    break if i > WIDTH

    position = if sample > 0
                 HALFWAY - offset_from_halfway(sample)
               else
                 HALFWAY + offset_from_halfway(sample)
               end

    image.rect(i, position, i + 8, position + 8, YELLOW, YELLOW)
  end

  separator_line(image)

  image.save(path)
end

def write_waveform_image(path, samples)
  image = ChunkyPNG::Image.new(WIDTH, HEIGHT, BLACK)

  samples_per_pixel = samples.length / WIDTH

  # First pass: Cut up into slices and calculate the averages
  # for the positive and negative number
  slices = samples.each_slice(samples_per_pixel).map do |samples|
    positive_average = samples.select do |sample|
      sample.positive?
    end.sum / samples_per_pixel

    negative_average = samples.select do |sample|
      sample.negative?
    end.map do |sample|
      sample.abs
    end.sum / samples_per_pixel

    # Return both
    [positive_average, negative_average]
  end

  puts "Drawing waveform with #{samples_per_pixel} samples per pixel"

  # Second pass: Write the data to the image
  slices.each_with_index do |slice, i|
    # Calculate the position in the image
    positive_x_top = HALFWAY - offset_from_halfway(slice[0])
    negative_x_bottom = HALFWAY + offset_from_halfway(slice[1])

    # Write the lines
    image.line(i, positive_x_top, i, HALFWAY, YELLOW)
    image.line(i, HALFWAY, i, negative_x_bottom, YELLOW)
  end

  # Draw a line in the middle
  separator_line(image)

  image.save(path)
end

def separator_line(image)
  image.line(0, HALFWAY - 1, WIDTH, HALFWAY - 1, WHITE)
  image.line(0, HALFWAY, WIDTH, HALFWAY, WHITE)
  image.line(0, HALFWAY + 1, WIDTH, HALFWAY + 1, WHITE)
end

def offset_from_halfway(sample)
  (sample.abs / FACTOR).to_i
end
