makefile编写
===
基本规则
---
* 其本要素

命令行中使用`make`命令来调用，此命令会根据当前目录下的`Makefile(makefile)`来执行，默认执行文件当中的第一个目标，即当命令只有`make`时程序会根据第一个目标的规则来运行，若指定目标即使用`make target`则程序会在文件当中寻找对应目标，找到则根据对应目标规则运行，没有则报
错。
* 基本结构<br>
> target(s) : prerequisite(s)<br>
> &emsp; command(s)<br>

其意义在于当`prerequisite(s)`满足为完成`target(s)`会执行`command(s)`。这其中的命令通过`shell`来执行，
[comment]:	
	this is a comment

匹配规则
---
```c 
int main()
{
	return 0;
}
```
隐含规则
---
变量与函数
---
