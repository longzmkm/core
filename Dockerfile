#ARG BUILD_FROM
FROM homeassistant/amd64-homeassistant-base:8.2.1

ENV \
    S6_SERVICES_GRACETIME=60000

WORKDIR /usr/src

## Setup Home Assistant
COPY . homeassistant/
RUN \
    pip3.8 install  --no-index  -r homeassistant/requirements_all.txt -i  https://pypi.tuna.tsinghua.edu.cn/simple\
    && pip3.8 uninstall -y typing \
    && pip3.8 uninstall -y pymodbus \
#    && pip3 install  --no-index  \
#    -e ./homeassistant -i -i https://pypi.tuna.tsinghua.edu.cn/simple \
#    && git clone -b newlandPymodbus https://github.com/longzmkm/pymodbus.git \
#    && cd pymodbus \
#    && python3 setup.py \
    && python3.8 -m compileall homeassistant/homeassistant

# Home Assistant S6-Overlay
COPY rootfs /

WORKDIR /config
