### 汇编语言程序设计 示例代码

![封面](cover.jpg)

#### Ubuntu64位系统上支持编译32位程序

1. 确认主机为64位架构的内核，应该输出为adm64，执行：
    ```
    $ dpkg --print-architecture
    ```

2. 确认打开了多架构支持功能，应该输出为i386，执行：
    ```
    $ dpkg --print-foreign-architectures
    ```
    如果没有，则需要手动打开，依次执行：
    ```
    $ sudo dpkg --add-architecture i386
    $ sudo apt-get update
    $ sudo apt-get dist-upgrade
    ```

3. 安装gcc multilib，执行：
    ```
    $ sudo apt-get install gcc-multilib g++-multilib
    ```

4. 注意：用GCC编译时需要加上 `-m32` 选项

5. 编译汇编程序的时候记得加上 `--32`，并且链接的时候要指定`-m elf_i386`以及指定32位的ld.so
    ```
    $ as --32 movtest3.s -o movtest3.o # 汇编
    $ ld  -m elf_i386 -o movtest3 movtest3.o -dynamic-linker /lib/ld-linux.so.2 -L/lib32 -lc # 链接
    ```
