# sqlserver-linux-pacemaker-hadr
Production-grade multi-node, multi-site SQL Server Always On Availability Groups on Linux (Ubuntu/RHEL) using Pacemaker &amp; Corosync. Features AWS STONITH fencing, QDevice quorum mitigation, multi-subnet listeners, zero-downtime rolling patching, and major version upgrades (SQL 19 to 22) optimized for enterprise OS cost reduction (FinOps).

---

## 💰 Detailed Financial Sizing: Azure VM & Multi-OS Pricing Matrix

The following cost-benefit matrix is built directly from production benchmarks on Microsoft Azure. It breaks down an 18-vCPU topology consisting of an Active-Active Readable Availability Group pair (`db1` and `db2`), a dedicated cluster quorum witness node (`db-cluster`), and an enterprise `Backup Server`.

> ⚠️ **Critical Licensing Compliance Note:** Under official Microsoft licensing policies, a secondary node is only free if it remains completely passive. Because this architecture configures `db2` as an **Active Readable Secondary** to offload read-heavy reporting workloads, **both database engine nodes must be fully licensed** for SQL Server.

### 📊 Monthly & Annual TCO Breakdown (Azure Sizing Metrics)

| Component Host / Name | System Hardware Specs | Monthly Compute Hardware | Monthly SQL License | 🟥 Monthly Windows OS Fee | 🐧 Monthly Linux OS Fee | 🟢 Net Capital Saved (Linux) |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **db1** <br>*(Primary Replica)* | 8 vCPU / 64 GB RAM <br>32 GB OS / 1000 GB Data | `$472.92`<br>*(Yearly: $5,675.04)* | `$2,190.00`<br>*(Yearly: $26,280.00)* | `$268.64`<br>*(Yearly: $3,223.68)* | **`$0.00`** | **`$268.64 / mo`**<br>*(Yearly: $3,223.68)* |
| **db2** <br>*(Active Readable Secondary)* | 8 vCPU / 64 GB RAM <br>32 GB OS / 1000 GB Data | `$472.92`<br>*(Yearly: $5,675.04)* | `$2,190.00`<br>*(Yearly: $26,280.00)* | `$268.64`<br>*(Yearly: $3,223.68)* | **`$0.00`** | **`$268.64 / mo`**<br>*(Yearly: $3,223.68)* |
| **db-cluster** <br>*(Quorum Witness)* | 2 vCPU / 8 GB RAM <br>32 GB OS / 128 GB Data | `$89.28`<br>*(Yearly: $1,071.36)* | `$0.00`<br>*(Yearly: $0.00)* | `$67.16`<br>*(Yearly: $805.92)* | **`$0.00`** | **`$67.16 / mo`**<br>*(Yearly: $805.92)* |
| **Backup Server** <br>*(Cloud Storage Node)* | 2 vCPU / 8 GB RAM <br>32 GB OS / 500 GB Data | `$124.28`<br>*(Yearly: $1,491.36)* | `$0.00`<br>*(Yearly: $0.00)* | `$67.16`<br>*(Yearly: $805.92)* | **`$0.00`** | **`$67.16 / mo`**<br>*(Yearly: $805.92)* |
| **📈 TOTALS** | **18 vCPU / 136 GB RAM** <br>**2,128 GB Disk Pool** | **`$1,159.40 / mo`**<br>*(Yearly: $13,912.80)* | **`$4,380.00 / mo`**<br>*(Yearly: $52,560.00)* | **`$671.60 / mo`**<br>*(Yearly: $8,059.20)* | **`$0.00 / mo`** | **`$671.60 / month`**<br>⚠️ **`$8,059.20 / year`** |

### 🎯 Key Financial Takeaways

*   **Windows Total Deployment Cost:** **`$6,211.00 / mo`** (`$74,532.00 / year`)
*   **Linux Total Deployment Cost:** **`$5,539.40 / mo`** (`$66,472.80 / year`)
*   **Financial Bottom Line:** Switching to your high-availability Linux clustering environment keeps the underlying cloud hardware compute profile entirely identical while recovering **exactly $8,059.20 per year in pure operating system savings** for every cluster layer deployed!

---



---

## 💰 Breaking Down SQL Server Subscription Models [ DB1 is Primary, DB2 is Readonly for Reporting Workloads]

The matrix below maps out your architecture across an 18-vCPU enterprise topology spanning: `db1` (Primary Replica), `db2` (**Active Readable Secondary**), a dedicated `db-cluster` (Quorum Witness Node), and a standalone cloud `Backup Server`.

> ⚠️ **Critical Licensing Compliance Note:** Under official Microsoft licensing policies, a secondary node is only free if it is completely passive. Because this architecture configures `db2` as an **Active Readable Secondary** to offload reporting and read-heavy workloads, **both nodes must be fully licensed** for SQL Server. This configuration makes the underlying Linux OS cost optimization even more critical to prevent overall infrastructure budget bloat.

### 📊 Comprehensive Sizing, Platform, & Database Matrix

