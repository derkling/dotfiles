## Based on spacemacs's Dokerfile:
##  dotfiles/spacemacs/.emacs.d/Dockerfile
## extended to install my own dotfiles
##
## Build with:
##  docker build -t derkling/spacemacs:1.0 .
##
## Run with:
##
##  docker run -ti --name spacemacs \
##   -e DISPLAY="unix$DISPLAY" \
##   -e UNAME="spacemacser" \
##   -e UID="1000" \
##   -e TZ=Europe/London \
##   -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
##   -v /etc/localtime:/etc/localtime:ro \
##   -v /etc/machine-id:/etc/machine-id:ro \
##   -v /var/run/dbus:/var/run/dbus \
##   -v ~/dotfiles:/home/emacs/dotfiles \
##   derkling/spacemacs:1.0

FROM jare/emacs:latest

# Let's make it simple to find this image
LABEL org.duckdns.derkling.vendor="Derkling"
LABEL org.duckdns.derkling.label-with-value="derkling-dotfiles"
LABEL description="Docked based installation for Derkling's dotfiles"
LABEL version="1.0"

# Tune jare/emacs settings
ENV UNAME="spacemacser" \
    UID="1000"

# Make dotfiles available from within the container
VOLUME "${UHOME}/dotfiles"

# Install additional spacemacs related software
RUN apt-get update \
    && apt-get install wget


# Spacemacs installation
# ======================

# Install fonts required by Spacemacs
ENV NNG_URL="https://github.com/google/fonts/raw/master/ofl/\
nanumgothic/NanumGothic-Regular.ttf" \
    SCP_URL="https://github.com/adobe-fonts/source-code-pro/\
archive/2.030R-ro/1.050R-it.tar.gz"
RUN mkdir -p /usr/local/share/fonts \
    && wget -qO- "${SCP_URL}" | tar xz -C /usr/local/share/fonts \
    && wget -q "${NNG_URL}" -P /usr/local/share/fonts \
    && fc-cache -fv

# Add spacemacs to the container image
COPY .emacs.d ${UHOME}/.emacs.d

# Init Spacemacs
RUN cp ${UHOME}/.emacs.d/core/templates/.spacemacs.template ${UHOME}/ \
    && mv ${UHOME}/.spacemacs.template ${UHOME}/.spacemacs \
    && sed -i "s/\(-distribution 'spacemacs\)/\1-docker/" \
    ${UHOME}/.spacemacs \
    && asEnvUser emacs -batch -u ${UNAME} -kill \
    && asEnvUser emacs -batch -u ${UNAME} -kill \
    && chmod ug+rw -R ${UHOME}

# Test Spacemacs
RUN asEnvUser make -C ${UHOME}/.emacs.d/tests/core/ test \
    && cd ${UHOME}/.emacs.d \
    && printf "SPACEMACS REVISION: %s\n" "$(git rev-parse --verify HEAD)"

RUN ln -s \
    ${UHOME}/.emacs.d/layers/+distributions/spacemacs-docker/deps-install/run \
    /usr/local/sbin/install-deps \
    && chown root:root /usr/local/sbin/install-deps \
    && chmod 770 /usr/local/sbin/install-deps

COPY spacemacs.syslink ${UHOME}/.spacemacs

# Cleanup image
RUN apt-get purge wget \
    && chmod ug+rw -R ${UHOME} \
    && rm -rf /tmp/* /var/lib/apt/lists/* /root/.cache/*

