# INCIDENT RESPONSE REPORT: PHANTOM PURSUIT
**Operator:** ## PHASE 1: SIEM CORRELATION
* **Initial Alert Source IP:** Kibana/ELK failed to deploy after provisioning. Source IP could not be recovered from SIEM

## PHASE 2: LIVE TRIAGE & CHAIN OF CUSTODY
* **Suspicious Process ID (PID):** 10 (nc listening on port 4444)
* **Evidence SHA256 Hash:** 216777d16633f1f047693b8f9059b4b0afc091aad4121a50af0e92350c09a95

## PHASE 3: DISK FORENSICS
* **Deleted File Inode Number:** 582
* **Extracted Payload Data:** Deleted file beacon.exe located and extracted using: icat compromised_drive.dd 582 > recovered_payload.txt
