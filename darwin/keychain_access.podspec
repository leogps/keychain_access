#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
# Run `pod lib lint keychain_access.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'keychain_access'
  s.version          = '1.0.4'
  s.summary          = 'Flutter plugin to access Keychain Access apis on MacOs & iOs.'
  s.description      = <<-DESC
Flutter plugin to access Keychain Access apis on MacOs & iOs.
                       DESC
  s.homepage         = 'https://github.com/leogps/keychain_access'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Paul Gundarapu' => 'leogps@gmail.com' }

  s.source           = { :path => '.' }
  s.source_files     = 'Classes/**/*'
  s.ios.dependency 'Flutter'
  s.osx.dependency 'FlutterMacOS'
  s.ios.deployment_target = '11.0'
  s.osx.deployment_target = '10.14'

  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  s.swift_version = '5.0'
end
