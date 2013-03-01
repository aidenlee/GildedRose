watch('.*\.rb') { |_| run_all_tests }

def run_all_tests
  puts "\n--- Running all tests ---\n"
  system 'ruby gilded_rose_test.rb'
end

Signal.trap('QUIT') { run_all_tests } # Ctrl-\
Signal.trap('INT') { abort("\n") } # Ctrl-C
