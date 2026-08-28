## 🗺️ 1. Architecture & Topography Blueprint

In standard Windows-based deployments, an Availability Group relies heavily on active listeners and standard network load balancers (NLBs) to manage traffic transitions. 

This standalone architectural blueprint maps a highly efficient, lightweight **Clusterless Always On Configuration (`CLUSTER_TYPE = NONE`)** running over decoupled enterprise nodes. This deployment eliminates external listener infrastructure overheads to scale synchronous workloads at minimal operating costs.

![Clusterless SQL Server AlwaysOn Architecture On RHEL 9](./architecture_clusterless_rhel.png)

### ⚙️ Core Topology Specifications:
* **Primary Replica (`SQL DB1`):** Hosted on **Red Hat Enterprise Linux 9.8** | Provisioned with 2 vCPUs and 8 GB RAM. Dedicated IP: `10.1.0.5`.
* **Secondary Replica (`SQL DB2`):** Hosted on **Red Hat Enterprise Linux 9.8** | Provisioned with 2 vCPUs and 8 GB RAM. Dedicated IP: `10.1.0.6`.
* **Data Commitment Layer:** Enforced **Synchronous Data Commit** protocol to guarantee zero data loss (RPO = 0) during transactional routing loops.
* **Traffic Routing Strategy:** Optimized for decoupled application layers where connection string routing endpoints are manually or programmatically updated directly to the active database server node during failover windows.

