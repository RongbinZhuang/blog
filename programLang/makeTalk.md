Makefile编写
===

基本规则
---

* 基本要素

命令行中使用`make`命令来调用，此命令会根据当前目录下的`Makefile(makefile)`来执行，默认执行文件当中的第一个目标，即当命令只有`make`时程序会根据第一个目标的规则来运行，若指定目标即使用`make target`则程序会在文件当中寻找对应目标，找到则根据对应目标规则运行，没有则报错。

* 基本结构

> target(s):prerequisite(s)
> &emsp; command(s)

`target(prerequisite)`可以是文件也可以是`Makefile`中的变量甚至可以是一个未定义过的字符串，只要最终依赖关系能够确定下来都是合法的。

当`prerequisite(s)`的更新时间新于`target(s)`的更新时间时，执行`command(s)`来对`target(s)`进行更新。

`target(s)`必须为每行的开头，`target(s)`和`prerequisite(s)`之间用一个`:`隔开，当有多个`targets(prerequisites)`时，每个`target(prerequisite)`之间用空格隔开，而当有多个`commands`时需要隔成多行，而且每一行的行首都必须为一个`制表符(tab)`。`target(s)`不可为空，`prerequisite(s)`为空时意味着`target(s)`始终需要更新。
* 自顶向下的搜索和自底向上的运行

> target1:target2 
> &emsp; command1
> target2:
> &emsp; command2

在这个`Makefile`文件当中，若最终目标是要运行`target1`，则程序在寻找到`target1`的规则后会发现其需要寻找`target2`的更新规则来查看其是否需要更新进而确定`target1`是否需要更新，而寻找到`target2`的规则之后因为后面的`prerequisites`为空需要更新，于是运行`command2`来更新，然后回到`target1`的规则发现`target2`已更新，于是运行`command1`来更新`target1`

由此可见当`Makefile`执行的时候，寻找目标的顺序是`target1`->`target2`，而最终命令的执行顺序则是`command2`->`command1`。

* 多个targets，prerequisites，commands

> all:target1 target2 target3   
> &emsp; command1    
> &emsp; command2   
> target1:target2 target3  
> &emsp; command3; \  
> &emsp; command4  
> target2 target3:  
> &emsp; command5  

当要执行`all`时，程序会`从左到右`检查`target1`->`target2`->`target3`的规则，而当程序检查到`target1`的规则时又发现其依赖关系为`target2`->`target3`，而`target2`和`target3`在同一行的`targets`中，这意味着他们有相同的依赖关系，根据`target2`的依赖关系空来执行`command5`更新`target2`，然后根据`target3`的依赖关系为空执行`command5`来更新，回到`target1`的规则中，根据更新后的`target2`和`target3`，执行`command3;\ command4`来更新`target1`。同样是两行命令，`command3;\ command4`与`command1 command2`的区别就在于`shell`会将`command3;\ command4`当作一条命令处理，而`command1 command2`当作两条命令令处理。一般情况下`command3;\ command4`的用法都是写循环，如下:

> for i in 1 2 3;\\
> do \\
>	@echo $$i;\\
> done

输出结果为:

> 1  
> 2  
> 3  

此`Makefile`最终运行结果为:<br>
command5 -> command5 -> command3;command4 -> command5 -> command5 -> command1 -> command2

* 多条规则

> target1:target2
> &emsp; command1
> target1:target3
> &emsp; command2

多条规则可以使同一`target1`在不同的情况下执行不同的更新，即当`target2`更新而`target3`未更新时则`target1`会执行`command1`来更新，反之则执行`command2`来更新。而两个同时更新则`target1`会更新两次

* 注意事项

`Makefile`基本形式与一般的`批处理文件(.sh)`并无太大区别，除了在变量的引用上因为`Makefile`内部同样也是用`$`来作为变量标识符所以为避免冲突对于`command(s)`中的变量都是采用`$$`来作为标识符的。

因为`Makefile`的`target`可以是文件也可以是变量或者字符串，为了避免错误链接，使用`.PHONY`标识符可以显式声明`target`并不是文件

因为`Makefile`是自底向上运行的所以难以从其输出结果看出当前运行与整体程序的那一段，这时候可以用个小trick来使输出的结构更清晰:
> program:step1 ...
> &emsp; ...
> .PHONY:step1
> step1:
> &emsp; @echo step start

较为常见的`target`

target		| function
------------|--------
all			| 运行所有程序
------------|--------
install		| 安装程序
------------|--------
clean		| 清除中间文件
------------|------------
distclean

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


---
*2017.7.10*
