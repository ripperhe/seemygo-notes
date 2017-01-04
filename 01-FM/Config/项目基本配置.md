# 项目基本配置

## Names?

### DisplayName

* Bundle display name
* 应用程序安装到设备上的显示名称

### ProductName

* App 包名
	* `[[NSBundle mainBundle] bundlePath]`
	* 默认是 `$(TARGETNAME)`
* 关乎我们查找资源的路径, 所以务必保持是英文
	
## Versions?

### Bundle versions string, short
	
正式版本号, 固定的规则
1.1.2
	
### Bundle version
	
内部版本
	
### 使用原则

假设初始版本号是 1.0.0格式的

1. app 有小改动, 修复bug
	* 尾号+1 , 首号中号不变 `1.0.1`
2. app 扩充功能 
	* 中号+1 , 尾号置0, 首号不变 `1.1.0`
3. app 界面风格完全发生变化或者功能发生了大幅度的改变 
	* 首号+1, 中号置0, 尾号置0 `2.0.0`
4. 如果只是 app 内部版本记录, 
	* 修改 `Bundle version`
		
## 启动图片?

对屏幕尺寸的影响?

## 必须项目开始前确定的参数

* bundle id
	* 关乎到后期的第三方集成
* 适配系统版本号
	* 关乎到API版本适配
	
## Target MemberShip?

* 对源文件的影响?
* 对资源加载的影响?

## 模式采用以及对应的物理文件夹划分注意事项

* 先按照功能模块进行划分
* 功能模块内部再按照设计模式进行划分