if system('which say')
  Rails.cache.write('cmd', 'say')
  voices = `say -v ?`.split("\n").map {|line| line.split(" ").first }
  Rails.cache.write('voices', voices)
else
  Rails.cache.write('cmd', 'whateverwepickforlinux')
  Rails.cache.write('voices', '...?')
end