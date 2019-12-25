Pod::Spec.new do |spec|
  spec.name         = "CBHCore"
  spec.version      = "0.0.1"
  spec.summary      = "CBHCore is pod with shared core functionality"
  spec.description  = "extracted base functionality"

  spec.homepage     = "https://bitbucket.org/product/"
  spec.license      = { :type => "MIT", :text => "" }
  spec.author             = { "Serhii Horielov" => "s.horielov@alterplay.com" }

  spec.platform      = :ios, "12.0"
  spec.swift_version = '5.0'

  spec.source       = { :git => "https://s_horielov@bitbucket.org/cbh-core-ios.git", :tag => "#{spec.version}" }
  spec.source_files  = "Sources", "Sources/**/*.{h,m,swift}"

  spec.dependency 'SwiftCentrifuge'
  spec.dependency 'Alamofire'
  spec.dependency 'KeychainAccess'
end
