require_relative 'lib/twn/version'

Gem::Specification.new do |spec|
  spec.name          = "twn"
  spec.version       = Twn::VERSION
  spec.authors       = ["Jeremy Friesen"]
  spec.email         = ["jeremy.n.friesen@gmail.com"]

  spec.summary       = %q{A Traveller and Stars without Number world generator.}
  spec.description   = %q{A Traveller and Stars without Number world generator.}
  spec.homepage      = "https://sr.ht/~jeremyf/twn/"
  spec.license       = "APACHE-2.0"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://git.sr.ht/~jeremyf/twn"
  spec.metadata["changelog_uri"] = "https://git.sr.ht/~jeremyf/twn/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "byebug"
  spec.add_development_dependency "rake", "~> 12.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
