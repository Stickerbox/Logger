Pod::Spec.new do |s|

s.platform = :ios
s.ios.deployment_target = '10.0'
s.name = "Logger"
s.summary = "A logging framework for iOS, written in Swift"
s.requires_arc = true

s.version = "0.1.0"

s.license = { :type => "MIT", :file => "LICENSE" }

s.author = { "Jordan Dixon" => "jordan.d@me.com" }

s.homepage = "https://github.com/Stickerbox/Logger"

s.source = { :git => "https://github.com/Stickerbox/Logger.git", :tag => "#{s.version}"}

s.framework = "UIKit"

s.source_files = "Logger/**/*.{swift}"

end