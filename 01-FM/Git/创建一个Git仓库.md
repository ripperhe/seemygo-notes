# 创建一个 Git 仓库

### 本地创建一个工程

工程内容可以是任意的文件，不一定是一个 iOS 项目

### 使用 Git 进行版本管理

进入文件夹

	git init
	git add .
	git commit -m '初始化'

### 提交代码到远程仓库

* 创建远程代码仓库
	* github
	* coding.net
* 添加远程仓库关联

		git remote add origin 远程仓库地址

* 提交代码到远程仓库

		git push origin master

* 备注: 关于权限
	1. 使用用户名和密码
	2. 生成公钥私钥 `ssh-keygen`

### 本地打标签备份, 并提交标签

	git tag 标签名称
	git push --tags

### 删除本地/远程标签

* 删除本地
 
		git tag -d 标签名称

* 删除远程  

		git push origin :标签名称