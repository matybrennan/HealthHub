#
# Be sure to run `pod lib lint MBHealthTracker.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MBHealthTracker'
  s.version          = '0.0.11'
  s.summary          = 'MBHealthTracker is used for healthData'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'Framework that simplifies the use of apples HealthKit'

  s.homepage         = 'https://github.com/matybrennan/MBHealthTracker'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'matybrennan' => 'matybrennan@gmail.com' }
  s.source           = { :git => 'https://github.com/matybrennan/MBHealthTracker.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'

  s.source_files = 'MBHealthTracker/Classes/**/*'
  
  # s.resource_bundles = {
  #   'MBHealthTracker' => ['MBHealthTracker/Assets/*.png']
  # }
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '5.0' }
  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
