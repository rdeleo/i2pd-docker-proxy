# 🛡️ i2pd Docker - Quick Deploy

> **Created in response to the DDoS attack on the I2P network (February 3rd, 2026)**  
> Let's help the community get back online with the latest patched version! 💪  
> Screw those attackers! 🖕

---

## 🚀 What is this?

This is a ready-to-go Docker setup for [i2pd](https://github.com/PurpleI2P/i2pd) (the C++ I2P daemon) that builds from the **openssl** branch — the latest patched version addressing the recent network attack.

We wanted to make it as easy as possible for everyone to deploy a secure, up-to-date I2P router. Clone, build, run. That's it! 🎉

---

## 📋 Prerequisites

Tested on>
- 🐧 Linux (tested on Debian-based systems)
- 🍎 macOS (Apple Silicon / ARM architecture supported)

With:
- 🐳 Docker & Docker Compose
- ☕ A cup of coffee while it builds
- 🛠️ *Facultative:* Make for easier your life

---

## ⚡ Quick Start

```bash
# Clone this repo
git clone git@github.com:rdeleo/i2pd-docker-proxy.git
cd i2pd-docker-proxy

# Build and start (grab that coffee ☕)
make build
make upd

# Check if it's running
make status
```

Be patient, due to the DDOS it can take up to 5 minutes before to be able to generate transit tunnels, and that's it! Your I2P router should be up and running! 🎊

---

## 🎮 Available Commands

Run `make help` to see all available commands:

| Command | Description |
|---------|-------------|
| `make up` | Start containers (attached mode) |
| `make upd` | Start containers in detached mode |
| `make stop` | Stop containers |
| `make down` | Stop and remove containers |
| `make downv` | Stop and remove containers + volumes |
| `make build` | Build fresh image (no cache) |
| `make bash` | Open a shell in the container |
| `make clean` | Remove everything (container, image, volumes) |
| `make status` | Show container status |
| `make help` | Show help message |

---

## 🌐 Proxy Ports

Once running, you can use these local endpoints:

| Service | Address |
|---------|---------|
| 🌍 HTTP Proxy | `127.0.0.1:4444` |
| 🧦 SOCKS Proxy | `127.0.0.1:4447` |
| 🖥️ Web Console | [http://127.0.0.1:7070](http://127.0.0.1:7070) |
| 💬 IRC (Ilita) | `127.0.0.1:6668` |
| 💬 IRC (Irc2P) | `127.0.0.1:6669` |
| 📧 SMTP | `127.0.0.1:7659` |
| 📬 POP3 | `127.0.0.1:7660` |

### Browser Configuration

Configure your browser to use the HTTP proxy (`127.0.0.1:4444`) to access `.i2p` sites!

---

## 📁 Project Structure

```
├── Dockerfile           # Multi-stage build from i2pd source
├── Makefile             # Handy commands for Docker management
├── compose.yaml         # Docker Compose configuration
├── docker-entrypoint.sh # Container entrypoint script
├── i2pd.conf            # i2pd main configuration
└── tunnels.conf         # Tunnel definitions (IRC, etc.)
```

---

## ⚙️ Configuration

### Changing the i2pd Branch

By default, we build from the `openssl` branch. To use a different branch:

```bash
docker compose build --build-arg I2PD_BRANCH=master --no-cache
```

### Customizing i2pd Settings

Edit `i2pd.conf` to adjust:
- Bandwidth limits
- Logging level
- Transport settings
- And more!

Check the [i2pd documentation](https://i2pd.readthedocs.io/) for all options.

---

## 🔧 Exposed Ports

| Port | Protocol | Description |
|------|----------|-------------|
| 7070 | TCP | Web Console |
| 4444 | TCP | HTTP Proxy |
| 4447 | TCP | SOCKS Proxy |
| 4567 | TCP/UDP | I2P Router (network participation) |
| 6668 | TCP | IRC Tunnel (Ilita) |
| 6669 | TCP | IRC Tunnel (Irc2P) |
| 7659 | TCP | SMTP |
| 7660 | TCP | POP3 |

---

## 🤝 Contributing

Found a bug? Have an improvement? Feel free to open an issue or PR!

Together we keep the network strong! 💜

---

## 📜 License

This Docker setup is provided as-is for the community.  
i2pd itself is licensed under BSD 3-Clause.

---

## 💜 Stay Safe, Stay Anonymous

The I2P network is resilient because of people like you running nodes.  
Thank you for helping keep the network alive! 🙏

*Built with love during troubled times* ❤️