| Component Node Name | VM Hardware Specs | Monthly Hardware Compute | 🟥 Monthly Windows OS Fee | 🐧 Monthly Linux OS Fee | 🏛️ Model 1: Upfront (Perpetual + SA)<br>Year 1 Capital / Year 2+ SA | ⚡ Model 2: Pay-As-You-Go<br>(Azure Arc Engine PAYG) | 📦 Model 3: Subscription<br>(Annual OPEX Model) |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **db1** <br>*(Primary Engine)* | 8 vCPU / 64 GB RAM <br>1000 GB NVMe Pool | `$472.92`<br>*(Yearly: $5,675.04)* | `$268.64`<br>*(Yearly: $3,223.68)* | **`$0.00`** | **Year 1:** `$60,492.00` <br>**Year 2+:** `$15,123.00/yr` | `$2,190.00 / mo`<br>*(Yearly: $26,280.00)* | `$21,736.00 / yr`<br>*(Equivalent: $1,811.33/mo)* |
| **db2** <br>*(Active Readable Secondary)* | 8 vCPU / 64 GB RAM <br>1000 GB NVMe Pool | `$472.92`<br>*(Yearly: $5,675.04)* | `$268.64`<br>*(Yearly: $3,223.68)* | **`$0.00`** | **Year 1:** `$60,492.00` <br>**Year 2+:** `$15,123.00/yr` | `$2,190.00 / mo`<br>*(Yearly: $26,280.00)* | `$21,736.00 / yr`<br>*(Equivalent: $1,811.33/mo)* |
| **db-cluster** <br>*(Quorum Witness)* | 2 vCPU / 8 GB RAM <br>128 GB Storage | `$89.28`<br>*(Yearly: $1,071.36)* | `$67.16`<br>*(Yearly: $805.92)* | **`$0.00`** | 🟢 **`$0.00`** <br>*(No SQL Engine Active)* | 🟢 **`$0.00`** <br>*(No SQL Engine Active)* | 🟢 **`$0.00`** <br>*(No SQL Engine Active)* |
| **Backup Server** <br>*(Cloud Storage)* | 2 vCPU / 8 GB RAM <br>500 GB Storage | `$124.28`<br>*(Yearly: $1,491.36)* | `$67.16`<br>*(Yearly: $805.92)* | **`$0.00`** | 🟢 **`$0.00`** <br>*(No SQL Engine Active)* | 🟢 **`$0.00`** <br>*(No SQL Engine Active)* | 🟢 **`$0.00`** <br>*(No SQL Engine Active)* |
| **📈 TOTALS** | **18 vCPU / 136 GB RAM** <br>**2,128 GB Disk Pool** | **`$1,159.40 / mo`**<br>*(Yearly: $13,912.80)* | **`$671.60 / mo`**<br>*(Yearly: $8,059.20)* | **`$0.00 / mo`** | **Year 1:** `$120,984.00` <br>**Year 2+:** `$30,246.00/yr` | **`$4,380.00 / mo`** <br>*(Yearly: $52,560.00)* | **`$43,472.00 / yr`** <br>*(Yearly Engine Run)* |


---


---

## 💰 Breaking Down SQL Server Subscription Models [ DB1 is Primary, DB2 is DR readable only when becomes primary]

The matrix below maps out your architecture across an 18-vCPU enterprise topology spanning: `db1` (Primary Replica), `db2` (Secondary HA Replica non readable), a dedicated `db-cluster` (Quorum Witness Node), and a standalone cloud `Backup Server`.

### 📊 Comprehensive Sizing, Platform, & Database Matrix

| Component Node Name | VM Hardware Specs | Monthly Hardware Compute | 🟥 Monthly Windows OS Fee | 🐧 Monthly Linux OS Fee | 🏛️ Model 1: Upfront (Perpetual + SA)<br>Year 1 Capital / Year 2+ SA | ⚡ Model 2: Pay-As-You-Go<br>(Azure Arc Engine PAYG) | 📦 Model 3: Subscription<br>(Annual OPEX Model) |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **db1** <br>*(Primary Engine)* | 8 vCPU / 64 GB RAM <br>1000 GB NVMe Pool | `$472.92`<br>*(Yearly: $5,675.04)* | `$268.64`<br>*(Yearly: $3,223.68)* | **`$0.00`** | **Year 1:** `$60,492.00` <br>**Year 2+:** `$15,123.00/yr` | `$2,190.00 / mo`<br>*(Yearly: $26,280.00)* | `$21,736.00 / yr`<br>*(Equivalent: $1,811.33/mo)* |
| **db2** <br>*(HA Secondary)* | 8 vCPU / 64 GB RAM <br>1000 GB NVMe Pool | `$472.92`<br>*(Yearly: $5,675.04)* | `$268.64`<br>*(Yearly: $3,223.68)* | **`$0.00`** | 🟢 **`$0.00`** <br>*(Included via SA HA Benefit)* | 🟢 **`$0.00`** <br>*(Included via Azure PAYG HA)* | 🟢 **`$0.00`** <br>*(Included via Subscription HA)* |
| **db-cluster** <br>*(Quorum Witness)* | 2 vCPU / 8 GB RAM <br>128 GB Storage | `$89.28`<br>*(Yearly: $1,071.36)* | `$67.16`<br>*(Yearly: $805.92)* | **`$0.00`** | 🟢 **`$0.00`** <br>*(No SQL Engine Active)* | 🟢 **`$0.00`** <br>*(No SQL Engine Active)* | 🟢 **`$0.00`** <br>*(No SQL Engine Active)* |
| **Backup Server** <br>*(Cloud Storage)* | 2 vCPU / 8 GB RAM <br>500 GB Storage | `$124.28`<br>*(Yearly: $1,491.36)* | `$67.16`<br>*(Yearly: $805.92)* | **`$0.00`** | 🟢 **`$0.00`** <br>*(No SQL Engine Active)* | 🟢 **`$0.00`** <br>*(No SQL Engine Active)* | 🟢 **`$0.00`** <br>*(No SQL Engine Active)* |
| **📈 TOTALS** | **18 vCPU / 136 GB RAM** <br>**2,128 GB Disk Pool** | **`$1,159.40 / mo`**<br>*(Yearly: $13,912.80)* | **`$671.60 / mo`**<br>*(Yearly: $8,059.20)* | **`$0.00 / mo`** | **Year 1:** `$60,492.00` <br>**Year 2+:** `$15,123.00/yr` | **`$2,190.00 / mo`** <br>*(Yearly: $26,280.00)* | **`$21,736.00 / yr`** <br>*(Yearly Engine Run)* |


