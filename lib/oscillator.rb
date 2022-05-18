class Square
  include Enumerable

  attr_reader :frequency, :sample_rate, :position, :length

  def initialize(frequency, sample_rate)
    @frequency = frequency
    @sample_rate = sample_rate
    @length = sample_rate / frequency
    @position = 0
  end

  def next_sample
    # Call with either the high
    # or the low number
    sample = if @position < @length / 2
               20_000
             else
               -20_000
             end

    # Increment position
    @position += 1

    # Reset position if over frequency
    if @position > @length
      @position = 0
    end

    # Return the sample
    sample
  end

  def each
    loop do
      yield next_sample
    end
  end
end

class Sine
  include Enumerable

  attr_reader :sample_rate, :frequency

  def initialize(frequency, sample_rate)
    @frequency = frequency
    @sample_rate = sample_rate
    @increment_by = frequency.to_f / sample_rate.to_f
    puts @increment_by
    @position = 0.0
  end

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

  def each
    loop do
      yield next_sample
    end
  end
end
