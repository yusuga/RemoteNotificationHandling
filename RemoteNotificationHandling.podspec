Pod::Spec.new do |s|
  s.name             = 'RemoteNotificationHandling'
  s.version          = '0.0.1'
  s.summary          = 'RemoteNotificationHandling does the processing required for remote notification.'
  s.homepage         = 'https://github.com/yusuga/RemoteNotificationHandling'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'yusuga' => 'dev@yusuga.com' }
  s.source           = { :git => 'https://github.com/yusuga/RemoteNotificationHandling.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/yusuga_'

  s.ios.deployment_target = '8.0'

  s.source_files = 'RemoteNotificationHandling/Classes/**/*'  
end
