#
# Be sure to run `pod lib lint FRCDataManager.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'FRCDataManager'
  s.version          = '1.1.9'
  s.summary          = 'Swift library that enhences work with NSFetchResultsController.'
  s.description      = <<-DESC
Powerfull pod library that enhances work with NSFetchresultsController, contains multiple extensions and protocol that simplifies work with NSFetchresultsController, also splits the responsability of DataManager and Controller. Extend BaseDataManger as described in the example project and have fun!.
                       DESC

  s.homepage         = 'https://github.com/DanielMandea/FRCDataManager'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'DanielMandea' => 'daniel.mandea@ro.ibm.com' }
  s.source           = { :git => 'https://github.com/DanielMandea/FRCDataManager.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/MandeaDaniel'
  s.platform        = :ios, "12.0"
  s.swift_version   = "5.1"
  s.source_files = 'FRCDataManager/Classes/**/*'
end
