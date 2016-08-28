#
# Be sure to run `pod lib lint SHViewPager.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SHViewPager'
  s.version          = '2.0.0'
  s.summary          = 'A simple view pager for iOS. Compatible with iOS 8.0 or later.'
  s.description      = <<-DESC
A simple view pager for iOS. Compatible with iOS 8.0 or later, that imitates the view pager vastly used on android apps.
                       DESC

  s.homepage         = 'https://github.com/shabib87/SHViewPager'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Ahmad Shabibul Hossain' => 'shabib.sust@gmail.com' }
  s.source           = { :git => 'https://github.com/shabib87/SHViewPager.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/shabib_hossain'

  s.ios.deployment_target = '8.0'
  s.requires_arc        = true

  s.source_files = 'SHViewPager/Classes/**/*'
  
  s.resource_bundles = {
     'SHViewPager' => 'Pod/**/*.xib'
  }

  s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit', 'Foundation'
end
