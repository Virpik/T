#
#  Be sure to run `pod spec lint T.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
    
  s.name         = "T"
  s.version      = "0.1.0"
  s.summary      = "A short description of T."

  s.description  = <<-DESC
                    Set of add-ons for ios development
                    
                   DESC

  s.homepage     = "https://github.com/virpik/T"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"

  s.license      = "MIT"
  # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }

  s.author             = { "Virpik" => "vvirpik@gmail.com" }
  s.social_media_url   = "http://github.com/virpik"

  # s.platform     = :ios
  # s.platform     = :ios, "5.0"

  #  When using multiple platforms
  # s.ios.deployment_target = "5.0"
  # s.osx.deployment_target = "10.7"
  # s.watchos.deployment_target = "2.0"
  # s.tvos.deployment_target = "9.0"

  s.source       = { :git => "http://github/Virpik/T.git", :tag => "#{s.version}" }
    # s.source_files  = "src/**/*.swift"

    s.subspec 'CoreData' do |s|
        s.source_files = "src/CoreData/**/*.swift"
    end

    s.subspec 'UI' do |s|
        s.source_files = "src/UI/**/*.swift"
    end

    s.subspec 'CoreGraphics' do |s|
        s.source_files = "src/CoreGraphics/**/*.swift"
    end

    s.subspec 'Foundation' do |s|
        s.source_files = "src/Foundation/**/*.swift"
    end
end




