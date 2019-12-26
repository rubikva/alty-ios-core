Pod::Spec.new do |spec|
  spec.name         = "AltyCore"
  spec.version      = "0.0.3"
  spec.summary      = "AltyCore is pod with shared core functionality"
  spec.description  = "extracted base functionality"

  spec.homepage     = "https://bitbucket.org/alterplay/cbh-cards-ios/src/develop/"
  spec.license      = { :type => "MIT", :text => "" }
  spec.author             = { "Serhii Horielov" => "s.horielov@alterplay.com" }

  spec.platform      = :ios, "12.0"
  spec.swift_version = '5.0'

  spec.source       = { :git => "https://bitbucket.org/alterplay/alty-ios-core.git", :tag => "#{spec.version}" }
  spec.source_files  = "AltyCore", "AltyCore/**/*.{h,m,swift}"

  spec.dependency 'Alamofire'
  spec.dependency 'KeychainAccess'
end
