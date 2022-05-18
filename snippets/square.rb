class Square
  include Enumerable

  def next_sample
    sample = if @position < @length / 2
               20_000
             else
               -20_000
             end
    @position += 1
    if @position > @length
      @position = 0
    end
    sample
  end

  def each
    loop { yield next_sample }
  end
end
