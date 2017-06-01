use_frameworks!
inhibit_all_warnings!
platform :ios, '10.3'

def pods
    pod 'SnapKit', '~> 3.2'
    pod 'ReactiveCocoa', '~> 5.0'
    
    pod 'Crashlytics', '~> 3.8'
    pod 'HockeySDK', '~> 4.1'

end

target 'crash-reporting-demo' do
    pods
end

target 'Framework' do
    inherit! :search_paths
    pods
end
