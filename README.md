# sqlserver-linux-pacemaker-hadr
Production-grade multi-node, multi-site SQL Server Always On Availability Groups on Linux (Ubuntu/RHEL) using Pacemaker &amp; Corosync. Features AWS STONITH fencing, QDevice quorum mitigation, multi-subnet listeners, zero-downtime rolling patching, and major version upgrades (SQL 19 to 22) optimized for enterprise OS cost reduction (FinOps).

---

## ⚖️ Strategic Architecture: Windows Server vs. Enterprise Linux

Choosing the right underlying operating system dictates the financial and operational scalability of enterprise database infrastructure. By transitioning mission-critical workloads to open-source or enterprise Linux frameworks, organizations completely bypass standard platform overhead while establishing a more resilient high-availability layer.

### 📊 TCO & Operational Capability Matrix

### 💵 Financial Cost-Benefit Sizing (Example Stack: 8 vCPU Infrastructure)

The following financial breakdown models a typical production environment spanning a 4-Node topology: DB1 (Primary), DB2 (Synchronous Standby), a Cluster Witness Node, and a Dedicated Backup Server. By dropping the Windows constraint, the OS runtime licensing and recurrent CAL expenses drop to zero.

| Infrastructure Sizing & Assets | 🖥️ Hardware Compute Cost (Fixed) | 🟥 Windows Server Deployment Stack | 🐧 Linux Deployment Stack (Ubuntu/RHEL) |
| :--- | :--- | :--- | :--- |
| **DB1 (Primary Node)**<br>8 vCPU / 64GB RAM / 1TB SSD | `$2,978.88` | `$2,978.88` + OS License Premium | **`$2,978.88`** + 🟢 `$0` OS License |
| **DB2 (Standby Node)**<br>8 vCPU / 64GB RAM / 1TB SSD | `$2,978.88` | `$2,978.88` + OS License Premium | **`$2,978.88`** + 🟢 `$0` OS License |
| **DB-Cluster (Witness Node)**<br>4 vCPU / 8GB RAM / 100GB Disk | `$669.15` | `$669.15` + OS License Premium | **`$669.15`** + 🟢 `$0` OS License |
| **Dedicated Backup Server**<br>4 vCPU / 8GB RAM / 1TB Storage | `$1,040.40` | `$1,040.40` + OS License Premium | **`$1,040.40`** + 🟢 `$0` OS License |
| **SQL Server Licensing**<br>8 vCPU Mandatory Baseline | — | `$15,000` to `$60,000` (Recurring Core Fees) | **Identical Engine Licensing Match** |
| **Windows Server CALs Overhead** | — | ❌ **High Variable Cost** (Per User/Device) | 🟢 **`$0.00` Completely Eliminated** |
| **Underlying Operating System Fee** | — | ❌ **Datacenter/Standard Core License** | 🟢 **`$0.00` (100% Free Open-Source OS)** |
| **💸 SUMMARY TOTAL OVERHEAD** | Baseline VM Compute Run | ⚠️ **Hardware Run + Heavy OS Premium Fees** | 🎯 **Raw Hardware Compute Run Only** |

---
