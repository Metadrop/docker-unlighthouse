FROM debian:bookworm-slim

# Install dependencies.
RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
    ca-certificates=20230311 \
    curl=7.88.* \
    gpg=2.2.* \
  ; \
  \
  curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | tee /etc/apt/trusted.gpg.d/nodesource.asc; \
  echo 'deb [signed-by=/etc/apt/trusted.gpg.d/nodesource.asc] https://deb.nodesource.com/node_22.x nodistro main' | tee /etc/apt/sources.list.d/nodesource.list; \
  \
	apt-get update; \
	apt-get install -y --no-install-recommends \
    nodejs=22.* \
    chromium=133.0.* \
	; \
	\
	apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false; \
	rm -rf /var/lib/apt/lists/*

# Install unlighthouse and remove unwanted puppeteer chrome.
RUN --mount=type=cache,target=/root/.npm npm install -g @unlighthouse/cli \
  && npm cache clean --force \
  && rm -rf /root/.cache/puppeteer

EXPOSE 5678

# Add user so we don't need --no-sandbox.
RUN addgroup unlighthouse && adduser --ingroup unlighthouse unlighthouse \
    && mkdir -p /home/unlighthouse/Downloads /app \
    && chown -R unlighthouse:unlighthouse /home/unlighthouse \
    && chown -R unlighthouse:unlighthouse /app

USER unlighthouse
WORKDIR /home/unlighthouse
