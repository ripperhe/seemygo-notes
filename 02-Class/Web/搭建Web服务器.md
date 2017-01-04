# 搭建Web服务器

## 前言

在直播中，创建房间，获取房间，都需要服务器，因此需要搭建Web服务器

## Web服务器

能处理HTTP请求的服务器都可以叫Web服务器

## Node.js介绍

Node.js什么时候出现，2009年，Ryan Dahl(瑞恩·达尔)在GitHub上发布了最初版本的部分Node.js包，随后几个月里，有人开始使用Node.js开发应用

什么是Node.js,做过Javascript开发的，看到Node.js这个名字，初学者可能会误以为这是一个Javascript应用，事实上，Node.js采用C++语言编写而成，是一个Javascript的运行环境，意思就是底层使用c++编写，外层封装采用Javascript，需要使用Javascript解析执行。

比如OC底层也是c++，但是执行代码，只需要解析OC代码。

Node.js是一个后端的Javascript运行环境，这意味着你可以编写服务器端的Javascript代码，交给Node.js来解释执行。

## Node.js工作原理与优缺点（了解一门语言的开始）

传统Web服务器原理(T):传统的网络服务技术，是每个新增一个连接（请求）便生成一个新的线程，这个新的线程会占用系统内存，最终会占掉所有的可用内存。

Node.js工作原理(T)：只运行在一个单线程中，使用非阻塞的异步 I/O 调用，所有连接都由该线程处理，也就是一个新的连接，不会开启新的线程，仅仅一个线程去处理多个请求。

优点：

* 传统的比较消耗内存，Node.js只开启一个线程，大大减少内存消耗。
* 假设是普通的Web程序，新接入一个连接会占用 2M 的内存，在有 8GB RAM的系统上运行时, 算上线程之间上下文切换的成本，并发连接的最大理论值则为 4000 个。这是在传统 Web服务端技术下的处理情况。而 Node.js 则达到了约 1M 一个并发连接的拓展级别

弊端:

* 大量的计算可能会使得 Node 的单线程暂时失去反应, 并导致所有的其他客户端的请求一直阻塞, 直到计算结束才恢复正常

疑问？Node.js是单线程的。单线程怎么开启异步?怎么工作的？ 需要了解事件驱动。

什么是事件驱动?(T)

传统的web server多为基于线程模型。你启动Apache或者什么server，它开始等待接受连接。当收到一个连接，server保持连接连通直到页面或者什么事务请求完成。如果他需要花几微妙时间去读取磁盘或者访问数据库，web server就阻塞了IO操作（这也被称之为阻塞式IO).想提高这样的web server的性能就只有启动更多的server实例。

Node.Js使用事件驱动模型，当web server接收到请求，就把它关闭然后进行处理，然后去服务下一个web请求。当这个请求完成，它被放回处理队列，当到达队列开头，这个结果被返回给用户。这个模型非常高效可扩展性非常强，因为webserver一直接受请求而不等待任何读写操作。（这也被称之为非阻塞式IO或者事件驱动IO）

本质:当然最终处理事件还是需要底层开启线程，只不过接受请求只用一个线程去接收。

## Node.js使用介绍

Node.js使用Module模块去划分不同的功能，以简化App开发，Module就是库，跟组件化差不多，一个功能一个库。

NodeJS内建了一个HTTP服务器，可以轻而易举的实现一个网站和服务器的组合，不像PHP那样，在使用PHP的时候，必须先搭建一个Apache之类的HTTP服务器，然后通过HTTP服务器的模块加载CGI调用，才能将PHP脚本的执行结果呈现给用户

require() 函数，用于在当前模块中加载和使用其他模块；

## Express模块(框架)

* Express是Node.JS第三方库
* Express可以处理各种HTTP请求
* Express是目前最流行的基于Node.js的Web开发框架，
* Express框架建立在node.js内置的http模块上，可以快速地搭建一个Web服务器
* Express官方文档
* Javascript文档

## 搭建Web服务器步骤

