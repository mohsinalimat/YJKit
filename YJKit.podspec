#
# Be sure to run `pod lib lint YJKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "YJKit"
  s.version          = "0.1.26"
  s.license          = 'MIT'
  s.summary          = "YJKit is a simple wrapper for iOS library."
  s.homepage         = "https://github.com/huang-kun/YJKit"
  s.author           = { "huang-kun" => "jack-huang-developer@foxmail.com" }
  s.source           = { :git => "https://github.com/huang-kun/YJKit.git", :tag => s.version.to_s }

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'YJKit/**/*'
  s.public_header_files = 'YJKit/YJKit.h'
  s.frameworks = 'UIKit', 'Foundation', 'CoreGraphics', 'AVFoundation'

  s.cocoapods_version = '>= 0.36'


pch_YJ = <<-EOS
#ifndef TARGET_OS_IOS
    #define TARGET_OS_IOS TARGET_OS_IPHONE
#endif
#ifndef TARGET_OS_WATCH
    #define TARGET_OS_WATCH 0
#endif
#ifndef TARGET_OS_TV
    #define TARGET_OS_TV 0
#endif
EOS
  s.prefix_header_contents = pch_YJ


#  s.subspec 'ExeMacros' do |ems|
#    ems.name = 'EXE_YJ'
#    ems.source_files = 'YJKit/Base/Macros/YJExecutionMacros.h'
#  end

#  s.subspec 'UIKit' do |uis|
#    uis.name = 'UIKit_YJ'
#    uis.source_files = 'YJKit/Base/**/*'
#  end

end
