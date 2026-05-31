# Phase 1 Final Reckoning — TEPP Post-Mortem
**Operator:** Ginel Anderson
**Date:** May 28, 2026
**Repository:** https://github.com/ginelanderson/TKH_Phase_1_Lab/commit/97ac6e6bf0bd9f3d35a088c055a50b7eb1091eae
**TKH Innovation Fellowship 2026 | Phase 1 | Cybersecurity**

---

## Phase 0: Reconnaissance

### Triage Network — 172.100.0.0/24
[3–5 sentences in APA style. What hosts did you find? What ports and
services were exposed? What misconfigurations did you identify?]

Three hosts were identified on the 172.100.0.0/24 network. Server 172.100.0.11 was configured with an exposed Redis service on TCP port 6379. Server 172.100.0.12 contained an unauthorized FTP service, while server 172.100.0.13 contained a web directory with overly permissive 777 permissions. These findings indicated a combination of service exposure and insecure system configuration vulnerabilities that required remediation.

### Breach Network — 172.80.0.0/24
[3–5 sentences in APA style. What hosts did you find? What ports and
services were exposed? What did you observe that informed your Phase 2
approach?]

The breach network contained the host 172.80.0.10, which was identified as an SSH target. The provisioning output indicated that authentication logs were mounted in the Midterm_Logs directory for forensic investigation. Because the objective involved credential compromise and log analysis, evidence collection and authentication review were expected to be critical during Phase 2. These observations informed the investigative approach used during the breach analysis.

### Exploitation Network — 172.60.0.0/24
[3–5 sentences in APA style. What hosts did you find? What ports and
services were exposed? What vulnerability did you identify before
executing your exploit?]

The exploitation network contained a web application hosted on 172.60.0.10 over TCP port 80. The provisioning script indicated that access logs were available in the Capstone_Logs directory for forensic review. The presence of a web application and associated logs suggested a command injection or web exploitation scenario. These observations guided the preparation for Phase 3 exploitation and analysis activities.
---

## Phase 1: Rapid Triage

### Server 1 — 172.100.0.11
**Vulnerability Identified:**
[What was exposed and how did you confirm it?]
Redis was exposed on TCP port 6379 and configured to listen on all network interfaces. I confirmed this using `netstat -tulpn`, which showed Redis listening on `0.0.0.0:6379`. I further verified the service was active by running `redis-cli ping`, which returned `PONG`.

**Remediation Commands:**
[Exact commands used to enter the container and apply the fix]
docker exec -it broken_server_1 sh

redis-cli CONFIG GET bind

redis-cli CONFIG SET bind 127.0.0.1

redis-cli CONFIG GET bind

**Before State:**
[What did the service or permission look like before your fix?]
The Redis service was listening on all interfaces using the bind address 0.0.0.0. The command redis-cli CONFIG GET bind returned: 0.0.0.0

**After State:**
[What did it look like after?]
The Redis bind address was changed to 127.0.0.1, restricting access to the local host only and preventing remote connections.

**Analysis:**
[2–3 sentences in APA style — why is this vulnerability dangerous
in a real enterprise environment?]
Exposed Redis instances are frequently targeted by attackers because they often contain sensitive application data and can sometimes be abused to achieve remote code execution. Restricting Redis to localhost follows the principle of least privilege and significantly reduces the attack surface. In an enterprise environment, internal services should not be accessible from untrusted networks unless explicitly required.

### Server 2 — 172.100.0.12
**Vulnerability Identified:**
[What unauthorized service was running and how did you confirm it?]
An unauthorized FTP service (vsftpd) was running on Server 2. The process list showed `/usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf`, confirming an active FTP daemon.

**Remediation Commands:**
[Exact commands used to enter the container and terminate the process]
docker exec -it broken_server_2 sh
ps aux
kill 21
ps aux

**Before State:**
[What was running before your remediation?]
The vsftpd service was running and accepting FTP connections.

**After State:**
[What was the state after termination?]
The vsftpd process was terminated and no longer appeared in the process list.

**Analysis:**
[2–3 sentences in APA style — why is this vulnerability dangerous
in a real enterprise environment?]
FTP is an insecure protocol because credentials and data are commonly transmitted without encryption. Unauthorized FTP services increase the attack surface and provide adversaries with additional opportunities to gain access or exfiltrate information. Removing unnecessary services follows the principle of least functionality and reduces organizational risk.

### Server 3 — 172.100.0.13
**Vulnerability Identified:**
[What directory had dangerous permissions and what were they exactly?]
The web directory `/var/www/html` had world writeable permissions (777). I confirmed by running: 

ls -ld /var/www/html

and it returned: drwxrwxrwx

**Remediation Commands:**
[Exact commands used to enter the container and apply chmod]
docker exec it broken_server3 sh

ls -ld /var/www/html

chmod 755 /var/www/html

ls -ld /var/www/html

**Before State:**
[What were the permissions before your fix? Be specific.]
The `/var/www/html` directory permissions were: drwxrwxrwx
This allowed read, write, and execute access for all users.

**After State:**
[What were the permissions after?]
The `/var/www/html` directory permissions were changed to: drwxr-xr-x
Only the owner retained write permissions while group and other users were limited to read and execute access

**Analysis:**
[2–3 sentences in APA style — why is this vulnerability dangerous
in a real enterprise environment?]
This vulnerability is dangerous in a real enterprise enviornment because world-writable web directories allows any user or process to modify website content or upload malicious files. In an enterprise environment, attackers frequently exploit permissive file permissions to establish persistence, host malware, or deface websites. Restricting permissions to 755 follows the principle of least privilege and reduces the likelihood of unauthorized modifications.
---

## Phase 2: The Breach

**Cracked Credentials:**
- Username: [username]
- Password: [password]

**Forensic Evidence:**
- Exact Timestamp of Successful Login: [timestamp from auth logs]
- Attacker IP Address: [IP recorded in the logs]

**Engineered iptables Rule:**
[Complete iptables command — chain, action, and target IP]

**SOC Analysis:**
[2–3 sentences in APA style — why is a single iptables block rule
insufficient as a standalone defensive measure? What additional
controls would a real SOC deploy alongside it?]

---

## Phase 3: Full Spectrum

**Listener Configuration:**
[What tool, what port, what command did you use to set up your listener?]

**Reverse Shell Payload:**
[The exact curl command you crafted to trigger the exploit]

**Command Injection Explanation:**
[2–3 sentences in APA style — how does command injection work and
why is this application susceptible to it?]

**Forensic Evidence:**
- Process ID (PID): [PID from access.log]
- User-Agent: [User-Agent string from access.log]

**Lockdown Command:**
[Exact iptables command applied inside the container]

**Final Analytical Paragraph:**
[4–6 sentences in APA style responding to: You have now played both
sides of this operation. What does executing this attack teach you
about defending against it? What single defensive control, if it had
been in place before you attacked, would have stopped this breach
entirely — and why?]

---

## References
[APA format. Any tools, documentation, or resources referenced
during this operation.
Example: Hydra Project. (2024). THC-Hydra: A fast and flexible
online password cracking tool. https://github.com/vanhauser-thc/thc-hydra]
