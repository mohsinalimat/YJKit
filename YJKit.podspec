#
# Be sure to run `pod lib lint YJKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|

  s.name             = "YJKit"
  s.version          = "0.1.63"
  s.license          = 'MIT'
  s.summary          = "YJKit is a simple wrapper for iOS library."
  s.homepage         = "https://github.com/huang-kun/YJKit"
  s.author           = { "huang-kun" => "jack-huang-developer@foxmail.com" }
  s.source           = { :git => "https://github.com/huang-kun/YJKit.git", :tag => s.version.to_s }

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'YJKit/**/*'
  s.public_header_files = 'YJKit/**/*.h'

end
