source 'git@bitbucket.org:alterplay/alty-ios-podspecs'
source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '12.0'
use_frameworks!
inhibit_all_warnings!

def corePods
  # DI
  pod 'Swinject'
  pod 'SwinjectStoryboard', :git => 'https://github.com/Swinject/SwinjectStoryboard.git', :branch => 'master'

  # Networking
  pod 'Alamofire'
	pod 'AltySwiftCentrifuge'

  # Tools
	pod 'KeychainAccess'

end

target 'AltyCore' do
  corePods
end

target 'AltyCoreTests' do
  inherit! :search_paths
  
  corePods
  
  pod 'Nimble'
  pod 'InstantMock'
end
