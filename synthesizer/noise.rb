require_relative "../lib/all"

output = SAMPLE_RATE.times.map do
  Random.rand(-30_000..30_000)
end

write_wave("output/noise.wav", output)
write_points_image("output/noise.png", output)

`open output/noise.wav`
`open output/noise.png`
