NAME='MTMR'

rm -r Release 2>/dev/null

xcodebuild archive \
	-scheme "$NAME" \
	-archivePath Release/App.xcarchive

xcodebuild \
	-exportArchive \
	-archivePath Release/App.xcarchive \
	-exportOptionsPlist export-options.plist \
	-exportPath Release

cd Release
rm -r App.xcarchive

# Prerequisite: npm i -g create-dmg
create-dmg "${NAME}.app"

VERSION=`mdls -raw -name kMDItemVersion ${NAME}.app`

echo $VERSION
zip -r "${NAME}v${VERSION}.zip" "${NAME}.app"
