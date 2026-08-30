
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

# Microsoft SQL Server AlwaysOn Availability Groups on Ubuntu 22.04 LTS with Corosync/Pacemaker & QDevice Net Voter

This repository contains production-grade infrastructure blueprints, deployment configurations, and automated validation frameworks used to engineer an enterprise multi-subnet high-availability and disaster recovery layout for **Microsoft SQL Server 2022 Enterprise** deployed across Ubuntu 22.04 LTS environments.

## 🗺️ Architectural Topology Map
Constructed dynamically using draw.io vectors, this model layout represents the structural system isolation boundaries across subnets:

```text
       [ MAIN DATACENTER (DC SITE Subnet 1: 172.20.1.0/24) ]            [ DISASTER RECOVERY (DR SITE Subnet 2: 172.30.1.0/24) ]
       ┌──────────────────────────────────────────────────┐             ┌──────────────────────────────────────────────────┐
       │   ┌──────────────────┐    ┌──────────────────┐   │             │   ┌──────────────────┐                           │
       │   │   Node Name: DB1 │    │   Node Name: DB2 │   │             │   │ Node Name: DR-DB1│                           │
       │   │   172.20.1.194   │◄──►│   172.20.1.239   │   │             │   │   172.30.1.99    │                           │
       │   └────────┬─────────┘    └────────┬─────────┘   │   WAN LINK  │   └────────┬─────────┘                           │
       │            │                       │             │ (Port 5403) │            │                                     │
       │  Stream ───┴───────────┬───────────┴──────────── ┼─────────────┼────────────┴─────────────                        │
       │                        │                         │             │                          │                       │
       │              Virtual Floating VIP:               │             │                Virtual Floating VIP:             │
       │           Listenerdc (`172.20.1.30`)             │             │             Listenerdr (`172.30.1.10`)           │
       └────────────────────────┬─────────────────────────┘             └──────────────────────────┬───────────────────────┘
                                │                                                                  │
                                └─────────────────────────────────┬────────────────────────────────┘
                                                                  │
                                                      ┌───────────┴───────────┐
                                                      │  External Net Voter  │
                                                      │ QDevice: 10.10.10.178 │
                                                      │ (Subnet 3 LMS Server) │
                                                      └───────────────────────┘
```

---

## 🚀 Step-by-Step Configuration Pipeline

### Step 1: System Prerequisites
Execute files matching `1_Prerequisites.txt` parameters across all endpoints (`DB1`, `DB2`, `DR-DB1`). This synchronizes system locale tables, provisions network times protocols logs configurations via `chrony`, and writes local environment text lines references.

### Step 2: Networking & Security Firewall Maps
Run commands inside `2_Firewall_Setup.txt` on all cluster members nodes to map exact perimeter boundary conditions. This restricts incoming system queries explicitly to trusted multi-subnet structures while opening internal endpoints ports such as Port 5022 (HADR), Port 2224 (PCSD), and Port 5403 (QDevice Voter).

### Step 3: Logical Volume Storage Segmentation
Invoke the automated mounting block script `3_Disk_Preparations.sh`. This constructs high-speed LVM block groups partitioned with non-lazy allocation mappings across XFS layouts, separating `DATA`, `LOG`, and `TEMPDB` physical storage tracks.

### Step 4: Installation of High-Availability Cluster Tools
Deploy the high-availability resource fencing management layer across cluster target components nodes using parameters defined within `4_Install_Cluster_Tools.txt`. This creates a unified `hacluster` system administrative profile across network boundaries.

### Step 5: Corosync Setup & External Net Voter Witness Integration
Execute the centralized orchestration block script `5_QDevice_Corosync_Setup.sh` exclusively from the primary configuration panel server (`DB1`). This authenticates deployment environments coordinates, disables global STONITH requirements for standard virtualization configurations staging, and binds the external Net QDevice witness tracking loops using the Linear Minimum Split (LMS) vote algorithm over Port 5403.
* **🖼️ Visual Validation Checkpoint:** Ensure the cluster architecture displays proper token passing parameters.
  
  ![Active Baseline HA Cluster Layout Status Vector](assets/01_baseline_ha_cluster.png)

