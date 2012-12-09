# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
	s.files = `git ls-files`.split("\n")
	s.name = "has_my_secure_password"
	s.platform = Gem::Platform::RUBY
	s.summary = "A plugin for implement secure password authentication in your model with bcrypt."
	s.homepage = "https://github.com/jonathantribouharet/has_my_secure_password"
	s.require_paths = ["lib"]
	s.version = "1.0"
	s.author = "Jonathan TRIBOUHARET"
	s.email = "jonathan.tribouharet@gmail.com"
	
	s.add_runtime_dependency('bcrypt-ruby')
end