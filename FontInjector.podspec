Pod::Spec.new do |s|
  s.name         = "FontInjector"
  s.version      = "0.0.1"
  s.summary      = "The framework that allow easy custom font installation to iOS application and also support dynamic font size."
  s.description  = "The framework that allow easy custom font installation to iOS application and also support dynamic font size."
  s.homepage     = "https://github.com/tpeodndyy/font-injector"
  s.license      = "MIT"
  s.author       = 'Peera Kerdkokaew'

  s.platform     = :ios, '9.0'
  s.source       = { :git => 'https://github.com/tpeodndyy/font-injector.git', :tag => s.version }

  s.source_files  = 'FontInjector/*.swift'
end
