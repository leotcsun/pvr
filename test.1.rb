100.times do
  id = rand(4) + 1
  puts "calling pvr on #{id}"
  `ruby pvr.rb #{id}`
end
