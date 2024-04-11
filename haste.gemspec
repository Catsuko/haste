Gem::Specification.new do |s|
  s.name        = 'haste'
  s.authors     = 'Lewis Reid'
  s.version     = '0.0.1'
  s.summary     = 'Quick progress bars for simple projects.'

  s.require_paths = 'lib'
  s.files         = Dir.glob('{lib}/**/*')

  s.required_ruby_version = '>= 3.0'

  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rubocop'
  s.add_development_dependency 'rubocop-rspec'
end
