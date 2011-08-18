# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "core/version"

Gem::Specification.new do |s|
  s.name        = "core"
  s.version     = Core::VERSION
  s.authors     = ["Adam Olsen"]
  s.email       = ["aosalias@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Core}
  s.description = %q{Core}

  s.rubyforge_project = "sbdev-core"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
