Gem::Specification.new do |s|
   s.name          = 'kele'
   s.version       = '0.0.1'
   s.date          = '2017-02-04'
   s.summary       = 'Kele API Client'
   s.description   = 'A client for the Bloc API'
   s.authors       = ['Minh Nguyen']
   s.email         = 'nguyen_ba_minh@yahoo.com'
   s.files         = `git ls-files "lib/*.rb"`.split($/)
   s.require_paths = ["lib"]
   s.homepage      = 'http://rubygems.org/gems/kele'
   s.license       = 'MIT'
   s.add_runtime_dependency 'httparty', '~> 0.13'
 end
