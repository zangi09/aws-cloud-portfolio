# AWS Rightsizing Recommendation Matrix

## Purpose

This matrix documents how AWS services can be reviewed for cost optimization, rightsizing, and FinOps governance. The goal is to show that rightsizing is broader than EC2 and includes compute, storage, database, serverless, observability, networking, and governance-related services.

---

## Rightsizing and Optimization Matrix

| Service Area | Cost Driver | Usage Signal to Review | Optimization Lever | Risk / Validation Needed | FinOps Recommendation |
|---|---|---|---|---|---|
| EC2 | Instance type, instance size, running hours, EBS volumes, data transfer | CPU, memory, network, running hours, idle time | Resize instance, schedule non-production workloads, use Savings Plans, review EBS volumes | Validate memory, uptime, application performance, and workload schedule | Review instance utilization before resizing; prioritize idle or consistently underutilized instances |
| EBS | Volume size, volume type, provisioned IOPS, snapshots | Unattached volumes, low I/O, old snapshots, over-provisioned gp3/io2 | Delete unattached volumes, rightsize volume type, clean old snapshots | Confirm backup, recovery, and application dependency requirements | Review unattached and oversized storage before reducing capacity |
| S3 | Storage volume, storage class, requests, lifecycle, versioning, data transfer | Object age, access frequency, version count, storage class distribution | Lifecycle policies, Intelligent-Tiering, delete incomplete multipart uploads, review versioning | Confirm retrieval speed, compliance retention, and access requirements | Match storage class to access pattern and lifecycle older data |
| RDS | Instance class, storage, Multi-AZ, backups, read replicas | CPU, connections, IOPS, storage growth, idle time | Resize instance, review Multi-AZ need, tune storage, use Reserved Instances | Validate database performance, failover needs, and business criticality | Rightsize only after reviewing performance baseline and uptime requirements |
| Lambda | Invocations, duration, memory allocation, provisioned concurrency | Invocation count, average duration, memory usage, errors, concurrency | Tune memory, reduce unnecessary invocations, optimize code duration, review provisioned concurrency | Validate performance, latency, and reliability requirements | Optimize memory/duration balance instead of only reducing memory |
| DynamoDB | Capacity mode, read/write units, storage, backups, streams | RCU/WCU usage, throttling, table size, access pattern | Review on-demand vs provisioned, enable auto scaling, remove unused tables | Validate traffic pattern and application access behavior | Match capacity mode to workload predictability |
| CloudWatch | Log ingestion, log storage, custom metrics, alarms, dashboards | GB ingested, retention days, unused log groups, custom metric count | Set retention policies, remove unused log groups, reduce noisy logs | Confirm audit, compliance, and troubleshooting requirements | Control observability cost without reducing critical monitoring |
| NAT Gateway | Hourly charge and data processing charge | Data processed, cross-AZ traffic, private subnet routing | Use VPC endpoints, reduce unnecessary NAT traffic, review architecture | Validate routing, security, and application connectivity | Review high NAT processing charges for endpoint opportunities |
| Data Transfer | Cross-AZ, cross-region, internet egress, CDN usage | Transfer volume, source/destination, region path | Use CloudFront, reduce cross-AZ traffic, colocate services, review architecture | Validate application architecture and latency requirements | Treat data transfer as an architecture cost, not just a billing line item |
| Route 53 | Hosted zones, DNS queries, health checks, domain registration | Number of zones, query volume, domain renewals, health checks | Remove unused hosted zones, validate health checks, classify registrar charges | Confirm DNS dependencies before deletion | Separate recurring DNS usage from annual registrar costs |
| KMS | Key usage, API requests, key count | Encrypt/decrypt requests, active keys, service integrations | Review unused keys, understand high-volume encryption patterns | Validate security and compliance before key changes | Monitor KMS request volume when encryption is used heavily |
| CloudFront | Data transfer out, requests, invalidations, origin traffic | Request volume, cache hit ratio, invalidation frequency | Improve cache behavior, reduce unnecessary invalidations, tune TTLs | Validate content freshness and user experience | Optimize cache hit ratio to reduce origin and transfer cost |
| AWS Backup / Snapshots | Backup storage, retention, recovery points | Backup age, retention policy, duplicate backups | Tune backup retention, remove expired recovery points | Confirm recovery objectives and compliance needs | Align backup retention with RPO/RTO and compliance policy |

---

## Prioritization Logic

Optimization opportunities should be prioritized based on:

1. Estimated monthly savings
2. Business risk
3. Ease of implementation
4. Owner accountability
5. Validation required
6. Impact on reliability, security, and performance

---

## Example Recommendation Format

Each recommendation should include:

- Resource or service reviewed
- Current cost driver
- Usage signal observed
- Recommendation
- Expected impact
- Risk or validation requirement
- Owner or assignment group
- Follow-up action

---

## Sample FinOps Recommendation

### CloudWatch Log Retention Review

**Finding:** CloudWatch charges appear as recurring daily spend in Cost Explorer.  
**Cost Driver:** Log ingestion and retention.  
**Usage Signal:** Recurring CloudWatch service cost in daily Cost Explorer view.  
**Recommendation:** Review log groups, set appropriate retention policies, and remove unused log groups.  
**Expected Impact:** Reduce recurring observability cost while maintaining required monitoring.  
**Validation Needed:** Confirm compliance and troubleshooting retention requirements.  
**Owner:** Cloud Operations.  
**Workflow Action:** Create a ServiceNow task for log retention review.

---

## Key Takeaway

Rightsizing is broader than resizing EC2 instances. In a FinOps review, optimization should evaluate compute, storage, databases, serverless, observability, networking, backup, and data transfer costs. Each recommendation should include the cost driver, usage signal, optimization lever, validation needed, and business risk before any change is made.