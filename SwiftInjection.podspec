Pod::Spec.new do |s|
    s.name = 'Binder'
    s.version = '0.1'
    s.summary = 'A ui binder for UIKit elements'
    s.homepage = 'https://github.com/aryaxt/Binder'
    s.license = {
      :type => 'MIT',
      :file => 'License.txt'
    }
    s.author = {'Aryan Ghassemi' => 'https://github.com/aryaxt/Binder'}
    s.source = {:git => 'https://github.com/aryaxt/Binder.git', :tag => '0.1'}
    s.platform = :ios, '8.0'
    s.source_files = 'Binder/Source/*.{swift}'
    s.framework = 'Foundation'
    s.requires_arc = true
end
