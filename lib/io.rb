require "wavefile"

def read_wave(path)
  # Open the input wave
  reader = WaveFile::Reader.new(path)
  # Prepare a buffer for all samples
  samples = []
  # Loop through all buffers in the file
  loop do
    begin
      # Read part of the file
      buffer = reader.read(8198)
      # Add it to the samples buffer
      samples.concat(buffer.samples)
    rescue EOFError
      # We're at the end, return the samples buffer
      return samples
    end
  end
end

def write_wave(path, samples)
  WaveFile::Writer.new(path, wave_format) do |writer|
    writer.write(WaveFile::Buffer.new(samples, wave_format))
  end
end

def wave_format
  WaveFile::Format.new(:mono, :pcm_16, 44100)
end
