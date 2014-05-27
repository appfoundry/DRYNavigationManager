Pod::Spec.new do |s|
  s.name             = "DRYNavigationManager"
  s.version          = "0.1.1"
  s.summary          = "Navigation manager to separate navigation logic from you core app code, when not using StoryBoards."
  s.description      = <<-DESC
                       In StoryBoard-less projects, this small framework should help out in separating the navigation code from the actual view controller code, much like segues enable this when using story boards.
                       DESC
  s.homepage         = "http://bitbucket.org/idamediafoundry/drynavigationmanager"
  s.license          = 'MIT'
  s.author           = { "Michael Seghers" => "michael.seghers@ida-mediafoundry.be", "Bart Vandeweerdt" => "bart.vandeweerdt@ida-mediafoundry.be" }
  s.source           = { :git => "https://bitbucket.org/idamediafoundry/drynavigationmanager.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/iDAMediaFoundry'

  s.platform     = :ios, '5.0'
  s.ios.deployment_target = '5.0'
  # s.osx.deployment_target = '10.7'
  s.requires_arc = true

  s.source_files = 'Classes'
  # s.resources = 'Assets/*.png'

  # s.public_header_files = 'Classes/**/*.h'
end
