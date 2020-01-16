source 'git@bitbucket.org:alterplay/alty-ios-podspecs'
source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '12.0'
use_frameworks!
inhibit_all_warnings!

def corePods
  # DI
  pod 'Swinject', '2.6.2'
  pod 'SwinjectStoryboard'

  # Networking
  pod 'Alamofire'
	pod 'SwiftCentrifuge', :git => 'https://github.com/Alterplay/centrifuge-swift'

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
