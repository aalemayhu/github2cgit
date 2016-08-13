if "`scripts/example-pull-tmp|grep github2cgit`".length > 1
  fail "duplicated entries present"
end

puts "OK"
