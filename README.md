# TexturedMaaku

[![Build Status](https://travis-ci.org/KristopherGBaker/TexturedMaaku.svg?branch=master)](https://travis-ci.org/KristopherGBaker/TexturedMaaku)
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/TexturedMaaku.svg)](https://img.shields.io/cocoapods/v/TexturedMaaku.svg)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Platform](https://img.shields.io/cocoapods/p/TexturedMaaku.svg?style=flat)](http://cocoadocs.org/docsets/TexturedMaaku)

Native iOS CommonMark rendering framework in Swift using [Texture](http://texturegroup.org/) and [Maaku](https://github.com/KristopherGBaker/Maaku).

TexturedMaaku also supports plugins based on Maaku plugins. One plugin is provided as an example.

+ [Installation](#installation)
+ [Core](#core)
+ [Style](#core)
+ [Plugins](#plugins)
+ [Demo](#demo)

## Installation

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

To integrate TexturedMaaku into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
use_frameworks!

target '<Your Target Name>' do
pod 'TexturedMaaku'
end
```

Then, run the following command:

```bash
$ pod install
```

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

To integrate Maaku into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "KristopherGBaker/TexturedMaaku" ~> 0.1.0
```

Run `carthage update` to build the framework and drag the built `Maaku.framework` into your Xcode project.

## Core

`DocumentNode` and `DocumentViewController` are the primary types for using Maaku. An example of using `DocumentViewController` is provided in the demo project.


## Style

Style settings for fonts, colors, insets, etc can be set using the `DocumentStyle` type and passed to `DocumentNode` or `DocumentViewController`.

## Plugins

TexturedMaaku plugins are built on top of Maaku plugins. One example plugin is provided.

## Demo

Open and run the demo project (`TexturedMaakuDemo/TexturedMaakuDemo.xcworkspace`) to see examples of using the framework.
