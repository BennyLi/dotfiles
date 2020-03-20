#! /bin/sh

TMP_PROFILE="/tmp/firefox-kiosk-profile/"
WM_CLASS_NAME="firefox-kiosk-$RANDOM"

if [ -d $TMP_PROFILE ]
then
  rm -rf $TMP_PROFILE
fi
mkdir $TMP_PROFILE

echo "Creating temp profile from current profile ..."
cp --recursive ~/.mozilla/firefox/*.dev-edition-default/* $TMP_PROFILE
echo "Temp profile created at $TMP_PROFILE"

echo "Removing all open tabs (the session store) ..."
rm ${TMP_PROFILE}sessionstore.jsonlz4
rm ${TMP_PROFILE}sessionstore-backups/*

echo "Starting firefox in kiosk mode ..."
firefox-developer-edition \
  --profile "$TMP_PROFILE" \
  --new-instance \
  --no-remote \
  --class=$WM_CLASS_NAME \
  --kiosk "$@" \
  2>&1 > /dev/null &

while [ "$(xdotool search -class "$WM_CLASS_NAME" | wc -l)" == "0" ]
do
  echo "Waiting for window ..."
  sleep 1.0
done

# We have to wait a while for firefox to initialize the kiosk mode.
# If we toggle the fullscreen too quick, it will be no kiosk mode window!
sleep 1.0
echo "Toggle fullscreen"
i3-msg "fullscreen toggle"
