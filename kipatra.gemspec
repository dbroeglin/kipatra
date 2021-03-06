# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "kipatra/version"

Gem::Specification.new do |spec|
    spec.name             = "kipatra"
    spec.version          = Kipatra::VERSION
    spec.authors          = [ "Dominique Broeglin", "Alexandre Moutot" ]
    spec.description      = 'Cipango powered Sipatra server'
    spec.summary          = 'Sipatra server powered by Cipango'
    spec.email            = ['dominique.broeglin@gmail.com', 'alexscottt@gmail.com']
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

    spec.add_development_dependency "sipatra", ">= 0.1.0"
    spec.add_development_dependency "rspec", ">= 2.0.0"
end
