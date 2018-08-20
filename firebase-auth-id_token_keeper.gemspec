lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'firebase/auth/id_token_keeper/version'

Gem::Specification.new do |spec|
  spec.name          = 'firebase-auth-id_token_keeper'
  spec.version       = Firebase::Auth::IDTokenKeeper::VERSION
  spec.authors       = ['Rui Onodera']
  spec.email         = ['deraru@gmail.com']

  spec.summary       = 'Verify the Firebase ID Token which obtained at the client side.'
  spec.description   = 'Firebase Authentication uses ID Token. This gem verify the token on the server side.'
  spec.homepage      = 'https://github.com/Findy/firebase-auth-id_token_keeper'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'jwt', '>= 1.5.6'
  spec.add_dependency 'activesupport', '>= 5.1.0'

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
