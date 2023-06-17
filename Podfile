# Uncomment the next line to define a global platform for your project
 platform :ios, '14.0'

 def install_pods
   pod 'Firebase/Core'
   pod 'Firebase/Firestore'
   pod 'Firebase/Database'
   pod 'Firebase/Analytics'
   pod 'LicensePlist'
 end

 target 'KoarasSimonSaysGame' do
   # Comment the next line if you don't want to use dynamic frameworks
   use_frameworks!
   install_pods
 end
 

 target 'KoarasSimonSaysGameDEVELOP' do
   use_frameworks!
   install_pods

   # unitTest用に以下の設定が必要
   target  'KoarasSimonSaysGameTests' do
   	inherit! :search_paths
        pod 'Firebase'
   end

  post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.0'
      end
    end
  end

 end