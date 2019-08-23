#! /usr/bin/env sh

TZ=${TZ:-Europe/Berlin}

CONFIG_FILE_VOLUME=""
CONTAINER_NAME_PARAM=""
while [ $# -gt 0 ]
do
  case $1 in
    -c|--config)
      shift
      CONFIG_FILE_VOLUME="-v $1:/etc/matterhorn/config.ini"
      ;;
    -n|--name)
      shift
      CONTAINER_NAME_PARAM="--name $1"
      ;;
    *)
      >2 echo "Unknown parameter $1"
  esac
  shift
done

/usr/bin/docker run -it --rm \
                    $CONTAINER_NAME_PARAM \
                    $CONFIG_FILE_VOLUME \
                    -e TZ \
                    `# Add notification support` \
                    -e DBUS_SESSION_BUS_ADDRESS \
                    -v "$(echo $DBUS_SESSION_BUS_ADDRESS | cut -d= -f2):$(echo $DBUS_SESSION_BUS_ADDRESS | cut -d= -f2)" \
                    -u $(id -u) \
                    bennyli/matterhorn
