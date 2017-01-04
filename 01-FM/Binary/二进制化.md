## 二进制化

### 静态库-动态库

详情见 [静态库-动态库](https://github.com/ripperhe/Seemygo-notes/blob/master/01-FM/Binary/静态库-动态库.md)

### 二进制化实践

* 添加库 `target`
	* 根据情况选择 `.a` / `.framework`
* 导入文件引用
* 生成库
* 移动库到 pod 库内
* 修改 podspec

	```ruby
	s.source_files = 'XMGSegmentBar/Products/include/**'
	s.public_header_files = 'XMGSegmentBar/Products/include/*.h'
	s.ios.vendored_libraries = 'XMGSegmentBar/Products/lib/libXMGSegmentBarLib.a'
	spec.ios.vendored_frameworks = ...
	```

### 源码-二进制的切换

* 原理
	* 通过设置环境变量的取值, 控制不同的 podspec 流程走向
* 示例代码

	```ruby
	if ENV['IS_BINARY']
	    s.source_files = 'XMGSegmentBar/Products/include/**'
	    s.public_header_files = 'XMGSegmentBar/Products/include/*.h'
	    s.ios.vendored_libraries = 'XMGSegmentBar/Products/lib/libXMGSegmentBarLib.a'
		
	else
	    s.source_files = 'XMGSegmentBar/Classes/**/*'
	end
```

### 使用

* 注意清除缓存
	
	```bash
	pod cache clean --all
	```
	
	* 删除原有的项目pod文件
* 安装之前, 注意添加设置的成员变量

	```bash
	IS_BINARY=1 pod install 
	```
	
### cocoapods-packager

* 作用
	* 快速完成类库的打包
* 安装

	```bash
	sudo gem install cocoapods-packager
	```
	
* 使用
	* `pod package spec文件名`
	
	```bash	
	IS_SOURCE=1 pod package spec文件名称 --library --exclude-deps --spec-sources=spec文件私有索引库路径,https://github.com/CocoaPods/Specs.git  
	```
	
### 自动打包库的脚本

[buildbinary.sh](https://github.com/ripperhe/Seemygo-notes/blob/master/01-FM/Binary/buildbinary.sh)