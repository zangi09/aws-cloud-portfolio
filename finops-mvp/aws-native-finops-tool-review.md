# AWS Native FinOps Tool Review

## Purpose

This review documents AWS-native tools used to support cloud cost visibility, anomaly detection, budgeting, rightsizing, tagging governance, and optimization workflows.

## Tools Reviewed

| AWS Tool | FinOps Purpose | What I Reviewed | Finding | Recommendation |
|---|---|---|---|---|
| Cost Explorer | Cost visibility and trend analysis | Spend by service, daily/monthly trends, service count, and usage patterns | Account showed $30.43 total cost across 19 services from January 2026 through June 2026 | Continue reviewing cost by service, usage type, and date range to identify recurring spend and non-recurring charges |
| AWS Budgets | Budget control and alerting | Monthly budget named CloudPortfolio-Monthly-Budget | Budget amount is $10.00; current spend is $22.15, which is 221.49% of budget; forecasted spend is $27.18, which is 271.80% of budget | Keep budget alerts active and document current vs. forecasted overage as an example of proactive cost monitoring |
| Cost Anomaly Detection | Detect abnormal spend patterns | Cost anomaly detection setup page | No cost monitor or anomaly detection workflow is currently configured | Create a service-level or account-level anomaly monitor to detect unusual spend spikes and alert stakeholders |
| Cost Allocation Tags | Cost ownership, showback, chargeback, and governance | Available resource tag keys | Tags exist but are inactive, including CostCenter, Environment, ManagedBy, Name, Owner, and Project | Activate key cost allocation tags and standardize tagging policy for owner, environment, project, and cost center reporting |
| Compute Optimizer | Rightsizing and optimization recommendations | Compute Optimizer landing page | Compute Optimizer is not currently enabled, so no recommendations are available yet | Consider opting in to Compute Optimizer to generate recommendations for supported compute resources after enough utilization data is available |
| Trusted Advisor | Cost optimization checks and best-practice recommendations | Trusted Advisor cost optimization page | Cost optimization checks are limited by the current support plan; several checks are visible but not fully available without support upgrade | Document support-plan limitation and use available checks as a secondary validation source |
| Data Exports / CUR | Detailed billing data layer for SQL and dashboarding | Data export/CUR concept | No production CUR pipeline has been configured in this lab yet | Future enhancement: export billing data to S3 and query it with Athena or load it into QuickSight for deeper cost analytics |

## Key Findings

### 1. Budget alerting is active and meaningful

A monthly AWS budget has been configured for the cloud portfolio account. The budget amount is $10.00, while current spend is $22.15 and forecasted spend is $27.18. This means both current and forecasted spend exceed the budget threshold.

This demonstrates how AWS Budgets can support proactive FinOps monitoring by identifying spend overages before they become unmanaged.

### 2. Cost anomaly detection is not configured yet

The account does not currently have a cost anomaly monitor configured. This is a gap because anomaly detection can help identify unusual spend patterns automatically instead of relying only on manual Cost Explorer reviews.

Recommended next step: create a cost monitor and alert subscription for service-level or account-level spend anomalies.

### 3. Cost allocation tags exist but are inactive

The account has several useful tag keys, including CostCenter, Environment, ManagedBy, Name, Owner, and Project. However, they are currently inactive for cost allocation.

This is an important FinOps governance finding because inactive tags cannot be used effectively for showback, chargeback, owner-based reporting, or persona-based dashboards.

Recommended next step: activate the most important cost allocation tags and standardize tagging expectations.

### 4. Compute Optimizer is not enabled

Compute Optimizer is available but not currently enabled. Without opting in, the account will not generate rightsizing recommendations.

Recommended next step: enable Compute Optimizer when ready, allow utilization data to accumulate, then review recommendations for supported resources.

### 5. Trusted Advisor recommendations are limited by support plan

Trusted Advisor cost optimization checks are partially visible, but several recommendations are limited by the current AWS support plan.

Recommended next step: document the limitation and use Trusted Advisor as a supplemental optimization source where available.

## Key Takeaway

AWS-native FinOps tooling is useful even when there are limited recommendations. A FinOps review should document not only current findings, but also tooling readiness, alert coverage, tagging governance gaps, support-plan limitations, and next steps for improving cost visibility and operational maturity.