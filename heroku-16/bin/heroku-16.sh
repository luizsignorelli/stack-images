#!/bin/bash

exec 2>&1
set -e
set -x

cat > /etc/apt/sources.list <<EOF
deb http://archive.ubuntu.com/ubuntu/ xenial main universe
deb http://archive.ubuntu.com/ubuntu/ xenial-security main universe
deb http://archive.ubuntu.com/ubuntu/ xenial-updates main universe

# Use the PG11 version of libpq to work around:
# https://github.com/heroku/stack-images/issues/147
# We have to specify both 'main' and '11' since the latter only contains a subset of the packages.
deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main 11
EOF

# Give priority to the PG11 version of libpq, rather than main's PG12.
cat >/etc/apt/preferences.d/pgdg.pref <<EOF
Package: *
Pin: release o=apt.postgresql.org,c=11
Pin-Priority: 600
EOF

apt-key add - <<'PGDG_ACCC4CF8'
-----BEGIN PGP PUBLIC KEY BLOCK-----

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
=DA1T
-----END PGP PUBLIC KEY BLOCK-----
PGDG_ACCC4CF8

# Confluent use HTTPS sources, which Ubuntu 16.04 doesn't support out of the box.
apt-get update
apt-get install -y --force-yes apt apt-transport-https

cat >> /etc/apt/sources.list <<EOF
deb [arch=amd64] https://packages.confluent.io/deb/5.3 stable main
EOF

apt-key add - <<'CONFLUENT_41468433'
-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: GnuPG v1

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
42IcNGjHzVqDvw==
=m27L
-----END PGP PUBLIC KEY BLOCK-----
CONFLUENT_41468433

apt-get update
apt-get upgrade -y --force-yes
apt-get install -y --force-yes \
    apt-transport-https \
    apt-utils \
    bind9-host \
    bzip2 \
    coreutils \
    curl \
    dnsutils \
    ed \
    gcc \
    git \
    imagemagick \
    iputils-tracepath \
    language-pack-en \
    libc-client2007e \
    libcurl3 \
    libev4 \
    libevent-2.0-5 \
    libevent-core-2.0-5 \
    libevent-extra-2.0-5 \
    libevent-openssl-2.0-5 \
    libevent-pthreads-2.0-5 \
    libexif12 \
    libgd3 \
    libgnutls-openssl27 \
    libgnutlsxx28 \
    libmagickcore-6.q16-2-extra \
    libmcrypt4 \
    libmemcached11 \
    libmysqlclient20 \
    librabbitmq4 \
    librdkafka1 \
    libseccomp2 \
    libsodium18 \
    libuv1 \
    libxslt1.1 \
    libzip4 \
    locales \
    lsb-release \
    make \
    netcat-openbsd \
    openssh-client \
    openssh-server \
    postgresql-client-11 \
    python \
    ruby \
    socat \
    stunnel \
    syslinux \
    tar \
    telnet \
    tzdata \
    wget \
    zip \

# install the JDK for certificates, then remove it
apt-get install -y --no-install-recommends ca-certificates-java openjdk-8-jre-headless
apt-get remove -y ca-certificates-java
apt-get -y --purge autoremove
apt-get purge -y openjdk-8-jre-headless
test "$(file -b /etc/ssl/certs/java/cacerts)" = "Java KeyStore"

cat > /etc/ImageMagick-6/policy.xml <<'IMAGEMAGICK_POLICY'
<policymap>
  <policy domain="cache" name="shared-secret" value="passphrase"/>
  <policy domain="coder" rights="none" pattern="EPHEMERAL" />
  <policy domain="coder" rights="none" pattern="URL" />
  <policy domain="coder" rights="none" pattern="HTTPS" />
  <policy domain="coder" rights="none" pattern="MVG" />
  <policy domain="coder" rights="none" pattern="MSL" />
  <policy domain="coder" rights="none" pattern="TEXT" />
  <policy domain="coder" rights="none" pattern="SHOW" />
  <policy domain="coder" rights="none" pattern="WIN" />
  <policy domain="coder" rights="none" pattern="PLT" />
  <policy domain="path" rights="none" pattern="@*" />
</policymap>
IMAGEMAGICK_POLICY

cd /
rm -rf /root/*
rm -rf /tmp/*
rm -rf /var/cache/apt/archives/*.deb
