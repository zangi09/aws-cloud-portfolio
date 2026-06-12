# Cloud Portfolio Incident Response Runbook

## Purpose

This runbook documents the procedures used to investigate, respond to, and recover from operational issues affecting the AWS Cloud Portfolio and FinOps Analytics Platform.

## Monitored Components

* AWS Lambda visitor-counter function
* Amazon CloudFront distribution
* Amazon S3 static website origin
* Route 53 DNS records
* AWS Certificate Manager certificate
* DynamoDB visitor-counter table
* GitHub Actions deployment pipeline
* Website availability at `https://syedkcloudops.com`
* Monthly AWS cloud spend

---

## Alert: Lambda Function Errors

### Symptoms

* Visitor counter displays `Error` or remains on `Loading`
* Lambda Errors alarm enters the `ALARM` state
* SNS email notification is received
* Lambda Function URL returns an error

### Investigation

1. Open the visitor-counter Lambda function in the AWS Console.
2. Review the latest CloudWatch log stream.
3. Identify code, permissions, DynamoDB, or CORS errors.
4. Open the Lambda Function URL directly and review its response.
5. Confirm the DynamoDB table and `visits` item are available.
6. Review recent Lambda code or configuration changes.

### Recovery

1. Correct the Lambda code, permissions, or configuration.
2. Deploy the corrected function.
3. Test the Function URL directly.
4. Refresh the portfolio website.
5. Confirm the visitor counter displays correctly.
6. Verify the CloudWatch alarm returns to `OK`.

---

## Alert: Website Availability Failure

### Symptoms

* CloudWatch Synthetics canary reports a failed run
* Website availability alarm enters the `ALARM` state
* `syedkcloudops.com` is unavailable or returns an error

### Investigation

1. Review the failed Synthetics canary execution.
2. Inspect the failure message, request details, and screenshot.
3. Confirm the Route 53 alias records point to CloudFront.
4. Verify the CloudFront distribution is enabled and deployed.
5. Test the CloudFront distribution domain directly.
6. Verify the S3 origin contains the website files.
7. Check ACM certificate status and custom-domain configuration.

### Recovery

1. Correct the affected DNS, CloudFront, ACM, or S3 configuration.
2. Re-run the Synthetics canary.
3. Confirm the website loads through the custom domain.
4. Verify the alarm returns to `OK`.

---

## Alert: CloudFront 5XX Error Rate

### Symptoms

* CloudFront 5XX alarm enters the `ALARM` state
* Users receive server-side errors
* CloudFront cannot retrieve content from the origin

### Investigation

1. Review CloudFront request and error-rate metrics.
2. Test the CloudFront URL and S3 website endpoint.
3. Confirm the S3 origin is accessible.
4. Review recent deployments in GitHub Actions.
5. Confirm that `index.html`, `styles.css`, and website assets exist.
6. Review CloudFront origin and cache-behavior configuration.

### Recovery

1. Correct the origin or website-file issue.
2. Revert the latest breaking Git commit when necessary.
3. Push the rollback to the `main` branch.
4. Allow GitHub Actions to redeploy the website.
5. Confirm CloudFront invalidation completes.
6. Verify the site and alarm status.

---

## Alert: CI/CD Deployment Failure

### Symptoms

* GitHub Actions workflow displays a failed deployment
* Website changes do not appear
* S3 synchronization or CloudFront invalidation fails

### Investigation

1. Open the failed GitHub Actions workflow.
2. Identify the failed step.
3. Review AWS credential, IAM permission, YAML, S3, and CloudFront errors.
4. Confirm required GitHub repository secrets exist.
5. Verify the CloudFront distribution ID and S3 bucket name.

### Recovery

1. Correct the workflow, permissions, or repository secrets.
2. Commit and push the correction.
3. Confirm all GitHub Actions steps finish successfully.
4. Verify the new website version is live.

---

## Alert: AWS Cost Threshold

### Symptoms

* AWS Budget notification is received
* Actual or forecasted costs exceed the configured threshold

### Investigation

1. Open AWS Cost Explorer.
2. Review spend by service.
3. Identify unexpected resource usage or cost increases.
4. Confirm unused test resources have been removed.
5. Review CloudWatch Logs, Synthetics frequency, S3 usage, and CloudFront traffic.

### Recovery

1. Stop or remove unnecessary resources.
2. Reduce monitoring frequency where appropriate.
3. Apply cost-allocation tags.
4. Run `terraform plan` before removing Terraform-managed resources.
5. Document the cause and corrective action.

---

## Rollback Procedure

1. Identify the last known-good Git commit:

```bash
git log --oneline
```

2. Revert the breaking commit:

```bash
git revert <commit-id>
```

3. Push the rollback:

```bash
git push origin main
```

4. Monitor the GitHub Actions deployment.
5. Confirm the S3 synchronization succeeds.
6. Confirm CloudFront invalidation completes.
7. Test the live website and visitor counter.

---

## Incident Documentation

For each incident, record:

* Date and time
* Alert received
* Service affected
* User or business impact
* Root cause
* Troubleshooting actions
* Corrective action
* Recovery time
* Preventive follow-up

---

## Lessons Learned

The project reinforced the importance of:

* Proactive monitoring and alerting
* Clear rollback procedures
* Infrastructure as Code
* Secure credential management
* DNS and certificate validation
* Testing frontend-to-backend integrations
* Documenting technical troubleshooting and recovery steps
