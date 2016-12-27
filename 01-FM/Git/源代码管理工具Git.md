## 源代码管理工具Git

### 使用流程

* 工作区 
	* 与 `.git` 文件夹同级的其他文件夹或者子文件夹
* 版本控制库
	* 暂缓区
	* 分支
		* Git 不像 SVN 那样有主干和分支的概念. 仅仅存在分支,其中 master 分支为默认被创建的分支,类似于 SVN 中的主干

* 切换分支:
	* 通过控制 HEAD 指针指向不同的分支,就可以切换
* ** 操作原则: 所有新添加/删除/修改的文件 必须先添加到暂缓区,然后才能提交到HEAD指向的当前分支中**

### 初始化本地仓库

	git init

### 查看文件状态

	git status

### 添加文件到暂缓区

	git add .

### 从暂缓区提交文件到本地代码仓库

	git commit -m "注释"

### 打标签

	git tag -a '标签' -m "注释"

### 查看标签

	git tag

### 删除标签

	git tag -d '标签名称'


### 远程仓库操作

* 远程仓库的创建及使用
	* 托管平台「码市」的使用
		* 代码仓库的创建
		* SSH 的验证配置
	* GitHub / GitLab / Coding ...
* 给本地仓库添加添加远程仓库关联地址
		
		git remote add origin 远程仓库地址

* 上传本地代码到远程仓库

		git push origin master
		 
* 上传标签到远程仓库

		git push --tags
	
* 从远程仓库删除标签

		git push origin :标签