# Uncomment the next line to define a global platform for your project
platform :ios, '15.0'
flutter_application_path = 'native_in_fluter'
load File.join(flutter_application_path, '.ios', 'Flutter', 'podhelper.rb')

target 'native_in_flutter_in_native' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  install_all_flutter_pods(flutter_application_path)


  # Pods for native_in_flutter_in_native
  post_install do |installer|
  flutter_post_install(installer) if defined?(flutter_post_install)
  end


end
