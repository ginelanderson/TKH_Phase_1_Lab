# TITANCORP: PERIMETER ASSESSMENT REPORT
**Operator:** **Target Subnet:** 172.88.0.0/24

## PHASE 1: ACTIVE ENUMERATION (NMAP)
*(List the live IPs discovered and their running services/versions)*
* **Host 1 (172.88.0.10):** nginx 1.14.2 on Port 80/tcp
* **Host 2 (172.88.0.15):** No significant open services detected during scan
* **Host 3 (172.88.0.20):** Apache httpd 2.4.67 ((Unix)) on Port 80/tcp

## PHASE 2: VULNERABILITY AUDIT (NIKTO)
*(Run Nikto against the TWO web servers discovered above. List one major finding for each.)*
* **Web Server 1 Finding:** Missing security headers such as X-Frame-Options were identified on the nginx web server, increasing exposure to clickjacking attacks.
* **Web Server 2 Finding:** The Apache web server was running an outdated software version that may contain vulnerabilities exploitable by remote attackers.

## PHASE 3: RISK TRIAGE
*(Review your findings. Identify the SINGLE highest-risk vulnerability across the entire DMZ. Justify why it is the top priority using the Likelihood x Impact formula.)*

* **Top Priority Remediation:** Outdated internet-facing nginx server
* **Justification:** The outdated nginx server represents the highest real-world risk because it is publicly accessible and vulnerable software increases both the likelihood of a compromise and the impact on the business after a successful attack.
