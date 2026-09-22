FROM ruby:2.7-bullseye

RUN sed -i \
    -e 's|http://deb.debian.org/debian-security|http://snapshot.debian.org/archive/debian-security/20240101T000000Z|g' \
    -e 's|http://deb.debian.org/debian|http://snapshot.debian.org/archive/debian/20240101T000000Z|g' \
    /etc/apt/sources.list \
    && apt-get -o Acquire::Check-Valid-Until=false update \
    && apt-get install -y --no-install-recommends \
    build-essential \
    git \
    libpq-dev \
    nodejs \
    postgresql-client \
    && rm -rf /var/lib/apt/lists/*

RUN gem install bundler -v 1.17.3

WORKDIR /app