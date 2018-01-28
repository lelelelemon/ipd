# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "ipd/version"

Gem::Specification.new do |spec|
  spec.name          = "ipd"
  spec.version       = Ipd::VERSION
  spec.authors       = ["junwen yang"]
  spec.email         = ["wsklxsx@126.com"]

  spec.summary       = %q{Interative Performance development tool}
  spec.description   = %q{This tool is used to help you find the performance problems in your Rails applications}
  spec.homepage      = ""
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  #spec.@files         = `git ls-@files -z`.split("\x0").reject do |f|
  #  f.match(%r{^(test|spec|features)/})
  #end
  spec.files = Dir['Rakefile', '{bin,lib,test,spec,app}/**/*', 'README*', 'LICENSE*']
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "deface", "~> 1.0"
end
