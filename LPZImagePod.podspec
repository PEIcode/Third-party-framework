
Pod::Spec.new do |s|

  s.name         = "LPZImagePod"
  s.version      = "0.0.1"
  s.summary      = "This is a cocoaPods for LPZ."

  s.description  = <<-DESC
                   This is a attempt that i must to write somesthing to resovel questtion! So i hope that i can pass the error
                   DESC

  s.homepage     = "https://github.com/PEIcode/Third-party-framework"
  s.license      = "Copyright (c) 2018年 Lisa. All rights reserved."
  s.author       = { "Pei丶Code" => "aishiklpz@163.com" }

  s.source       = { :git => "https://github.com/PEIcode/Third-party-framework.git", :tag => "#{s.version}" }

  s.source_files  = "Third-party-framework", "Third-party-framework/**/*.{h,m}"
  s.exclude_files = "Classes/Exclude"

end
