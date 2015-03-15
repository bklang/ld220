# encoding: utf-8
$:.push File.expand_path("../lib", __FILE__)
require "ld220/version"

Gem::Specification.new do |s|
  s.name        = "ld220"
  s.version     = LD220::VERSION
  s.authors     = ["Ben Klang"]
  s.email       = ["bklang@mojolingo.com"]
  s.homepage    = ""
  s.summary     = %q{Interface to LD220 Point-of-Sale Display}
  s.description = %q{This gem provides an interface and helper functions for displaying messages on LD220 Point-of-Sale displays (eg. HP POS Pole Displays)}
  s.license     = 'MIT'

  s.rubyforge_project = "ld220"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ["lib"]

  s.add_runtime_dependency %q<rubyserial>

  s.add_development_dependency %q<pry>
 end
