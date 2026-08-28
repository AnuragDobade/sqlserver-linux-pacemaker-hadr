# sqlserver-linux-pacemaker-hadr
Production-grade multi-node, multi-site SQL Server Always On Availability Groups on Linux (Ubuntu/RHEL) using Pacemaker &amp; Corosync. Features AWS STONITH fencing, QDevice quorum mitigation, multi-subnet listeners, zero-downtime rolling patching, and major version upgrades (SQL 19 to 22) optimized for enterprise OS cost reduction (FinOps).

---

## ⚖️ Strategic Architecture: Windows Server vs. Enterprise Linux

Choosing the right underlying operating system dictates the financial and operational scalability of enterprise database infrastructure. By transitioning mission-critical workloads to open-source or enterprise Linux frameworks, organizations completely bypass standard platform overhead while establishing a more resilient high-availability layer.

### 📊 TCO & Operational Capability Matrix

| Evaluation Vector | 🟥 Microsoft Windows Server Stack | 🐧 Enterprise Linux (Ubuntu / RHEL) | 🚀 Enterprise Business Advantage |
| :--- | :--- | :--- | :--- |
| **OS Runtime Licensing** | 💰 **Premium Core Pooling Model**<br>Requires costly Standard/Datacenter per-core retail licensing packs. | 🟢 **\$0 Base Open-Source Cost**<br>Eliminates operating system licensing fees entirely across all cluster nodes. | **Massive CAPEX Reduction:** Reduces basic infrastructure operating expense by 100% at the OS layer. |
| **Access Licensing (CALs)** | 🔒 **Mandatory per User/Device**<br>Requires complex tracking of Client Access Licenses for application connections. | ✨ **Completely Eliminated**<br>No per-user or per-device licensing constraints inherent to the OS. | **Uncapped Scaling:** Scales database access across infinite microservices with zero license expansion penalties. |
| **Cluster Architecture Engine** | ⚙️ **Windows Server Failover Cluster**<br>Heavily coupled with Active Directory (AD) and local domain controller health. | 🛠️ **Pacemaker & Corosync**<br>Decoupled, high-speed open-source clustering stack with zero AD dependencies. | **Failure Domain Isolation:** Keeps database clustering fully operational even during corporate network/AD drops. |
| **Split-Brain Mitigation** | 💿 **Software Lease / Witness Quorum**<br>Relies on shared cloud/disk witness storage heartbeats that can lag during path drops. | ⚡ **Hardware Fencing (STONITH)**<br>Employs robust, cloud-native **AWS STONITH API fencing** and specialized QDevice quorum layers. | **Absolute Data Protection:** Instantly isolates malfunctioning partition nodes to guarantee 0% data corruption risk. |
| **Compute Node Efficiency** | 🖥️ **Dense GUI Subsystem Overhead**<br>Consumes valuable host server background system memory and CPU cycles. | 💻 **Minimal Headless CLI Footprint**<br>Runs lean background execution lines, leaving maximum hardware space for data processing. | **Hardware Optimization:** Reclaims significant memory overhead per host, optimizing cloud VM computing costs. |
| **Uptime & SLA Delivery** | 🕒 Standard OS patching often forces full system node reboots, resulting in cluster failover disruptions. | 🎯 **99.99% Continuous Availability**<br>Supports rapid, rolling zero-downtime Cumulative Updates (CU) via native command utilities. | **Bulletproof Continuity:** Maximizes application service continuity across rolling infrastructure lifecycles. |

---
