source 'git@bitbucket.org:alterplay/alty-ios-podspecs'
source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '12.0'
use_frameworks!
inhibit_all_warnings!

def corePods
  pod 'KeychainAccess'
  pod 'Alamofire'
  pod 'AltySwiftCentrifuge'
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
