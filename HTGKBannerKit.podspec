#
# Be sure to run `pod lib lint HTGKBannerKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'HTGKBannerKit'
    s.version          = '0.4.0'
    s.summary          = '简单的图片轮播图框架'
    
    # This description is used to generate tags and improve search results.
    #   * Think: What does it do? Why did you write it? What is the focus?
    #   * Try to keep it short, snappy and to the point.
    #   * Write the description between the DESC delimiters below.
    #   * Finally, don't worry about the indent, CocoaPods strips it!
    
    s.description      = <<-DESC
    这是一个简单的轮播图，现阶段还不完善，后续继续优化。
    DESC
    
    s.homepage         = 'https://github.com/YUJINHAI2015/HTGKBannerKit'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'YUJINHAI2015' => '15088132368@163.com' }
    s.source           = { :git => 'https://github.com/YUJINHAI2015/HTGKBannerKit.git', :tag => s.version.to_s }
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
    
    s.ios.deployment_target = '9.0'
    
    s.source_files = 'HTGKBannerKit/Classes/**/*'
    
    s.swift_version = '5.0'
    
    # s.resource_bundles = {
    #   'HTGKBannerKit' => ['HTGKBannerKit/Assets/*.png']
    # }
    
    # s.public_header_files = 'Pod/Classes/**/*.h'
    # s.frameworks = 'UIKit', 'MapKit'
    # s.dependency 'AFNetworking', '~> 2.3'
    s.dependency 'Kingfisher', '~> 4.10.0'
    
end
