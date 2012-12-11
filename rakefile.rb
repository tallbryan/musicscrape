task :default => [:test]

task :test do
  rspec "lib/musicscrape_spec.rb"
end