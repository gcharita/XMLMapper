#
# Be sure to run `pod lib lint XMLMapper.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'XMLMapper'
  s.version          = '0.1.0'
  s.summary          = 'A simple way to map XML to Objects written in Swift'

  s.homepage         = 'https://github.com/gcharita/XMLMapper'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'gcharita' => 'chgiorgos13@gmail.com' }
  s.source           = { :git => 'https://github.com/gcharita/XMLMapper.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'XMLMapper/Classes/**/*'

  s.dependency 'XMLDictionary', '~> 1.4'
end
