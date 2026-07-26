# AWS Pricing Model Study

## Purpose

This study documents AWS pricing drivers and optimization levers for services observed in the Cost Explorer review. The goal is to understand what causes cost, what usage metrics matter, and what FinOps actions can reduce waste or improve cost visibility.

---

## 1. CloudWatch

### What drives cost
- Log ingestion
- Log storage
- Custom metrics
- Dashboards
- Alarms
- API requests

### Usage metrics to review
- GB of logs ingested
- Log retention period
- Number of custom metrics
- Number of alarms
- Dashboard usage

### Optimization levers
- Set log retention policies
- Remove unused log groups
- Reduce unnecessary debug-level logging
- Review high-volume log streams
- Review custom metrics and alarms

### Validation needed
- Confirm compliance or audit retention requirements before deleting or reducing log retention.

### Interview talking point
CloudWatch costs can grow quietly through log ingestion and retention. A good FinOps review should check log groups, retention settings, custom metrics, dashboards, and alarms to make sure observability is useful but not excessive.

---

## 2. Route 53 / Registrar

### What drives cost
- Domain registration and renewal
- Hosted zones
- DNS queries
- Health checks

### Usage metrics to review
- Number of hosted zones
- DNS query volume
- Registered domains
- Health checks

### Optimization levers
- Remove unused hosted zones
- Validate domain registration/renewal charges
- Review health checks
- Confirm DNS records are still needed

### Validation needed
- Confirm domain ownership and production DNS dependencies before removing hosted zones or records.

### Interview talking point
Registrar charges are often expected one-time or annual charges. For FinOps reporting, I would classify them separately from recurring cloud usage so they do not distort month-over-month service trends.

---

## 3. S3

### What drives cost
- Storage volume
- Storage class
- Requests
- Data retrieval
- Data transfer
- Versioning
- Lifecycle configuration

### Usage metrics to review
- GB stored
- Storage class distribution
- Number of GET/PUT requests
- Old object versions
- Incomplete multipart uploads
- Data transfer out

### Optimization levers
- Use lifecycle policies
- Move infrequently accessed data to lower-cost storage classes
- Delete incomplete multipart uploads
- Review versioning
- Review data transfer patterns

### Validation needed
- Confirm access patterns and retrieval requirements before changing storage class.

### Interview talking point
S3 rightsizing is not about instance size. It is about matching storage class, retention, versioning, and access pattern to the business need.

---

## 4. Lambda

### What drives cost
- Number of invocations
- Duration
- Memory allocation
- Architecture
- Provisioned concurrency
- Data transfer and related service calls

### Usage metrics to review
- Invocations
- Average duration
- Memory utilization
- Error rate
- Concurrency
- Cold starts

### Optimization levers
- Tune memory allocation
- Reduce unnecessary invocations
- Optimize function duration
- Review provisioned concurrency
- Review architecture choice

### Validation needed
- Confirm performance and reliability requirements before reducing memory or changing concurrency.

### Delivery Summary
Lambda cost optimization requires reviewing memory, duration, invocation volume, and concurrency. Sometimes increasing memory can reduce duration, so the cheapest configuration is not always the smallest memory setting.

---

## 5. DynamoDB

### What drives cost
- Read/write capacity mode
- On-demand or provisioned pricing
- Storage
- Backups
- Global tables
- Streams
- Data transfer

### Usage metrics to review
- Read request units
- Write request units
- Table size
- Backup usage
- Throttling
- Access pattern

### Optimization levers
- Review on-demand vs provisioned mode
- Enable auto scaling if provisioned
- Remove unused tables
- Review backup retention
- Check for hot partitions or inefficient access patterns

### Validation needed
- Confirm application traffic patterns before changing capacity mode.

### Interview talking point
DynamoDB optimization depends on access patterns. A FinOps review should compare on-demand versus provisioned capacity, review unused tables, backup retention, and whether read/write patterns match the pricing model.

---

## 6. EC2

### What drives cost
- Instance type
- Instance family
- Running hours
- Region
- EBS volumes
- Data transfer
- Savings Plans or Reserved Instances

### Usage metrics to review
- CPU utilization
- Memory utilization if available
- Network usage
- Running hours
- Idle time
- EBS attachment and utilization
- Instance family and generation

### Optimization levers
- Rightsize instance type
- Stop or schedule non-production instances
- Use Savings Plans for steady workloads
- Review older generation instances
- Review EBS volumes and snapshots

### Validation needed
- Confirm memory, performance, uptime, and application requirements before resizing.

### Interview talking point
EC2 rightsizing should look beyond CPU. I would review CPU, memory, network, running hours, storage, workload schedule, and commitment options before recommending a change.