
Pod::Spec.new do |s|
  s.name         = "AZEmptyState"
  s.version      = "1.0.0"
  s.summary      = "An easy way to create empty states."
  s.homepage     = "https://github.com/Minitour/AZEmptyState"
  s.license      = "MIT"
  s.author       = { "Antonio Zaitoun" => "tony.z.1711@gmail.com" }
  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/Minitour/AZEmptyState.git", :tag => "#{s.version}" }
  s.source_files  = "Sources/*.swift"
end
