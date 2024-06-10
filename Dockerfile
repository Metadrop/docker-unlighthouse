# Based on https://github.com/indykoning/unlighthouse-docker/tree/master
FROM node:22-bullseye

RUN apt update --fix-missing; \
    apt install -y chromium; \
    apt install -y nss-passwords; \
    apt install -y libfreetype6; \
    apt install -y libharfbuzz-bin; \
    apt install -y ca-certificates; \
    apt install -y fonts-freefont-ttf;

RUN npm install -g unlighthouse

EXPOSE 5678

# Tell Puppeteer to skip installing Chrome. We'll be using the installed package.
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser
ENV SITE="http://localhost"

RUN chown root:root /usr/lib/chromium/chrome-sandbox && \
    chmod 4755 /usr/lib/chromium/chrome-sandbox

# Add user so we don't need --no-sandbox.
RUN adduser --help
RUN addgroup unlighthouse && adduser --ingroup unlighthouse unlighthouse \
    && mkdir -p /home/unlighthouse/Downloads /app \
    && chown -R unlighthouse:unlighthouse /home/unlighthouse \
    && chown -R unlighthouse:unlighthouse /app

# Run everything after as non-privileged user.
USER root
WORKDIR /home/unlighthouse
