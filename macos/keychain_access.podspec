#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
# Run `pod lib lint keychain_access.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'keychain_access'
  s.version          = '1.0.0'
  s.summary          = 'Flutter plugin to access Keychain Access apis on MacOs.'
  s.description      = <<-DESC
Flutter plugin to access Keychain Access apis on MacOs.
                       DESC
  s.homepage         = 'http://github.com/leogps/keychain_access'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Paul Gundarapu' => 'leogps@gmail.com' }

  s.source           = { :path => '.' }
  s.source_files     = 'Classes/**/*'
  s.dependency 'FlutterMacOS'

  s.platform = :osx, '10.11'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  s.swift_version = '5.0'
end
