Gem::Specification.new do |spec|
    spec.name             = "kipatra"
    spec.version          = "0.1.1"
    spec.authors          = [ "Dominique Broeglin" ]
    spec.description      = 'Cipango powered Sipatra server'
    spec.summary          = 'Sipatra server powered by Cipango'
    spec.email            = 'dominique.broeglin@gmail.com'
    spec.executables      = [ "kipatra" ]

    spec.files            = `git ls-files -- lib/*`.split("\n")
    spec.files           += ["LICENSES"]
    spec.test_files       = `git ls-files -- {spec}/*`.split("\n")
    spec.bindir           = 'bin'
    spec.executables      = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
    spec.extra_rdoc_files = [ "README.md", "LICENSES"]
    spec.rdoc_options     = ["--charset=UTF-8"]
    spec.require_path     = "lib"
    spec.homepage         = 'http://github.com/dbroeglin/kipatra'
    spec.has_rdoc         = false
    spec.rubygems_version = '>= 1.3.6'

    spec.add_development_dependency "rspec", ">= 2.0.0"
end
