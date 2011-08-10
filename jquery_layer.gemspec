# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "jquery_layer/version"

Gem::Specification.new do |s|
  s.name        = "jquery_layer"
  s.version     = JqueryLayer::VERSION
  s.authors     = ["pkw.de dev team"]
  s.email       = ["dev@pkw.de"]
  s.homepage    = ""
  s.summary     = %q{jQuery layer builder}
  s.description = %q{Build jQuery layers from within rails applications}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.add_dependency "activesupport", ">= 3.0"
  s.add_dependency "actionpack", ">= 3.0"
  s.add_dependency "railties", ">= 3.0"
  s.add_dependency "rack", ">= 1.2.1"
  s.add_development_dependency "rake"
  s.add_development_dependency "test-unit"
end
