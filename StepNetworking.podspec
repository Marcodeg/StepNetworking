
Pod::Spec.new do |s|
  s.name             = 'StepNetworking'
  s.version          = '0.1.1'
  s.summary          = 'Easy async/await networking in swift'
  s.description      = 'Easy async/await http request in swift'
  s.homepage         = 'https://github.com/Marcodeg/StepNetworking'
  s.license          = { 
	:type => 'MIT',
	:file => 'LICENSE'
  }
  s.author           = { 'Marco Del Giudice' => 'm.delgiudice@outlook.it' }
  s.source           = { 
	:git => 'https://github.com/Marcodeg/StepNetworking.git',
	:tag => s.version.to_s 
  }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
  s.ios.deployment_target = '15.0'
  s.swift_versions = ['5.0', '5.1', '5.3', '5.4', '5.5']
  s.framework = 'Foundation'
  s.source_files = 'Sources/StepNetworking/**/*'
end
