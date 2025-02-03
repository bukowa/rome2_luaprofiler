MOD_FILE_NAME="rome2_luaprofiler.pack"
IMG_FILE_NAME="rome2_luaprofiler.png"

all: build copy

build:
	rpfm_cli --game rome_2 pack create --pack-path=${MOD_FILE_NAME}
	rpfm_cli --game rome_2 pack add --pack-path=${MOD_FILE_NAME} -F './pack;'

copy: build
	cp ${MOD_FILE_NAME} "C:\Games\Total War - Rome 2\data"
	cp ${IMG_FILE_NAME} "C:\Games\Total War - Rome 2\data"

copy-steam: build
	cp ${MOD_FILE_NAME} "C:\Program Files (x86)\Steam\steamapps\common\Total War Rome II\data"
	cp ${IMG_FILE_NAME} "C:\Program Files (x86)\Steam\steamapps\common\Total War Rome II\data"


release: build copy-steam
