# XWFFmpegSDK

[![CI Status](https://img.shields.io/travis/ly-080208@163.com/XWFFmpegSDK.svg?style=flat)](https://travis-ci.org/ly-080208@163.com/XWFFmpegSDK)
[![Version](https://img.shields.io/cocoapods/v/XWFFmpegSDK.svg?style=flat)](https://cocoapods.org/pods/XWFFmpegSDK)
[![License](https://img.shields.io/cocoapods/l/XWFFmpegSDK.svg?style=flat)](https://cocoapods.org/pods/XWFFmpegSDK)
[![Platform](https://img.shields.io/cocoapods/p/XWFFmpegSDK.svg?style=flat)](https://cocoapods.org/pods/XWFFmpegSDK)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

XWFFmpegSDK is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'XWFFmpegSDK'
```

## Author

ly-080208@163.com, ly-080208@163.com

## License

XWFFmpegSDK is available under the MIT license. See the LICENSE file for more info.



#需要运行pod lib lint验证一下类库是否符合pod的要求（cd到podspec文件所在目录下）

#在提交到私有仓库的时候需要加上--use-libraries 
#--skip-import-validation 参数，lint 将跳过验证 pod 是否可以导入。

pod lib lint XWFFmpegSDK.podspec  --no-clean --verbose --allow-warnings --use-libraries --skip-import-validation

更新pod（cd到Podfile文件所在目录下）

pod update --verbose --no-repo-update 或者pod install
