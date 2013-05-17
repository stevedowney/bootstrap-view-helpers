$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "bootstrap-view-helpers/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "bootstrap-view-helpers"
  s.version     = BootstrapViewHelpers::VERSION
  s.authors     = ["Steve Downey"]
  s.email       = ["steve.downtown@gmail.com"]
  s.homepage    = "https://github.com/stevedowney/bootstrap_view_helpers"
  s.summary     = "Rails view helpers for Bootstrap"
  s.description = "Rails view helpers for Bootstrap"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails"

  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "capybara"
  s.add_development_dependency "guard-rspec"
  s.add_development_dependency "guard-spork"
  s.add_development_dependency "sqlite3"
end
