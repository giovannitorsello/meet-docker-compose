export JITSI_RELEASE="1.0.0"
export JITSI_REPO="myjitsi"

cd ./base
make

cd ../prosody
make
