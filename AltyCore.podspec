Pod::Spec.new do |spec|
  spec.name         = "AltyCore"
  spec.version      = "0.0.15"
  spec.summary      = "extracted base functionality"
  spec.description  = "AltyCore is pod with shared core functionality"

  spec.homepage     = "https://bitbucket.org/alterplay/alty-ios-core/src/develop/"
  spec.license      = { :type => "MIT", :text => "" }
  spec.author       = { "Serhii Horielov" => "s.horielov@alterplay.com" }

  spec.platform      = :ios, "12.0"
  spec.swift_version = '5.0'

  spec.source        = { :git => "git@bitbucket.org:alterplay/alty-ios-core.git", :tag => "#{spec.version}" }
  spec.source_files  = "AltyCore", "AltyCore/**/*.{h,m,swift}"

  # Networking
  spec.dependency 'Alamofire'
  spec.dependency 'AltySwiftCentrifuge'
  
  # Tools
  spec.dependency 'KeychainAccess'
  
  #DI
  spec.dependency 'Swinject', '2.6.2'
  spec.dependency 'SwinjectStoryboard'
end
