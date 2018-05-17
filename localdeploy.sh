# global variables / locations
ZIPPED_BUNDLE=/media/jverweij/DATA/software/bundle/liferay-dxp-digital-enterprise-tomcat-7.0-sp7-20180307180151313.zip
LICENSE=/media/jverweij/DATA/software/bundle/activation-key-digitalenterprisedevelopment-7.0-janverweij.xml
BASE_DIR=/tmp

# Restore database
read -es -p "Please enter password for mysql root@localhost? " PASSWORD
mysql -u root -p$PASSWORD < mysql/import.sql

rm -rf $BASE_DIR/liferay-dxp-digital-enterprise-7.0-sp7

unzip $ZIPPED_BUNDLE -d $BASE_DIR

cp liferay/portal-ext.properties $BASE_DIR/liferay-dxp-digital-enterprise-7.0-sp7

sed -i 's/jdbc:mysql:\/\/db\//jdbc:mysql:\/\/localhost\//g' $BASE_DIR/liferay-dxp-digital-enterprise-7.0-sp7/portal-ext.properties
sed -i "s/jdbc.default.password=.*$/jdbc.default.password=${PASSWORD}/g" $BASE_DIR/liferay-dxp-digital-enterprise-7.0-sp7/portal-ext.properties
sed -i 's/web.server.protocol=https/web.server.protocol=http/g' $BASE_DIR/liferay-dxp-digital-enterprise-7.0-sp7/portal-ext.properties

#mkdir $BASE_DIR/liferay-dxp-digital-enterprise-7.0-sp7/deploy
cp -r liferay/deploy $BASE_DIR/liferay-dxp-digital-enterprise-7.0-sp7

# Copy documents and media lib??
cp -r liferay/staticdata/document_library $BASE_DIR/liferay-dxp-digital-enterprise-7.0-sp7/data

## Change some ports in tomcat??

## Start the bundle??
read -e -p "Start the demo? " -i "yes" answer
if [ "$answer" = "yes" ]; then
  $BASE_DIR/liferay-dxp-digital-enterprise-7.0-sp7/tomcat-8.0.32/bin/startup.sh
fi

# Copy license??
read -e -p "Copy license? " -i "yes" answer
if [ "$answer" = "yes" ]; then
    cp $LICENSE $BASE_DIR/liferay-dxp-digital-enterprise-7.0-sp7/deploy
fi

## Stop the bundle??
read -e -p "Stop the demo? " -i "yes" answer
if [ "$answer" = "yes" ]; then
  $BASE_DIR/liferay-dxp-digital-enterprise-7.0-sp7/tomcat-8.0.32/bin/shutdown.sh
fi