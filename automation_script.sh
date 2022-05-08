cd /etc/cron.d
#write out current crontab
crontab -l > automation
#echo new cron into cron file
echo "0 0 * * * root /root/Automation_Project/automation.sh" >> automation
#install new cron file
crontab automation