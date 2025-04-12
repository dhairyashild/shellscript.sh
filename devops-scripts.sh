#!/bin/bash
# Linux Automation Mega Script (25-in-1)

# --------------------------
# 1. Monitor Disk Usage and Alert if Over 80%
# --------------------------
monitor_disk() {
  usage=$(df / | awk 'NR==2 {print $5}' | sed 's/%//')
  [ "$usage" -gt 80 ] && echo "Disk usage is above 80%! ($usage%)"
}

# --------------------------
# 2. Clean /tmp Directory Older Than 7 Days
# --------------------------
clean_tmp() {
  find /tmp -type f -mtime +7 -exec rm -f {} \;
}

# --------------------------
# 3. Monitor Web Service and Alert on Failure
# --------------------------
monitor_web() {
  URL="http://yourservice.com"
  curl -s --head $URL | grep "200 OK" > /dev/null || echo "Service down!"
}

# --------------------------
# 4. Rotate Logs and Keep Last 5
# --------------------------
rotate_logs() {
  cd /var/log/myapp
  ls -tp | grep -v '/$' | tail -n +6 | xargs -I {} rm -- {}
}

# --------------------------
# 5. Backup MySQL DB Daily With Timestamp
# --------------------------
backup_mysql() {
  mysqldump -u root -pYourPassword dbname > /backup/db_$(date +%F).sql
}

# --------------------------
# 6. Validate IPs in a Text File
# --------------------------
validate_ips() {
  grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}' ips.txt | while read ip; do
    if [[ $ip =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]]; then echo "Valid: $ip"; fi
  done
}

# --------------------------
# 7. Ping Servers from a File
# --------------------------
ping_servers() {
  while read ip; do
    ping -c 1 $ip > /dev/null && echo "$ip is up" || echo "$ip is down"
  done < servers.txt
}

# --------------------------
# 8. Email Top CPU-consuming Processes
# --------------------------
email_cpu() {
  ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6 | mail -s "Top CPU processes" you@example.com
}

# --------------------------
# 9. SSH into Multiple Servers and Execute Commands
# --------------------------
ssh_servers() {
  while read server; do
    ssh user@$server 'uptime'
  done < servers.txt
}

# --------------------------
# 10. Archive Application Logs to S3
# --------------------------
archive_s3() {
  tar czf app_logs_$(date +%F).tar.gz /var/log/myapp/
  aws s3 cp app_logs_$(date +%F).tar.gz s3://your-bucket-name/
}

# --------------------------
# 11. Restart Service if Down
# --------------------------
restart_service() {
  if ! systemctl is-active --quiet nginx; then
    systemctl restart nginx
  fi
}

# --------------------------
# 12. Tail Multiple Logs in Parallel
# --------------------------
tail_logs() {
  tail -f /var/log/app1.log /var/log/app2.log
}

# --------------------------
# 13. Monitor SSL Certificate Expiry
# --------------------------
ssl_expiry() {
  echo | openssl s_client -servername example.com -connect example.com:443 2>/dev/null | openssl x509 -noout -enddate
}

# --------------------------
# 14. Count Failed Logins in Log File
# --------------------------
failed_logins() {
  grep "Failed password" /var/log/auth.log | wc -l
}

# --------------------------
# 15. Report Users with UID > 1000
# --------------------------
uid_users() {
  awk -F: '$3 > 1000 {print $1, $3}' /etc/passwd
}

# --------------------------
# 16. Find and Kill Zombie Processes
# --------------------------
kill_zombies() {
  ps aux | awk '$8=="Z" {print $2}' | xargs -r kill -9
}

# --------------------------
# 17. Compare Two Directories
# --------------------------
compare_dirs() {
  diff -r dir1/ dir2/
}

# --------------------------
# 18. Monitor Net
