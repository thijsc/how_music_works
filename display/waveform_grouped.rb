require_relative "../lib/all"

cymbal = read_wave("input/cymbal.wav")

write_waveform_image("output/cymbal.png", cymbal)

`open output/cymbal.png`