### Step 6: Installation of SQL Server 2022 Instance Engine
Deploy the base Microsoft product database engine binaries across instances environments components maps using instructions captured inside `6_Installation_SQL_Server.txt`.

### Step 7: Installation of SQLCMD Command Line Tools
Configure matching database interface client environments by processing scripts captured inside `7_Install_SQLCMD_Tools.txt` across cluster nodes interfaces layouts.

### Step 8: Activating the Internal HADR Engine Layer
Activate database high-availability container components features across system kernels layers processing commands written inside `8_Enable_AlwaysOn_AG.txt`.

### Step 9: Creating Master Cryptographic Keys on Primary
Execute the database container validation query script `9_Create_Cert_Endpoint_Primary.sql` inside the primary engine endpoint environment (`DB1`) to construct structural authentication tokens certificates keys.

### Step 10: Generating Handshake Tokens on Replicas
Run matching certificate configurations parameters script loops written inside `10_Create_Cert_Endpoint_Secondary.sql` on targets replicas (`DB2`, `DR-DB1`) to initialize mirroring connection ports fields.

### Step 11: Associating Availability Group Certificates Handshakes
Following secure network extraction migration patterns using `scp` utilities to copy validation key files across nodes, execute query sequences stored inside `11_Associate_Certs.sql` to bind system logins boundaries definitions.

### Step 12: Provisions the Availability Group Cluster Container
Initialize the base high-availability cluster container components layers variables by running queries embedded inside `12_Create_AG.sql` maps specifications sheets on the master terminal server context layout.

### Step 13: Enrolling Production Target Database Structures
Execute configuration queries files mapped inside `13_Add_DB_to_AG.sql` inside the active master primary database context server to link target application operational storage schemas to automatic tracking seeding loops pipelines.
* **🖼️ Visual Validation Checkpoint:** SSMS console status displays healthy status logs parameters.
  
  ![Healthy Converged AlwaysOn Availability Group Overview Panel](assets/02_sql_ag_healthy.png)

### Step 14: Mounting Multi-Subnet Virtual Listeners IPs
Map out system network connection interfaces addresses coordinates tokens by executing queries documented inside `14_Create_Listener.sql` files specifications structures.

### Step 15: Provisions Read-Only Routing Traffic Distribution Priority Chains
Deploy advanced reporting scale-out optimization properties lists maps across instances environments layout tables using queries packaged inside `15_Create_Routing_Lists.sql`.


## 🧪 Advanced Stress Test Cases Matrix & Core System Observations

To evaluate the capabilities of this high-availability clustering and database engine architecture, our team performed extensive stress testing. The failure scenarios, expected outcomes, and real-world system behaviors are detailed below:

### Test Case 1: Stop Pacemaker Service Layers on Node DB2
* **Failure Trigger Method:** Run command execution lines block: `sudo systemctl stop pacemaker` on node `DB2`.
* **Cluster Quorum Evaluation:** **HEALTHY QUORUM** (4 out of 5 cluster votes remain active via `DB1`, `DR-DB1`, `DB-Cluster`, and `QDevice` net voter).
* **SQL Engine Status:** `REQUIRED_SYNCHRONIZED_SECONDARIES_TO_COMMIT = 1` condition met.
* **Observations & Operational Verdict:** System function parameters remain stable. Node `DB1` holds the primary role loop, allowing the core financial application traffic routing to run without service dropouts.

### Test Case 2: Complete Data Center Loss Simulation (Simultaneous Crash of DB1 & DB2)
* **Failure Trigger Method:** Execute simultaneous hard kernel panics loops using server command tools protocols to take down both main data center elements (`DB1` and `DB2`).
* **Cluster Quorum Evaluation:** **HEALTHY QUORUM** (3 out of 5 cluster votes remain active via `DR-DB1`, `DB-Cluster`, and the external `QDevice Net Voter`).
* **SQL Engine Status:** `REPLICA QUORUM LOSS` Protection Event triggered. The storage engine registers that 2 nodes are missing from the configuration matrix and drops into a protected `Resolving` loop.
* **Observations & Operational Verdict:** **AUTOMATED CROSS-SUBNET FAILOVER IS BLOCKED.** Pacemaker attempts to promote the disaster recovery replica node (`DR-DB1`), but the SQL Server resource agent blocks the action to prevent split-brain scenarios and data corruption. The environment locks down, requiring an administrative manual override.
* **🖼️ Visual Evidence Log:** The cluster console logs failures and the SSMS manager tracks the environment as locked.
  
  ![Data Center Outage Failure Promotion Lock Error Diagnostics Log](assets/04_dc_outage_resolving_lock.png)

