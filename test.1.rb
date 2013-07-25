$LOAD_PATH.unshift File.dirname(__FILE__)

repeat_times = ARGV[0].to_i
random_max = ARGV[1].to_i

repeat_times.times do
  id = rand(random_max) + 1
  puts "calling pvr on #{id}"
  `ruby pvr.rb #{id}`
end
