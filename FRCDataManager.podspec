#
# Be sure to run `pod lib lint FRCDataManager.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'FRCDataManager'
  s.version          = '0.3.5'
  s.summary          = 'Swift library that enhences work with NSFetchResultsController.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Powerfull pod library that enhances work with NSFetchresultsController, contains multiple extensions and protocol that simplifies work with NSFetchresultsController, also splits the responsability of DataManager and Controller. Extend BaseDataManger as described in the example project and have fun!.
                       DESC

  s.homepage         = 'https://github.com/DanielMandea/FRCDataManager'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'DanielMandea' => 'daniel.mandea@ro.ibm.com' }
  s.source           = { :git => 'https://github.com/DanielMandea/FRCDataManager.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/MandeaDaniel'

  s.ios.deployment_target = '9.0'

  s.source_files = 'FRCDataManager/Classes/**/*'
  
  # s.resource_bundles = {
  #   'FRCDataManager' => ['FRCDataManager/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
