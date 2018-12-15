Pod::Spec.new do |s|

  s.name         = "TexturedMaaku"
  s.version      = "0.5.0"
  s.summary      = "Native iOS CommonMark rendering in Swift using Texture and Maaku"

  s.description  = <<-DESC
                   Native iOS CommonMark rendering in Swift using Texture (AsyncDisplayKit) and Maaku.
                   DESC

  s.homepage     = "https://github.com/KristopherGBaker/TexturedMaaku"
  s.license      = "MIT"
  s.author             = { "Kristopher Baker" => "Kristopher Baker" }
  s.ios.deployment_target = "9.0"
  s.source       = { :git => "https://github.com/KristopherGBaker/TexturedMaaku.git", :tag => "#{s.version}" }
  s.requires_arc = true
  s.default_subspec = 'Core'
  
  s.subspec 'Core' do |core|
      core.source_files = "Sources/Core/**/*.swift"
      core.dependency 'Maaku/Core'
      core.dependency 'Texture'
  end

  s.subspec 'Plugins' do |plugins|
      plugins.source_files = "Sources/Plugins/**/*.swift"
      plugins.dependency 'Maaku/Plugins'
      plugins.dependency 'TexturedMaaku/Core'
      plugins.dependency 'youtube-ios-player-helper'
  end
  
  s.subspec 'SyntaxColors' do |syntax|
      syntax.dependency 'Highlightr'
      syntax.xcconfig = {
          'OTHER_SWIFT_FLAGS' => '$(inherited) -DTEXTURED_MAAKU_SYNTAX_COLORS',
          'GCC_PREPROCESSOR_DEFINITIONS' => '$(inherited) TEXTURED_MAAKU_SYNTAX_COLORS=1'
      }
  end

end
