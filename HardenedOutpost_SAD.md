# TITAN SMALL BUSINESS SERVICES: SECURITY ARCHITECTURE DOCUMENT (SAD)
**Operator:** Ginel Anderson
**Date:** 5/3/2026

## 1. Perimeter Hardening (UFW & SSH)
**SSH Status:** 
- Disabled root login (PermitRootLogin no)
- Disabled password authentication (PasswordAuthentication no)
- Restarted SSH service using: sudo systemctl restart ssh

**Firewall Logic:** 
- Default policy set to deny incoming traffic: sudo ufw default deny
- Allowed SSH access: sudo ufw allow 22
- Allowed web application port: sudo ufw allow 8080
- Firewall enabled: sudo ufw enable

## 2. The Automated Auditor (Python)
**Script Logic:** 
import os

output = os.popen("df -h").read()

with open("/var/log/sys_audit.log", "w") as f:
    f.write(output)

print("Audit complete. Log written to /var/log/sys_audit.log")

**Telemetry Path:** `/var/log/sys_audit.log`

## 3. Containerized App (Docker)
**Network Isolation:** 
- Created two networks: frontend and backend
- Wordpress container connected to both frontend and backend networks
- MySQL container connected only to backend network
- Backend network set as internal: true, preventing direct host access to the database

**Stack Health:** 
- Verified running containers using: sudo docker ps
- Both containers (wordpress and mysql) are running successfully

## 4. Executive Summary
The system was hardened by restricting SSH access and enforcing strict firewall rules.
A custom Python auditing script was deployed to monitor disk usage and log system telemetry.
The applicstion stack was securely containerized with proper network isloations, ensuring the database 
is protected from external access. 
