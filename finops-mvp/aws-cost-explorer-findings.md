# AWS Cost Explorer Findings

## Report Settings

Date range: January 1, 2026 - June 30, 2026  
Granularity reviewed: Monthly and Daily  
Group by dimension: Service  
Total cost: $30.43  
Average monthly cost: $5.07  
Average daily cost: $0.17  
Service count: 19  

## Key Findings

### Finding 1: Spend is low but service diversity is high
The account shows $30.43 in total cost across 19 AWS services during the selected six-month period. Even though total spend is low, the number of services shows that multiple AWS services are active and should be reviewed for cost ownership, tagging, and cleanup.

### Finding 2: Largest visible cost drivers are Registrar and CloudWatch
The monthly view shows the largest visible charges coming from Registrar and CloudWatch, with smaller charges from Route 53, Tax, S3, Key Management Service, DynamoDB, EC2-Instances, Lambda, and other services.

### Finding 3: Spend spike occurred in May 2026
The daily view shows a noticeable one-day cost spike in May 2026, primarily driven by Registrar-related cost. This should be documented as a non-recurring or expected cost if it relates to domain registration.

### Finding 4: CloudWatch costs continue daily into June
The daily view shows recurring CloudWatch-related charges in June. This should be reviewed for log retention, custom metrics, alarms, dashboards, and log ingestion volume.

### Finding 5: FinOps recommendation
For this account, the main FinOps focus is not large savings yet. The focus is cost visibility, cost ownership, tagging hygiene, budget alerts, service review, and preventing small recurring charges from becoming unmanaged spend.