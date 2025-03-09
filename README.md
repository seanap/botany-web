![Botany](https://camo.githubusercontent.com/3922405d4b6eb5a65267a3b2b24e51831500b3770c3eb1d2ced9156038e84a95/68747470733a2f2f74696c64652e746f776e2f7e637572696f757365722f626f74616e792e706e67)

# Botany-Web 🌿

**Welcome to Botany-Web – your very own terminal gardening game webserver powered by Docker, gotty, and Tailscale!**

## What Is Botany-Web?

Botany-Web is a Dockerized terminal webserver that lets you play [Botany](https://github.com/jifunks/botany) in your browser. It uses [gotty](https://github.com/yudai/gotty) to expose your docker terminal as a web application. I’ve combined it with [Tailscale+SWAG](https://www.youtube.com/watch?v=uznDiFPlvvM) to securely connect to the terminal webserver on my own domain.

---

## Features

- Curses-based menu system, optimized for 80x24 terminal
- 20+ Species of plants w/ ASCII art for each
- Persistent aging system that allows your plant to grow even when app is closed
- Multiplayer! Water your friends plants & see who's visited your garden.
- Generations: each plant you bring to its full growth potential rewards you with 20% growth speed for the next plant
- Random and rare mutations can occur at any point in a plant's life
- Data files are created in the user's home (~) directory, along with a JSON file that can be used in other apps.
  - Volume map `~/docker/botany-web/data`

---

## Prerequisites

- **Docker**
- **Docker Compose**
- **Tailscale+SWAG** (optional) Embed Tailscale into your SWAG container so you can access your terminal remotely with SSL on your own domain.

---

## Installation

### 1. Install

```bash
cd ~/docker
git clone https://github.com/seanap/botany-web.git
cd botany-web
docker compose up -d
```

### 2. Permissions
Modify your permissions on the data folder on host
```
sudo chown -R 1000:1000 ~/docker/botany-web/data
sudo chmod -R 755 ~/docker/botany-web/data
```
### 3. Start Playing Botany-Web
Visit `<yourIP>:8080`

## Compose file
```yaml
version: "3.8"
services:
  botany-web:
    build: .
    container_name: botany-web
    ports:
      - "8080:8080"
    volumes:
      - ~/docker/botany-web/data:/home/botany/.botany
    restart: always
```
