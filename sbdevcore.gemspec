# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "sbdevcore/version"

Gem::Specification.new do |s|
  s.name        = "sbdevcore"
  s.version     = Sbdevcore::VERSION
  s.authors     = ["Adam Olsen"]
  s.email       = ["aosalias@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Core}
  s.description = %q{Core}

  s.rubyforge_project = "sbdev"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency('tinymce-rails')
  s.add_dependency('prioritizable')
  s.add_dependency('devise')
  s.add_dependency('aws-s3', :require => 'aws/s3')
  s.add_dependency('paperclip')
  s.add_dependency('haml-edge')
  s.add_dependency('rubyist-aasm', :require => 'aasm')
  s.add_dependency('sitemap_generator')
  s.add_dependency("hpricot")
end
