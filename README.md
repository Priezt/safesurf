# SafeSurf
Lightweight Web-browsing Isolation Service

# Description
Basically, SafeSurf uses Apache Guacamole (VNC client in browser) as frontend and Docker+XVNC+Chromium as backend. It opens the URL in Chromium in "sandbox" and let you surf the target site by VNC.

# Installation
```
git clone https://github.com/Priezt/safesurf.git
cd safesurf
docker-compose up -d
```

# Usage
By default, SafeSurf listens on 10888/HTTP. You can change this in ".env" file.
Open http://<your-server-ip>:10888/<target-url> in browser.

