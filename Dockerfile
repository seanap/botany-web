FROM python:3.10-slim

# Install dependencies (including git for cloning)
RUN apt-get update && apt-get install -y --no-install-recommends \
    git curl ca-certificates libncurses5 libncursesw5 && \
    rm -rf /var/lib/apt/lists/*

# Set environment variables for terminal compatibility
ENV TERM=xterm-256color
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8

WORKDIR /opt
RUN git clone --depth=1 https://github.com/jifunks/botany.git

WORKDIR /opt/botany
RUN useradd -m botany && chown -R botany:botany /opt/botany

# Switch to root temporarily to install gotty into /usr/local/bin
USER root
RUN curl -L https://github.com/yudai/gotty/releases/download/v2.0.0-alpha.3/gotty_2.0.0-alpha.3_linux_amd64.tar.gz \
    | tar -xz -C /usr/local/bin && chmod +x /usr/local/bin/gotty

# Switch back to non-root user
USER botany

EXPOSE 8080
ENTRYPOINT ["gotty", "--port", "8080", "--title-format", "🌿 Botany-Web", "--permit-write", "python3", "botany.py"]
