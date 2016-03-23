Pod::Spec.new do |s|
  s.name             = "FRCDataManager"
  s.version          = "0.1.0"
  s.summary          = "This is a helper library for NSFetchResultsController"
  s.description      = <<-DESC
    This pod is useful when using NSFetchresultsController, basically is an wrapper that splits the responsability of DataManager and Controller. Please Extend one of FRC Data Manger Classes that suits better for your needs.
  DESC

  s.homepage         = "https://github.com/DanielMandea/FRCDataManager.git"
  s.license          = 'MIT'
  s.author           = { "Mandea Daniel" => "daniel.mandea@yahoo.com" }
  s.source           = { :git => "https://github.com/DanielMandea/FRCDataManager.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/MandeaDaniel'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'FRCDataManager' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end