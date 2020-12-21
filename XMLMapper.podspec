#
# Be sure to run `pod lib lint XMLMapper.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'XMLMapper'
  s.version          = '2.0.0'
  s.summary          = 'A simple way to map XML to Objects written in Swift'

  s.homepage         = 'https://github.com/gcharita/XMLMapper'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'gcharita' => 'chgiorgos13@gmail.com' }
  s.source           = { :git => 'https://github.com/gcharita/XMLMapper.git', :tag => s.version.to_s }

  s.watchos.deployment_target = '2.0'
  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.9'
  s.tvos.deployment_target = '9.0'

  s.swift_version = '5.0'

  s.default_subspec = 'Core'

  s.subspec 'Core' do |core|
    core.source_files = 'XMLMapper/Classes/**/*'
    core.exclude_files = 'XMLMapper/Classes/Requests'
  end

  s.subspec 'Requests' do |requests|
    requests.watchos.deployment_target = '3.0'
    requests.ios.deployment_target = '10.0'
    requests.osx.deployment_target = '10.12'
    requests.tvos.deployment_target = '10.0'
    requests.source_files = 'XMLMapper/Classes/Requests/'
    requests.dependency 'XMLMapper/Core'
    requests.dependency 'Alamofire', '~> 5.4'
  end
end
