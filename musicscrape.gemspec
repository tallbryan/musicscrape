# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in rakefile.rb, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "musicscrape"
  s.version = "0.0.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["tallbryan"]
  s.date = "2012-12-11"
  s.description = "scrape this weeks shows off the stranger"
  s.email = "fake@fake.com"
  s.executables = ["musicscrape"]
  s.extra_rdoc_files = [
    "README.md"
  ]
  s.files = [
    ".DS_Store",
    ".travis.yml",
    "Gemfile",
    "Gemfile.lock",
    "README.md",
    "VERSION",
    "bin/musicscrape",
    "lib/musicscrape.rb",
    "lib/musicscrape_spec.rb",
    "lib/pruned.txt",
    "lib/stranger.txt",
    "musicscrape-0.0.1.gem",
    "musicscrape-0.0.2.gem",
    "musicscrape-0.0.3.gem",
    "musicscrape-0.0.4.gem",
    "musicscrape.gemspec",
    "rakefile.rb"
  ]
  s.homepage = "http://github.com/tallbryan/musicscrape"
  s.licenses = ["BOB"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.24"
  s.summary = "scrape this weeks shows off the stranger"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, ["~> 2.8.0"])
      s.add_development_dependency(%q<bundler>, [">= 0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.8.4"])
      s.add_development_dependency(%q<cucumber>, [">= 0"])
      s.add_development_dependency(%q<rest-client>, [">= 0"])
      s.add_development_dependency(%q<gcal4ruby>, [">= 0"])
    else
      s.add_dependency(%q<rspec>, ["~> 2.8.0"])
      s.add_dependency(%q<bundler>, [">= 0"])
      s.add_dependency(%q<jeweler>, ["~> 1.8.4"])
      s.add_dependency(%q<cucumber>, [">= 0"])
      s.add_dependency(%q<rest-client>, [">= 0"])
      s.add_dependency(%q<gcal4ruby>, [">= 0"])
    end
  else
    s.add_dependency(%q<rspec>, ["~> 2.8.0"])
    s.add_dependency(%q<bundler>, [">= 0"])
    s.add_dependency(%q<jeweler>, ["~> 1.8.4"])
    s.add_dependency(%q<cucumber>, [">= 0"])
    s.add_dependency(%q<rest-client>, [">= 0"])
    s.add_dependency(%q<gcal4ruby>, [">= 0"])
  end
end

