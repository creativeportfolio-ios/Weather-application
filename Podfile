# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'

def target_for_all
    use_frameworks!
    pod 'AlamofireObjectMapper'
    pod 'BrightFutures'
end

target 'Weather' do
  pod 'GoogleMaps'
  target_for_all
end

target 'WeatherTests' do
    inherit! :search_paths
    target_for_all
end

target 'WeatherUITests' do
    inherit! :search_paths
    target_for_all
end