### 一、安装Node.JS

打开终端，输入 `node -v` ，先查看是否已经安装

如果没有安装，就需要安装node软件。

mac上可以使用Homebrew，安装node

> Homebrew:Homebrew简称brew，是Mac OSX上的软件包管理工具，能在Mac中方便的安装软件或者卸载软件,相当于window上360管家，可以帮你下载软件。

先输入`brew -v`,查看mac是否安装了 HomeBrew

#### 安装 homebrew

若没有安装ruby，请先安装ruby → 教程([http://www.jianshu.com/p/daa92187621c](http://www.jianshu.com/p/daa92187621c))

使用ruby安装Homebrew，前提是安装了ruby

输入指令安装brew

```bash
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

#### 安装 node

使用 Homebrew 安装 Node ，输入指令

```bash
brew install node 
```
安装完，输入 `node -v` 查看是否安装成功

### 二、安装NPM

NPM是随同NodeJS一起安装的包管理工具，用于下载NodeJS第三方库。

类似iOS开发中cocoapods，用于安装第三方框架

新版的NodeJS已经集成了npm，所以只要安装好Node.JS就好

### 三、利用NPM下载第三方模块（Express和Socket.IO）

package.json

package.json类似cocoapods中的Podfile文件

package.json文件描述了下载哪些第三方框架.

可以使用npm init创建

需要添加dependencies字段，描述添加哪些框架,其他字段随便填
注意：不能有中文符号

```
"dependencies": {
    "express": "^4.14.0",
    "socket.io": "^1.4.8"
}
```

### 四、执行npm install,就会自动下载依赖库

```bash
npm install
```

### 五、创建Node.JS文件，搭建服务器

只要文件，以js为后缀就可以了，比如app.js

使用node app.js 就能执行文件

注意点：监听端口要注意，不能使用已经占用的端口比如（80），每个服务器相当于一个app，都需要端口，才能找到入口

### 六、简单的搭建Http服务器

```javascript
// require
// 加载http模块
var http = require('http');

// 创建http服务器
var server = http.createServer(function(request,response){
    // response.write('Hello world');
    // response.end();
});

// 监听服务器
server.listen(8080,'192.168.0.101');

console.log('监听8080');
```

### 七、express框架

直接创建express应用，就是服务器，可以直接监听

需要主动监听请求，get,post

```javascript
// 引入express模块
var express = require('express');

// 创建express服务器，创建服务器没有对访问服务器进行处理
var app = express();

// 监听get请求，请求根目录，输出Hello world
app.get('/',function(request,response){
    response.send('Hello world');
});

app.post('/',function(request,response){
    response.send('Hello world');
});

app.listen(8080,"192.168.0.101");

console.log("监听8080");
```

### 八、路由

路由:如何响应客户端的请求

添加url路径,根据不同路径，显示不同内容

访问地址,/home应该往端口后拼接，8080/home

```javascript
var express = require('express');

var server = express();

// 监听get请求，请求根目录，输出Hello world
server.get('/home',function(request,response){
    response.send('home');
});

server.get('/live',function(request,response){
    response.send('live');
});

server.listen(8080);
```

路由句柄(索引):执行完一个函数，接着执行下一个 ,因为有时候处理一个请求，需要做很多其他事情，写在一起业务逻辑不好分开,所以多弄几个行数

```javascript
// 路由句柄
var express = require('express');

var server = express();

server.get('/live',function(request,response,next){
    console.log('先执行A');
    next();
},function(request,response){
    console.log('先执行B');
    response.send('live');
});

server.listen(8080);
```

### 九、中间件

优化代码，使代码清晰可读

注意点，函数一定要添加next参数，一定要调用next(),才会进行下面操作，代码使一行一行执行，解释性语言

原理，发送一个请求给服务器的时候，会被中间件拦截，先由中间件处理，每个中间件都有一个回调函数作为参数

use是express注册中间件的方法

```javascript
function(request,response,next){
    console.log('先执行A');
    next();
}
```

代码演示

```javascript
// 中间件
var express = require('express');

var server = express();

server.use('/live',function(request,response,next){
    console.log('先执行A');
    next();
});

server.get('/live',function(request,response){
    console.log('先执行B');
    response.send('live');
});

server.listen(8080);
```

### 十、get请求参数

request.query会把请求参数包装成字典对象，直接通过点就能获取参数

```javascript
var express = require('express');

var server = express();

// 监听get请求，请求根目录，输出Hello world
server.get('/home',function(request,response){
    console.log(request.query.id);
    response.send(request.query);
});

server.listen(8080);

console.log('监听8080');
```

### 十一、post请求参数

使用http发送请求，需要设置content-type字段

content-type字段

* application/x-www-form-urlencoded(普通请求，默认一般使用这种)
* application/json(带有json格式的参数，需要使用这个，比如参数是字典或者数组)
* multipart/form-data(传输文件，文件上传使用这个)

AFN框架中AFHTTPRequestSerializer使用的是application/x-www-form-urlencoded，AFJSONRequestSerializer使用的是application/json

Node.JS需要使用body-parser模块,解析post请求参数，安装body-parser模块，用命令行

```bash
npm install body-parser
```

可以采用中间件的方式解析post请求参数

5.1 注意bodyParser.urlencoded参数是一个字典，需要添加{}`包装，bodyParser.urlencoded({extends:true}) 5.2 extends必传参数，是否展开

```javascript
// 解析urlencoded，把参数转换成对象，放入request.body
var urlencodedParser = bodyParser.urlencoded({extends:true});

// 解析json，把参数转换成对象，放入request.body
var jsonParser = bodyParser.json();
```

完整代码

```javascript
// 创建服务器
var server = express();

// 引入
var bodyParser = require('body-parser');

// 解析application/x-www-form-urlencoded
var urlencodedParser = bodyParser.urlencoded({extended:true});

// 解析application/json
var jsonParser = bodyParser.json();

// 使用中间件先拦截
server.use(urlencodedParser);

// 监听post请求
server.post('/home',function(request,response){

    console.log(request.body);

    response.send(request.body);
});

server.listen(8080);

console.log('监听8080');
```

### 十二、express创建对象返回客户端

{}:字典 []:数组

自定义对象，才有function

function可以定义函数，也可以定义对象，一般有属性的，都是对象

定义对象,this：表示当前对象，类似self

对象可以直接输出

```javascript
// 引入express模块
var express = require('express');

// 创建服务器
var server = express();

// {}:字典 []:数组
// var room = {'a':'b'};

var room = ['1','2','3'];

// function可以定义函数，也可以定义对象，一般有属性的，都是对象
// 定义方法
function log(){
    console.log('定义函数');
}

// 定义对象,this：表示当前对象，类似self
function User(name,age){
    // 定义属性，并且赋值
    this.name = name;

    // 定义属性，并且赋值
    this.age = age;

    // 定义方法
    this.log = function(){
        console.log(this.name + this.age);
    }
}

// 创建对象使用new
var u = new User('王思聪',18);

u.log();

// 对象可以直接输出，会自动转换为json字典

// 监听post请求
server.get('/room',function(request,response){

    console.log(u);

    response.send(u);
});

server.listen(8080);

console.log('监听8080');
```

### 十三、express模块开发

如果把所有代码写在一个文件中，不好维护，代码可读性不好，最好分离文件

使用模块开发，exports用来定义模块接口，可以定义函数，也可以定义自定义对象，需要用module.exports

注意，module.exports和exports不能重复，重复以module.exports为准

路径问题: ./ : 表示当前文件

main.js

```javascript
// 引入express模块
var express = require('express');

// 创建服务器
var server = express();

// 引入user模块
var User = require('./User');

// user.log();
var user = new User('x','20');

console.log(user);
// 监听post请求
server.get('/room',function(request,response){

    response.send(user);
});

server.listen(8080);

User.js
// exports.log = function(){
//     console.log("引入其他模块");
// }

function User(name,age){
    this.name = name;
    this.age = age;
}

module.exports = User;
```

### 十四、字典和数组删除操作

删除数组splice，splice有2两个参数，第一个参数，从哪个角标开始 第二个参数，删除几个元素

删除字典delete

注意:delete删除数组，删除不干净，只是把元素删除，当前角标位置并不会移除

[1,2,3] 比如delete arr[0] => [,2,3]

```javascript
// // 加载express模块，
// var express = require('express');

// // 创建server
// var server = express();

// // 创建数组
// var arr = [1,2,3];

// console.log(arr);

// // delete arr[0];
// // 删除数组元素
// arr.splice(0,1);

// console.log(arr);

// // 监听端口
// server.listen(8080);


// 加载express模块，
var express = require('express');

// 创建server
var server = express();

// 创建数组
var arr = {'a':'1','b':'2'};

console.log(arr);

delete arr['a'];

console.log(arr);

// 监听端口
server.listen(8080);
```

### 十五、直播房间服务器搭建

创建package.json,安装express模块

设计服务器接口和客户端怎么交互

直播房间业务逻辑

3.1 主播主动开启房间

3.2 通知服务器开启房间了 3.3 服务器保存房间

3.4 观众打开房间，查看直播

3.5 主播关闭直播，通知服务器移除房间号

服务器处理

4.1 主播开启房间，创建房间，需要传入给服务器保存

4.2 服务器用什么保存房间名称，数组还是字典

4.3 应该使用字典存储，当主播关闭房间时，可以根据房间号，找到服务器对应的房间号删除。

4.4 添加房间，删除房间之后，服务器应该把最新的房间信息返回给客户端展示

4.5 服务器可以直接返回房间字典，但是这样客户端必须自己处理下，服务器最好返回房间数组

4.6 Object.keys(rooms),传入一个字典，就能获取字典中所有keys，返回一个数组

4.7 然后遍历keys数组，一个一个取出对应的value，在保存到数组中

4.8 可以使用map函数，让数组中所有元素执行一个方法，然后会自动把处理结果包装成数组.

4.9 map函数原理，就是遍历数组中元素，一个一个执行，map函数的参数就是一个函数，，这个函数的参数就是数组中的一个元素key，map需要有返回值，返回值就是key参数的处理结果，会自动把处理结果包装到新数组，然后再统一返回处理好的数组

```
 keys.map(function(key){
    return rooms[key];
 });
```
客户端处理 

5.1 房间模型(ID,房间名称) 

5.2 保存到服务器字典,ID作为Key,房间名称作为Value 5.3 在发送服务器的时候，需要把ID和Value传给服务器 

5.4 搞两个参数(一个roomID,一个roomName)

服务器代码

```javascript
// 加载express模块，
var express = require('express');

// 创建server
var server = express();

// 创建房间字典
var rooms = {};

// 开启房间
server.get('/openRoom',function(request,response){

    // 获取房间ID
    var roomID = request.query.roomID;

    // 获取房间名称
    var roomName = request.query.roomName;
    rooms[roomID] = roomName;

    // 获取字典中所有keys
    var keys = Object.keys(rooms);
    var values = keys.map(function(key){
        return rooms[key];
    });

    console.log(values);
    response.send(values);

});

// 删除房间
server.get('/closeRoom',function(request,response){

    // 获取房间ID
    var roomID = request.query.roomID;

    // 删除房间
    delete rooms[roomID];

    // 获取字典中所有keys
    var keys = Object.keys(rooms);
    var values = keys.map(function(key){
        return rooms[key];
    });

    console.log(values);
    response.send(values);
    
});

// 获取房间列表
server.get('/rooms',function(request,response){

    // 获取字典中所有keys
    var keys = Object.keys(rooms);
    var values = keys.map(function(key){
        return rooms[key];
    });

    console.log(values);
    
    response.send(values);

});

// 监听端口
server.listen(8080);

console.log('监听8080');
```