### Test Case 3: Complete Cluster Network Isolation Scenario (Total WAN Link Cutout)
* **Failure Trigger Method:** Sever network communication links connecting the primary data center from the QDevice server and the DR site simultaneously.
* **Cluster Quorum Evaluation:** **QUORUM LOSS** (1 out of 5 cluster votes active).
* **SQL Engine Status:** Cluster scheduling infrastructure frozen across segments.
* **Observations & Operational Verdict:** **TOTAL SYSTEM LOCKDOWN.** Node drops into self-healing recovery protection loops, rendering the target databases unreachable to prevent data drift across disconnected network fragments.

### Test Case 4: Graceful Maintenance Rolling Failover Migration
* **Failure Trigger Method:** Invoke script block execution rules embedded within `run_ha_test_suite.sh` or execute: `sudo pcs resource move sqlcluster-clone DB2 --master`.
* **Cluster Quorum Evaluation:** **HEALTHY QUORUM** (5 out of 5 votes active).
* **SQL Engine Status:** Zero tracking anomalies encountered. Roles swap smoothly between local nodes.
* **Observations & Operational Verdict:** **SUCCESSFUL LOCAL FAILOVER.** Node `DB2` assumes the Primary Master role cleanly. Floating virtual IP coordinates map onto the newly promoted host, allowing client processing systems to reconnect seamlessly.
* **🖼️ Visual Evidence Log:** The status terminal confirms that `DB2` is active and the virtual IP resource has migrated.
  
  ![Successful Local Maintenance Rolling Failover Status Monitor](assets/03_local_failover_db2.png)


## 🚨 Disaster Recovery Standard Operating Procedure (SOP) Manual Override

When a catastrophic event takes down the primary data center, follow this recovery runbook to force data availability on the remaining disaster recovery node (`DR-DB1`):

### Phase 1: Clear Fencing Constraints & Failure Counts
Log in to the surviving disaster recovery node (`DR-DB1`) via a secure shell connection console and clear the cluster scheduling restriction blocks:
```bash
# Clear lingering test constraints and execution locks
sudo pcs resource clear sqlcluster-clone --force
sudo pcs resource cleanup sqlcluster-clone
```

### Phase 2: Force Availability Group Promotion Against Storage Locks
Open an interactive SQL terminal session on `DR-DB1` and force the availability group out of its resolving loop despite the missing replicas:
```sql
-- Execute this recovery script directly inside the query terminal editor on DR-DB1
ALTER AVAILABILITY GROUP [ptag] FORCE_FAILOVER_ALLOW_DATA_LOSS;
GO
```
* **🖼️ Visual Evidence Log:** The query analyzer execution log confirms successful command execution.
  
  ![Disaster Recovery SOP Manual Forced Failover SQL Execution Window](assets/05_dr_manual_override_resume.png)

### Phase 3: Resume Database Replication Tasks & Re-align Log Tracks
Bring the database back online to resume standard application processing workloads:
```sql
ALTER DATABASE [paylab] SET HADR RESUME;
GO
```

### Phase 4: Validate Post-Disaster Baseline Stability Metrics
Verify that the cluster manager has successfully stabilized and that the multi-subnet listener routing constraints have updated:
```bash
# Print live operational metrics maps status layout records
sudo pcs status
```
* **🖼️ Visual Evidence Log:** The final system summary status reports that `DR-DB1` is serving application workloads as the new primary master.
  
  ![Final Production Disaster Recovery Re-stabilized Baseline Status Overview](assets/06_dr_primary_stable.png)
