$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "bootstrap-view-helpers/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "bootstrap-view-helpers"
  s.version     = BootstrapViewHelpers::VERSION
  s.authors     = ["Steve Downey"]
  s.email       = ["steve.downtown@gmail.com"]
  s.homepage    = "https://github.com/stevedowney/bootstrap-view-helpers"
  s.summary     = "Rails view helpers for Bootstrap"
  s.description = "Rails view helpers for Bootstrap"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails"
  s.add_dependency "jquery-rails"
  
  s.add_development_dependency 'sass-rails', '~> 3.2'
  s.add_development_dependency 'bootstrap-sass', '~> 2.3.1.0'
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "capybara"
  s.add_development_dependency "guard-rspec"
  s.add_development_dependency "guard-spork"
  s.add_development_dependency "sqlite3"
  s.add_development_dependency 'better_errors'
  s.add_development_dependency "yard"
  s.add_development_dependency "redcarpet"
  s.add_development_dependency 'quiet_assets'
  s.add_development_dependency 'thin'
end
