##################################################################

# RPI WAGO Installation script
##################################################################

###################################################################
###################################################################
# !!!Run this script under dos2unix and install ca-certificates.!!!
# sudo apt install libntirpc-dev
###################################################################
###################################################################



##################################################################
# Conditionals for installing or skipping several packages
# Set to "Y" and package will be ignored
##################################################################
# Do not build base
SKIP_BASE="N"

# Do not build ASYN
SKIP_ASYN="N"

# Do not build STREAM
SKIP_STREAM="N"

# Do not build MODBUS
SKIP_MODBUS="N"

# Do not build RPI-WAGO
SKIP_RPI_WAGO="N"
##################################################################



##################################################################
# Sets EPICS base version. 
# (Update this variable if you need different EPICS Base version)
# All other packages will be gownloaded from git repos.
##################################################################
# Set EPICS BASE
EPICS_BASE=base-7.0.7
##################################################################
EPICS_BASE_ARH=$EPICS_BASE.tar.gz

DWNDIR=/home/mbeldis/Downloads

echo "##################################################################"
echo "EPICS_BASE = $EPICS_BASE"
echo "EPICS_BASE_ARH = $EPICS_BASE_ARH"
echo "##################################################################"

#########################################################
# EPICS BASE
#########################################################
if [ "$SKIP_BASE" != "Y" ]
then

# Check Base exist in current dir
if [ -d "$EPICS_BASE" ];
then
echo "$EPICS_BASE is in a Root DIR"
else
# copy from Downloads
echo "Copying from Downloads"
DN_EPICS_BASE=$DWNDIR/$EPICS_BASE
echo $DN_EPICS_BASE
cp -r $DN_EPICS_BASE .
fi

# Make link base to base.version
echo "Linking $EPICS_BASE to base"
ln -sf $EPICS_BASE base

# Compile EPICS BASE
echo "Compiling EPICS_BASE "
cd base
make
cd ..
pwd
fi
## if [ "$SKIP_BASE" != "Y" ]


#########################################################
# ASYN
#########################################################
if [ "$SKIP_ASYN" != "Y" ]
then

# Check asyn exists in current dir
if [ -d "asyn" ];
then
echo "asyn is in a Root DIR"
else
# Clone Asyn
echo "Cloning ASYN"
git clone https://github.com/epics-modules/asyn.git
fi

# Update configure/RELEASE file
echo "Updating configure/RELEASE file"
cp releases/asyn_RELEASE ./asyn/configure/RELEASE

# Update configure/CONFIG_SITE file
echo "Updating configure/CONFIG_SITE file"
cp releases/asyn_CONFIG_SITE ./asyn/configure/CONFIG_SITE



# Compile Asyn
echo "Compiling asyn "
cd asyn
make
cd ..
#pwd
fi
# if [ $SKIP_ASYN -ne "Y" ]

#########################################################
# STREAM
#########################################################
if [ "$SKIP_STREAM" != "Y" ]
then

# Check StreamDevice exists in current dir
if [ -d "StreamDevice" ];
then
echo "StreamDevice is in a Root DIR"
else
# Clone StreamDevice
echo "Cloning StreamDevice"
git clone https://github.com/paulscherrerinstitute/StreamDevice.git
fi

# Update configure/RELEASE file
echo "Updating configure/RELEASE file"
cp releases/stream_RELEASE ./StreamDevice/configure/RELEASE 

# Compile StreamDevice
echo "Compiling StreamDevice "
cd StreamDevice
make
cd ..
#pwd
fi
# if [ $SKIP_STREAM -ne "Y" ]

#########################################################
# MODBUS
#########################################################
if [ "$SKIP_MODBUS" != "Y" ]
then

# Check modbus exists in current dir
if [ -d "modbus" ];
then
echo "modbus is in a Root DIR"
else
# Clone modbus
echo "Cloning modbus"
git clone https://github.com/epics-modules/modbus.git
fi

# Update configure/RELEASE file
echo "Updating configure/RELEASE file"
cp releases/modbus_RELEASE ./modbus/configure/RELEASE 

# Compile MODBUS
echo "Compiling modbus "
cd modbus
make
cd ..
#pwd

fi
# if [ $SKIP_MODBUS -ne "Y" ]



#########################################################
# RPI-WAGO
#########################################################
if [ "$SKIP_RPI_WAGO" != "Y" ]
then


mkdir -p apps
cd apps

# Check rpi-wago exists in apps dir
if [ -d "rpi-wago" ];
then
echo "rpi-wago is in apps DIR"
elif [ -d $DWNDIR/rpi-wago ]
then
# copy from Downloads
echo "Copying rpi-wago from Downloads"
cp -r $DWNDIR/rpi-wago .
else
# Clone rpi-wago
echo "Cloning rpi-wago"
git clone git@git.ccfe.ac.uk:mbeldis/rpi-wago.git
fi

# Update configure/RELEASE file
echo "Updating configure/RELEASE file"
cp ../releases/rpi-wago_RELEASE ./rpi-wago/configure/RELEASE 

# Compile rpi-wago
echo "Compiling rpi-wago "
cd rpi-wago
make
cd ..
#pwd
fi
# if [ $SKIP_RPI_WAGO -ne "Y" ]






