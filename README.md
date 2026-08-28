# sqlserver-linux-pacemaker-hadr
Production-grade multi-node, multi-site SQL Server Always On Availability Groups on Linux (Ubuntu/RHEL) using Pacemaker &amp; Corosync. Features AWS STONITH fencing, QDevice quorum mitigation, multi-subnet listeners, zero-downtime rolling patching, and major version upgrades (SQL 19 to 22) optimized for enterprise OS cost reduction (FinOps).

---

## 💰 Detailed Financial Sizing: Azure VM & Multi-OS Pricing Matrix

The following cost-benefit matrix is built directly from production benchmarks on Microsoft Azure. It breaks down an 18-vCPU topology consisting of a High-Availability pair (`db1` and `db2`), a dedicated cluster quorum witness node (`db-cluster`), and an enterprise `Backup Server`. 

By migrating the underlying runtime layer from Windows Server Datacenter to Open-Source Linux (Ubuntu LTS / RHEL), the operating system licensing fee drops to **exactly $0.00**, delivering significant cost reductions without sacrificing database performance.

### 📊 Monthly & Annual TCO Breakdown (Azure Sizing Metrics)

| Component Host / Name | System Hardware Specs | Monthly Compute Hardware | Monthly SQL License | 🟥 Monthly Windows OS Fee | 🐧 Monthly Linux OS Fee | 🟢 Net Capital Saved (Linux) |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **db1** <br>*(Primary Replica)* | 8 vCPU / 64 GB RAM <br>32 GB OS / 1000 GB Data | `$472.92`<br>*(Yearly: $5,675.04)* | `$2,190.00`<br>*(Yearly: $26,280.00)* | `$268.64`<br>*(Yearly: $3,223.68)* | **`$0.00`** | **`$268.64 / mo`**<br>*(Yearly: $3,223.68)* |
| **db2** <br>*(Secondary Replica)* | 8 vCPU / 64 GB RAM <br>32 GB OS / 1000 GB Data | `$472.92`<br>*(Yearly: $5,675.04)* | `$2,190.00`<br>*(Yearly: $26,280.00)* | `$268.64`<br>*(Yearly: $3,223.68)* | **`$0.00`** | **`$268.64 / mo`**<br>*(Yearly: $3,223.68)* |
| **db-cluster** <br>*(Quorum Witness)* | 2 vCPU / 8 GB RAM <br>32 GB OS / 128 GB Data | `$89.28`<br>*(Yearly: $1,071.36)* | `$0.00`<br>*(Yearly: $0.00)* | `$67.16`<br>*(Yearly: $805.92)* | **`$0.00`** | **`$67.16 / mo`**<br>*(Yearly: $805.92)* |
| **Backup Server** <br>*(Cloud Storage Node)* | 2 vCPU / 8 GB RAM <br>32 GB OS / 500 GB Data | `$124.28`<br>*(Yearly: $1,491.36)* | `$0.00`<br>*(Yearly: $0.00)* | `$67.16`<br>*(Yearly: $805.92)* | **`$0.00`** | **`$67.16 / mo`**<br>*(Yearly: $805.92)* |
| **📈 TOTALS** | **18 vCPU / 136 GB RAM** <br>**2,128 GB Disk Pool** | **`$1,159.40 / mo`**<br>*(Yearly: $13,912.80)* | **`$4,380.00 / mo`**<br>*(Yearly: $52,560.00)* | **`$671.60 / mo`**<br>*(Yearly: $8,059.20)* | **`$0.00 / mo`** | **`$671.60 / month`**<br>⚠️ **`$8,059.20 / year`** |

### 🎯 Key Financial Takeaways

* **Windows Total Deployment Cost:** **`$6,211.00 / mo`** (`$74,532.00 / year`)
* **Linux Total Deployment Cost:** **`$5,539.40 / mo`** (`$66,472.80 / year`)
* **Financial Bottom Line:** Switching to your high-availability Linux clustering environment keeps the underlying cloud hardware compute profile identical while recovering exactly **$8,059.20 per year in pure operating system savings** for every cluster layer deployed!

---

