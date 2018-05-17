BUNDLE_DIR=/tmp/liferay-dxp-digital-enterprise-7.0-sp7 #Ask user?
DB=lportal #Need to find/make this automagically or ask user?

# Export sql?
read -e -p "Export database? " -i "yes" answer
if [ "$answer" = "yes" ]; then
    #rename current dump
    mv mysql/import.sql mysql/import.sql.`date "+%Y%m%d"`
    read -es -p "Please enter password for mysql root@localhost? " PASSWORD
    mysqldump -u root -p$PASSWORD --databases $DB > mysql/import.sql
fi

# Export document_library?
read -e -p "Export document_library? " -i "yes" answer
if [ "$answer" = "yes" ]; then
     tar -zcvf ./liferay/document_library.`date "+%Y%m%d"`.tar.gz ./liferay/staticdata/document_library --remove-files
     cp -r "$BUNDLE_DIR/data/document_library/" "./liferay/staticdata/"
fi

read -e -p "Commit to github? " -i "yes" answer
if [ "$answer" = "yes" ]; then
    git add -A
    git commit -m "updated from local"
    git push origin master
fi