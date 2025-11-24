# 用来编译 [Skynet](https://github.com/hanxi/skynet/tree/mingw) 的 Docker

目前主要是用来生成 Windows 平台使用的 exe 文件，依赖 mingw 的库平台编译环境。如果不想在 Docker 中运行，可以参考
Dockerfile 安装 mingw 相关依赖即可。

## 更新 Skynet

```
git submodule update --init --recursive
```

## 构建镜像

```
bash build-docker.sh
```

## 编译 Skynet

```
bash build-skynet.sh
```

会生成 skynet/skynet.exe 和 skynet/3rd/lua/lua.exe 以及其他 dll 和 so 文件，可以把 skynet 目录复制到 windows 运行。

启动服务器

```
.\skynet.exe .\examples\config
```

启动客户端

```
.\3rd\lua\lua.exe .\examples\client.lua
```
