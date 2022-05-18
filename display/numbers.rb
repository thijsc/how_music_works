require_relative "../lib/all"

cymbal = read_wave("input/cymbal.wav")

loop do
  cymbal.each do |sample|
    print "#{sample} "
    $stdout.flush
    sleep 0.000001
  end
end
