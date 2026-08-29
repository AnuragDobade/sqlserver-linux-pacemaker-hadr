
# Multi-Site SQL Server Always On Availability Group with Ubuntu Pacemaker & QDevice Quorum
🚀 **Enterprise Infrastructure Runbook for Cross-Subnet HA/DR Orchestration & Automated Failover Testing**

## 🗺️ 1. Infrastructure Baseline & Architectural Topology

This repository delivers an end-to-end production deployment guide and automated scripting toolkit for building a highly available, cross-subnet **SQL Server Always On Availability Group natively on Ubuntu 22.04 LTS**. Traffic management and node state transitions are fully orchestrated via a hardened **Pacemaker and Corosync** cluster layer.

### Key Architectural Highlights:
* **High Availability (DC Site):** Two local nodes (`DB1` and `DB2`) configured with **Synchronous Data Commit** for zero data loss parameters within Subnet 1.
* **Disaster Recovery (DR Site):** One remote node (`DR-DB1`) configured with **Asynchronous Commit** sitting in an isolated network zone (Subnet 2) for absolute site redundancy.
* **Split-Brain Mitigation:** An external **Corosync QDevice Server** deployed in a neutral network segment (Subnet 3) providing an independent, dynamic tie-breaker quorum vote (`FFSPLIT: split brain and autofailover` architecture).
* **Multi-Subnet Network Balancing:** Virtual IP mapping and independent local load balancer listeners floating across subnet environments to sustain active primary application endpoints.

| Hostname | IP Address | Subnet | Cluster Role / Commit Mode | OS & SQL Version |
| :--- | :--- | :--- | :--- | :--- |
| **DB1** | `172.20.1.144` | Subnet 1 (`172.20.1.0/24`) | Primary Replica / Synchronous Commit | Ubuntu 22.04 / SQL 2022/2025 |
| **DB2** | `172.20.1.239` | Subnet 1 (`172.20.1.0/24`) | Secondary Replica / Synchronous Commit | Ubuntu 22.04 / SQL 2022/2025 |
| **DR-DB1** | `172.30.1.99` | Subnet 2 (`172.30.1.0/24`) | DR Replica / Asynchronous Commit | Ubuntu 22.04 / SQL 2022/2025 |
| **QDEVICE-SERVER** | `10.10.10.178` | Subnet 3 (`10.10.10.0/24`) | Corosync QNetd Daemon / Dynamic Vote Provider | Ubuntu 22.04 (No SQL Server) |
| **DBCluster** | `172.20.1.62` | Subnet 1 (`172.20.1.0/24`) | Core Pacemaker Orchestrator Layer Virtual VIP | Cluster Daemon Layer |

![Multi-Site Orchestrated Ubuntu Pacemaker QDevice Topology](./assets/architecture_multisite_ubuntu.png)

---
