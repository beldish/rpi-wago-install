##################################################################
# RPI WAGO Installation script
##################################################################
# Set TestRun - Copies packages and directories from ~/Downloads
# Instead of downloading from official sites. 
##################################################################
TR="N"

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

echo "##################################################################"
echo "EPICS_BASE = $EPICS_BASE"
echo "EPICS_BASE_ARH = $EPICS_BASE_ARH"
echo "##################################################################"

#########################################################
# EPICS BASE
#########################################################
if [ "$SKIP_BASE" != "Y" ]
then

# Download EPICS BASE
echo "Downloading EPICS BASE $EPICS_BASE_ARH"
if [ $TR = "Y" ]
then
cp /home/mbeldis/Downloads/$EPICS_BASE_ARH .
else
wget https://epics.anl.gov/download/base/base-7.0.7.tar.gz
fi

# extract EPICS base
echo "Extracting EPICS BASE $EPICS_BASE_ARH"
####tar zxvf $EPICS_BASE_ARH > /dev/null

# Remove EPICS base archive
echo "Removing EPICS BASE ARCHIVE $EPICS_BASE_ARH"
rm  $EPICS_BASE_ARH

# Make link base to base.version
echo "Linking $EPICS_BASE to base"
ln -sf $EPICS_BASE base

# Compile EPICS BASE
echo "Compiling EPICS_BASE "
cd base
make
cd ..
#pwd
fi
## if [ "$SKIP_BASE" != "Y" ]


#########################################################
# ASYN
#########################################################
if [ "$SKIP_ASYN" != "Y" ]
then

# Download Asyn
echo "Downloading ASYN"
if [ $TR = "Y" ]
then
cp -rf /home/mbeldis/Downloads/asyn .
else
git clone https://github.com/epics-modules/asyn.git
fi

# Update configure/RELEASE file
echo "Updating configure/RELEASE file"
cp releases/asyn_RELEASE ./asyn/configure/RELEASE 

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

# Download STREAM
echo "Downloading STREAM"
if [ $TR = "Y" ]
then
cp -rf /home/mbeldis/Downloads/stream .
else
git clone https://github.com/epics-modules/stream.git
fi
cd stream
git submodule init
git submodule update
cd ..

# Update configure/RELEASE file
echo "Updating configure/RELEASE file"
cp releases/stream_RELEASE ./stream/configure/RELEASE 

# Compile STREAM
echo "Compiling stream "
cd stream
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

# Download MODBUS
echo "Downloading MODBUS"
if [ $TR = "Y" ]
then
cp -rf /home/mbeldis/Downloads/modbus .
else
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

# Download RPI-WAGO
echo "Downloading - rpi-wago"
if [ $TR = "Y" ]
then
cp -rf /home/mbeldis/Downloads/rpi-wago .
else
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






