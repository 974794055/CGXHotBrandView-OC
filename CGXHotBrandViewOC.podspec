Pod::Spec.new do |s|
s.name         = "CGXHotBrandViewOC"    #存储库名称
s.version      = "0.0.6"      #版本号，与tag值一致
s.summary      = "CGXHotBrandViewOC是基于UICollectionView封装的热门菜单库"  #简介
s.description  = "UICollectionView封装的热门菜单库"  #描述
s.homepage     = "https://github.com/974794055/CGXHotBrandView-OC"      #项目主页，不是git地址
s.license      = { :type => "MIT", :file => "LICENSE" }   #开源协议
s.author             = { "974794055" => "974794055@qq.com" }  #作者
s.platform     = :ios, "8.0"                  #支持的平台和版本号
s.source       = { :git => "https://github.com/974794055/CGXHotBrandView-OC.git", :tag => s.version }         #存储库的git地址，以及tag值
s.requires_arc = true #是否支持ARC
s.frameworks = 'UIKit'

#需要托管的源代码路径
s.source_files = 'CGXHotBrandViewOC/CGXHotBrandViewOC.h'
#开源库头文件
s.public_header_files = 'CGXHotBrandViewOC/CGXHotBrandViewOC.h'

s.subspec 'Custom' do |ss|
   ss.source_files = 'CGXHotBrandViewOC/Custom/**/*.{h,m}'
end
s.subspec 'PageControl' do |ss|
   ss.source_files = 'CGXHotBrandViewOC/PageControl/**/*.{h,m}'
   ss.dependency 'CGXHotBrandViewOC/Custom'
end
s.subspec 'Base' do |ss|
   ss.source_files = 'CGXHotBrandViewOC/Base/**/*.{h,m}'
   ss.dependency 'CGXHotBrandViewOC/Custom'
   ss.dependency 'CGXHotBrandViewOC/PageControl'
end
s.subspec 'HotBrand' do |ss|
   ss.source_files = 'CGXHotBrandViewOC/HotBrand/**/*.{h,m}'
   ss.dependency 'CGXHotBrandViewOC/Base'
   ss.dependency 'CGXHotBrandViewOC/PageControl'
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




