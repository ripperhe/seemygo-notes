## cocoapods 的安装

### 作用

* 帮助管理和维护第三方框架
* 问题1: 之前如果我们手动集成第三方框架, 有可能会添加很多配置, 和系统依赖框架, 繁琐易错
	* 自动添加框架配置
	* 自动添加系统依赖框架
* 问题2: 如果框架升级了, 我们在本地工程里面升级框架, 需要删除替换, 再重新配置框架相关配置
	* 一个命令解决
* 简单理解: 就是快速的搜索到第三方框架, 然后自动集成到工程里面来, 并编译成一个libPod.a的静态库给我们项目用

### 流程图

![流程图](https://github.com/ripperhe/Seemygo-notes/blob/master/01-FM/CocoaPods/流程图.png)

### 安装 CocoaPods

#### gem 简介

##### 什么是gem?

* Gem 是一个管理 Ruby 库和程序的标准包，它通过 Ruby Gem（如 [http://rubygems.org/](https://rubygems.org/) ）源来查找、安装、升级和卸载软件包，非常的便捷。
* 软件包数据源(意思就是从哪里下载软件)
	* [https://rubygems.org/](https://rubygems.org/)
	* [https://gems.ruby-china.org/](https://gems.ruby-china.org/)

##### 常用命令

* 查看gem版本

		gem --version

* 更新gem

		sudo gem update --system
	
	* 注解: `sudo` 是以超级管理员的身份操作
* 查看数据源

		gem sources

* 删除数据源
	
		gem sources --remove https://rubygems.org/

* 添加数据源

		gem sources -a https://ruby.taobao.org/

*  搜索软件包

		gem search 软件包关键字

* 安装软件包

		gem install 软件包名称

* 安装上一个版本软件包

		gem install cocoapods --pre

* 卸载安装包

		gem uninstall 软件包名称

* 注意: 以上命令最好在使用之前, 都添加 `sudo`
	* 代表以管理员身份运行该命令
	* 原因: 因为有可能安装软件包的过程当中, 需要创建文件等等, 必须有管理员权限才能操作

#### 有时 ruby 版本过低也导致升级失败

* 可以安装 RVM(Ruby 版本管理器) 升级 ruby
* 安装RVM

		curl -L get.rvm.io | bash -s stable

* 验证是否成功

		rvm -v

* 查看ruby版本

		ruby -v
		
* 列出当前所有可用版本

		rvm list known
		
* 安装指定版本ruby

		rvm install ruby --head
		
	* 如果安装失败, 可能是没有安装 `homebrew` , 先安装即可
		* [http://brew.sh/index_zh-cn.html](http://brew.sh/index_zh-cn.html)

#### 使用 gem 安装 CocoaPods

	sudo gem install cocoapods
	
* 安装失败的解决方案
	
		sudo gem update --system
		sudo gem uninstall cocoapods
		sudo gem install cocoapods
			
* 升级到10.11, CocoaPods报错: command not found, 解决方案 
	
		sudo gem update --system
		sudo gem uninstall cocoapods
		sudo gem install -n /usr/local/bin cocoapods

####  验证成功

	pod --version

