source 'https://github.com/CocoaPods/Specs.git'

inhibit_all_warnings!
use_frameworks!

abstract_target 'TexturedMaakuTargets' do
  pod 'Highlightr', :git => 'https://github.com/raspu/Highlightr.git', :branch => 'master'
  pod 'Maaku/CMark'
  pod 'Maaku/Core'
  pod 'Maaku/Plugins'
  pod 'SwiftLint'
  pod 'Texture'
  pod 'youtube-ios-player-helper'

  target 'TexturedMaaku' do
    platform :ios, '9.0'
  end
  
  target 'TexturedMaakuSyntaxColors' do
    platform :ios, '9.0'
  end

  target 'TexturedMaakuTests' do
    platform :ios, '9.0'

    pod 'Nimble'
    pod 'Quick'
  end
end
