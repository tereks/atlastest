source 'https://github.com/CocoaPods/Specs.git'

workspace 'Snoop'
platform :ios, '13.0'

def resourceGen
    pod 'R.swift'
end

def dependencyManager
    pod 'Dip'
end

def database
    pod 'RealmSwift'
end

def autolayout
    pod 'TinyConstraints'
end

target 'Snoop' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  resourceGen
  dependencyManager
  database
  autolayout

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
    end
  end
end
