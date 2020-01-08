platform :ios, '12.0'
use_frameworks!
inhibit_all_warnings!

def corePods
  pod 'KeychainAccess'
  pod 'Alamofire'
  pod 'SwiftCentrifuge'
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
