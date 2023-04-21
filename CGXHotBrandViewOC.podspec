Pod::Spec.new do |s|
s.name         = "CGXHotBrandViewOC"
s.version      = "1.0"
s.summary      = "CGXHotBrandViewOC是基于UICollectionView封装的热门菜单库"
s.description  = "UICollectionView封装的热门菜单库,水平菜单库"
s.homepage     = "https://github.com/974794055/CGXHotBrandView-OC"
s.license      = { :type => "MIT", :file => "LICENSE" }
s.author             = { "974794055" => "974794055@qq.com" }
s.platform     = :ios, "9.0"
s.source       = { :git => "https://github.com/974794055/CGXHotBrandView-OC.git", :tag => s.version }
s.requires_arc = true
s.frameworks = 'UIKit'
#需要托管的源代码路径
s.source_files = 'CGXHotBrandViewOC/CGXHotBrandViewOC.h'
#开源库头文件
s.public_header_files = 'CGXHotBrandViewOC/CGXHotBrandViewOC.h'

s.subspec 'Custom' do |ss|
  ss.source_files = 'CGXHotBrandViewOC/Custom/**/*.{h,m}'
end
s.subspec 'BPageControl' do |ss|
  ss.source_files = 'CGXHotBrandViewOC/BPageControl/**/*.{h,m}'
  ss.dependency 'CGXHotBrandViewOC/Custom'
end
s.subspec 'Base' do |ss|
  ss.source_files = 'CGXHotBrandViewOC/Base/**/*.{h,m}'
  ss.dependency 'CGXHotBrandViewOC/Custom'
  ss.dependency 'CGXHotBrandViewOC/BPageControl'
end
s.subspec 'BIndicator' do |ss|
  ss.source_files = 'CGXHotBrandViewOC/BIndicator/**/*.{h,m}'
  ss.dependency 'CGXHotBrandViewOC/Custom'
  ss.dependency 'CGXHotBrandViewOC/Base'
end
s.subspec 'HotBrand' do |ss|
  ss.source_files = 'CGXHotBrandViewOC/HotBrand/**/*.{h,m}'
  ss.dependency 'CGXHotBrandViewOC/Base'
end
s.subspec 'Cycle' do |ss|
  ss.source_files = 'CGXHotBrandViewOC/Cycle/**/*.{h,m}'
  ss.dependency 'CGXHotBrandViewOC/Base'
end
s.subspec 'Card' do |ss|
  ss.source_files = 'CGXHotBrandViewOC/Card/**/*.{h,m}'
  ss.dependency 'CGXHotBrandViewOC/Base'
end
s.subspec 'Zoom' do |ss|
  ss.source_files = 'CGXHotBrandViewOC/Zoom/**/*.{h,m}'
  ss.dependency 'CGXHotBrandViewOC/Base'
end
s.subspec 'Scroll' do |ss|
  ss.source_files = 'CGXHotBrandViewOC/Scroll/**/*.{h,m}'
  ss.dependency 'CGXHotBrandViewOC/Base'
end
s.subspec 'Rotary' do |ss|
  ss.source_files = 'CGXHotBrandViewOC/Rotary/**/*.{h,m}'
  ss.dependency 'CGXHotBrandViewOC/Base'
end
s.subspec 'Slider' do |ss|
  ss.source_files = 'CGXHotBrandViewOC/Slider/**/*.{h,m}'
  ss.dependency 'CGXHotBrandViewOC/Base'
end
s.subspec 'Cover' do |ss|
  ss.source_files = 'CGXHotBrandViewOC/Cover/**/*.{h,m}'
  ss.dependency 'CGXHotBrandViewOC/Base'
end

end




