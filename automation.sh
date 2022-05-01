
#Create variable for S3 bucket
bucket_name=upgrad-mayurthole

#update of the package
sudo apt update -y

#Check if apache2 server is already installed
sudo apache2 -v

#Install the apache2 package
sudo apt install apache2

echo "Installed apache2 service."

#Script checks whether the server is running or not. If it is not running, then it starts the server
#!/bin/bash
servstat=$(service apache2 status)

if [[ $servstat == *"active (running)"* ]]; then
  echo "Apache2 process is already running"
else
     echo "Apache2 process is not running, starting service now"
     sudo systemctl start apache2.service
fi


## Script ensures that the Apache2 service runs on restart/reboot
sudo update-rc.d apache2 defaults
echo "Configured Apache2 service runs on restart/reboot"


#Create tar of access.log and error.log present at location /var/log/apache2/ and copy tar file to /tmp/ directory
cd /var/log/apache2/
find . -iname '*.log' -print0 | xargs -0 tar zcf /tmp/Mayur-httpd-logs-01052022-044044.tar
echo "access.log and error.log tar file created and copied to /tmp/ location"

#Copy tar file to S3 bucket
cd /tmp/
aws s3 cp Mayur-httpd-logs-01052022-044044.tar s3://${bucket_name}
echo "Copied tar file to S3 bucket created"
