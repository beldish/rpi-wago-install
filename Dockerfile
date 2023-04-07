FROM ubuntu:latest
RUN apt update

#  Install required dependancies
RUN apt install build-essential sudo git -y
RUN apt install libreadline-dev make re2c libc-dev-bin libtirpc-dev -y

# Add user
RUN useradd -rm -d /home/rpiuser -s /bin/bash -g root -G sudo -u 1001 rpiuser
USER rpiuser
WORKDIR /home/rpiuser

# Copy installation files
COPY --chown=rpiuser installation ./installation

# COPY base
COPY --chown=rpiuser base-7.0.7 ./base-7.0.7
RUN ln -s base-7.0.7 base

# Build base
WORKDIR /home/rpiuser/base
RUN make
WORKDIR /home/rpiuser


# Clone & build ASYN
RUN git clone https://github.com/epics-modules/asyn.git
RUN cp installation/releases/asyn_RELEASE ./asyn/configure/RELEASE
RUN cp installation/releases/asyn_CONFIG_SITE ./asyn/configure/CONFIG_SITE
WORKDIR /home/rpiuser/asyn
RUN make
WORKDIR /home/rpiuser

# Clone & build Streams
RUN git clone https://github.com/paulscherrerinstitute/StreamDevice.git
RUN cp installation/releases/stream_RELEASE ./StreamDevice/configure/RELEASE
WORKDIR /home/rpiuser/StreamDevice
RUN make
WORKDIR /home/rpiuser


# Clone & build modbus
RUN git clone https://github.com/epics-modules/modbus.git
RUN cp installation/releases/modbus_RELEASE ./modbus/configure/RELEASE
WORKDIR /home/rpiuser/modbus
RUN make
WORKDIR /home/rpiuser

# Copy & build wago-rpc
COPY --chown=rpiuser rpi-wago ./apps/rpi-wago
COPY --chown=rpiuser ./installation/releases/rpi-wago_RELEASE ./apps/rpi-wago/configure/RELEASE
WORKDIR /home/rpiuser/apps/rpi-wago
RUN make
WORKDIR /home/rpiuser

# Run RPI-WAGO
WORKDIR /home/rpiuser/apps/rpi-wago/iocBoot/iocrpiWagoIoc/
CMD [ "../../bin/linux-x86_64/rpiWagoIoc", "st.cmd" ]
#RUN /usr/bin/bash


