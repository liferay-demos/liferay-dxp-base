# First deploy the services using the script
```
./wedeploy.sh
```

# Steps required after deploying the services
In wedeploy goto the liferay service and in the shell enter the following
```
cp -r /wedeploy-container/staticdata/* /opt/liferay/data
```
Or use the wedeploy shell from your localhost
```
we shell -s liferay -p basedemo
cp -r /wedeploy-container/staticdata/* /opt/liferay/data
exit
```