---


---

## 🌐 Verified Upstream Reference Data & Pricing Truth

All infrastructure calculation models, software core metrics, and cross-platform operating fees are strictly audited against current official vendor endpoints to ensure absolute pricing accuracy:

### 1. Cloud-Native Compute & Hybrid Infrastructure
*   **Azure Sizing Metrics:** Calculated using the official **Microsoft Azure Pricing Calculator** to baseline VM nodes and managed storage block arrays.
    *   *Official Reference Endpoint:* https://microsoft.com
*   **Azure Arc Pay-As-You-Go Rates:** Sourced from the official **Azure Arc Core Pricing Models** to track hybrid infrastructure compliance controls.
    *   *Official Reference Endpoint:* https://microsoft.com
    *   *Windows Server Core Pay-As-You-Go Baseline:* `$33.58 / core / month`
    *   *SQL Server Standard Engine Add-on:* `$73.00 / month`
    *   *SQL Server Enterprise Engine Add-on:* `$273.75 / month`

### 2. Commercial On-Premises & Volume Licensing (Perpetual Models)
For standard standalone environments, hybrid virtualization hosts, or non-cloud private data centers, licensing structures follow the official **Microsoft SQL Server 2022 Commercial Pricing Matrix**.
    *   *Official Reference Endpoint:* https://microsoft.com
    *   *SQL Server 2022 Enterprise Edition:* **`$15,123` per 2-Core Pack** *(Volume Licensing / Hosting upfront capital cost)*
    *   *SQL Server 2022 Standard Edition (Per Core):* **`$3,945` per 2-Core Pack** *(Volume Licensing / Hosting upfront capital cost)*
    *   *SQL Server 2022 Standard Edition (Per Server):* **`$989` base server run license**
    *   *Standard Client Access Licenses (CALs):* **`$230` per user/device endpoint matrix**

### 3. Annual Subscription Models (Overcoming Upfront CAPEX)
To avoid massive upfront perpetual software licensing bills, organizations frequently adopt Microsoft's structured **Annual Volume Subscriptions** to shift database engineering into an operational expense (OPEX) model.
    *   *Official Reference Endpoint:* https://microsoft.com
    *   *SQL Server Enterprise Subscription:* **`$5,434 / year` per 2-Core Pack** *(Includes Software Assurance failover benefits)*
    *   *SQL Server Standard Subscription:* **`$1,418 / year` per 2-Core Pack** *(Includes Software Assurance failover benefits)*
    *   *Strategic HA/DR Constraint:* While an annual subscription includes Software Assurance paths that grant licensing rights for secondary passive engine replicas, **it does not cover or eliminate the underlying Windows OS license fees** required to keep those host environments active. 

### 4. Windows Server OS Core Operating Licensing Fees
To audit baseline OS costs when running clusters natively on Windows physical environments or traditional VMs, core fees follow the official **Microsoft Windows Server 2025 Commercial Sizing Matrix**.
    *   *Official Reference Endpoint:* https://www.microsoft.com/en-us/windows-server/pricing
    *   *Windows Server 2025 Datacenter Edition:* **Suggested MSRP: `$6,771`** *(Per 16-Core Baseline / Unlimited Virtualization Guest OSE)*
    *   *Windows Server 2025 Standard Edition:* **Suggested MSRP: `$1,176`** *(Per 16-Core Baseline / Minimalist/Physical Environments)*
    *   *Windows Server Client Access Licenses (CALs):* Mandatory per user/device endpoint matrix accessing the server layers.

> **💡 Architectural Impact:** Because SQL Server core engine subscription or perpetual rates remain completely identical whether you choose Windows or open-source Linux, the **entire financial optimization strategy focuses on completely eliminating the Windows Server Operating System licensing layer ($671.60/month per cluster layer saved)** and its corresponding hardware background memory tax.

---
