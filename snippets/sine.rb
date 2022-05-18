def next_sample
  sample = Math.sin(@position * Math::PI / 2) * 25_000

  # Increment position
  @position += @increment_by

  # Reset position if over max
  if @position >= frequency
    @position = 0.0
  end

  # Return the sample
  sample
end
