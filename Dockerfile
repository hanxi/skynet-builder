FROM debian:trixie

ENV DEBIAN_FRONTEND=noninteractive \
    TZ=UTC \
    LANG=C.UTF-8 \
    PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

# 改为国内镜像
RUN rm -f /etc/apt/sources.list.d/*.list /etc/apt/sources.list.d/*.sources && \
    echo "deb http://mirrors.aliyun.com/debian/ trixie main contrib non-free non-free-firmware" > /etc/apt/sources.list && \
    echo "deb http://mirrors.aliyun.com/debian/ trixie-updates main contrib non-free non-free-firmware" >> /etc/apt/sources.list && \
    echo "deb http://mirrors.aliyun.com/debian/ trixie-backports main contrib non-free non-free-firmware" >> /etc/apt/sources.list && \
    echo "deb http://mirrors.aliyun.com/debian-security/ trixie-security main contrib non-free non-free-firmware" >> /etc/apt/sources.list && \
    echo "=== Sources List ===" && cat /etc/apt/sources.list && \
    echo "=== Sources.list.d ===" && ls -la /etc/apt/sources.list.d/ || echo "No additional sources"

# 安装所有必需的包
RUN apt-get update && apt-get install -y --no-install-recommends \
    # 编译工具链
    build-essential \
    make \
    pkg-config \
    \
    # MinGW-w64 (支持32位和64位)
    mingw-w64 \
    mingw-w64-tools \
    mingw-w64-i686-dev \
    mingw-w64-x86-64-dev \
    \
    # 可选依赖
    autoconf \
    automake \
    libtool \
    \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# 创建非root用户（可选）
RUN useradd -m -s /bin/bash builder

# 设置工作目录
WORKDIR /workspace
RUN chown -R builder:builder /workspace

# 切换用户
USER builder

# 显示版本信息
RUN echo "=== 编译工具版本 ===" && \
    gcc --version && \
    x86_64-w64-mingw32-gcc --version && \
    i686-w64-mingw32-gcc --version && \
    make --version

CMD ["/bin/bash"]
