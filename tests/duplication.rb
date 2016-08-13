if "`bin/local_dev.rb|grep github2cgit`".lines.count > 1
  fail "duplicated entries present"
end

puts "OK"
