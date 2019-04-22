# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Flick' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  pod 'SwiftLint', '~> 0.27'
  pod 'Then', '~> 2.4.0'
  pod 'SwiftGen'
  pod 'SwiftyBeaver'
  pod 'XMLParsing'
  pod 'Fabric'
  pod 'Crashlytics'
  # Pods for Flick

  def testing_pods
    pod 'Quick', '~> 1.3'
    pod 'Nimble', '~> 7.3'
    # TODO: Move carthage
  end
  target 'FlickTests' do
    inherit! :search_paths
    # Pods for testing
    testing_pods
  end
end
