# Sử dụng image Python làm base image
FROM python:3.10-slim-buster

# Cài đặt các gói cần thiết
RUN apt-get update && apt-get install -y \
    curl \
    sudo \
    gnupg2 \
    lsb-release \
    && rm -rf /var/lib/apt/lists/*

# Cài đặt Docker
RUN curl -fsSL https://get.docker.com -o get-docker.sh
RUN sh get-docker.sh

# Thêm user hiện tại vào nhóm docker
RUN usermod -aG docker ${USER}

# Cài đặt JupyterLab
RUN pip install --upgrade pip
RUN pip install jupyterlab

# Tạo thư mục làm việc cho JupyterLab
WORKDIR /workspace

# Mở port 8888 để truy cập JupyterLab
EXPOSE 8888

# Khởi động JupyterLab khi container chạy
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--allow-root"]
