FROM golang:alpine AS builder

# 为镜像设置必要的环境变量
ENV GO111MODULE=on \
    CGO_ENABLED=0 \
    GOOS=linux \
    GOARCH=amd64

# 移动到工作目录：/build
WORKDIR /build

# 复制项目中的 go.mod 和 go.sum文件并下载依赖信息
COPY go.mod .
COPY go.sum .
RUN go mod download

# 将代码复制到容器中
COPY . .

# 将代码编译成二进制可执行文件
RUN go build -o echo .

# 接下来创建一个小镜像
FROM scratch

# 从builder镜像中把/build/echo 拷贝到当前目录
COPY --from=builder /build/echo /
COPY log.json /

# 需要运行的命令
CMD ["/echo"]
