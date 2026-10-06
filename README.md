# 💰 Azure FinOps Practice Lab

<p align="center">
  <img src="https://img.shields.io/badge/Azure-FinOps-0078D4?style=for-the-badge&logo=microsoftazure&logoColor=white" />
  <img src="https://img.shields.io/badge/Terraform-1.x-7B42BC?style=for-the-badge&logo=terraform&logoColor=white" />
  <img src="https://img.shields.io/badge/AzureRM-5.8.0-0078D4?style=for-the-badge&logo=terraform&logoColor=white" />
  <img src="https://img.shields.io/badge/Infracost-Cost%20Estimation-success?style=for-the-badge" />
</p>

<p align="center">
  <b>🚀 Production-style Azure FinOps Lab built with Terraform</b>
  <br/>
  <sub>Govern • Monitor • Optimize • Automate • Destroy 🧹</sub>
</p>

---

## 🎯 Overview

This project is a hands-on **Azure FinOps Practice Lab** designed to demonstrate how cloud infrastructure, governance, cost management, monitoring and optimization can be implemented using **Terraform**.

The lab focuses on building a small but production-style Azure environment with:

- 🏷️ Centralized resource tagging
- 🛡️ Azure Policy governance
- 💻 Windows & Linux workloads
- ⚡ Azure Spot VM
- ♻️ Windows Azure Hybrid Benefit
- 💰 Budget & cost alerts
- 📧 Action Group notifications
- 🔍 Cost anomaly detection
- 📤 Daily cost exports
- 📊 Cost analysis
- 💡 Azure Advisor cost optimization
- 🧹 Infrastructure cleanup

---

## 🏗️ Architecture

```text
                         ☁️ Azure Subscription
                                  │
                                  ▼
                       ┌────────────────────┐
                       │   FinOps Dev RG    │
                       │   🏷️ Common Tags   │
                       └─────────┬──────────┘
                                 │
                ┌────────────────┼────────────────┐
                │                │                │
                ▼                ▼                ▼
        🌐 Virtual Network   🪟 Windows VM    🐧 Spot VM
                │                │                │
                │             AHB Enabled       Spot
                │
                ▼
          ┌─────────────┐
          │   Subnets   │
          │ App + Data  │
          └─────────────┘


              ──────── 💰 FinOps Layer ────────

                    ┌──────────────┐
                    │    Budget    │
                    │    $50/mo    │
                    └──────┬───────┘
                           │
                  ┌────────┼────────┐
                  │        │        │
                  ▼        ▼        ▼
                50%      80%      100%
               Actual   Actual   Forecast
                  │        │        │
                  └────────┼────────┘
                           ▼
                    📧 Action Group
                           │
                           ▼
                         Email


                  🔍 Cost Anomaly Alert
                           │
                           ▼
                         Email


                  📤 Daily Cost Export
                           │
                           ▼
                    🗄️ Storage Account
                           │
                           ▼
                          CSV
```

---

## 🧪 Lab Objectives

| Area | Objective |
|---|---|
| 🏷️ Tagging | Centralized common tags using Terraform locals |
| 🛡️ Governance | Inherit `Environment` tag |
| 🛡️ Governance | Require `CostCenter` tag |
| 💻 Compute | Windows `Standard_D2s_v5` |
| ⚡ Compute | Linux `Standard_D2s_v5` Spot VM |
| ♻️ Licensing | Windows Azure Hybrid Benefit |
| 💰 Budget | Monthly `$50` budget |
| 🚨 Alerts | 50% / 80% Actual |
| 🔮 Forecast | 100% Forecast alert |
| 📧 Notifications | Azure Monitor Action Group |
| 🔍 Anomaly | Cost Anomaly Alert |
| 📤 Export | Daily Actual Cost → Storage |
| 📊 Analysis | Group by Tag / Resource |
| 💡 Optimization | Azure Advisor → Cost |
| 🧹 Cleanup | Terraform Destroy |

---

## 📁 Project Structure

```text
Shoebill/
│
├── environments/
│   └── dev/
│       ├── main.tf
│       ├── variables.tf
│       ├── outputs.tf
│       └── terraform.tfvars
│
├── modules/
│   ├── azurerm-resource-group/
│   ├── azurerm-virtual-network/
│   ├── azurerm-subnets/
│   ├── azurerm-virtual-machine/
│   ├── azurerm-policy/
│   ├── azurerm-budget/
│   ├── azurerm-action-group/
│   ├── azurerm-cost-export/
│   └── azurerm-anomaly-alert/
│
└── README.md
```

---

## 🏷️ Tagging Strategy

Common tags are managed centrally using Terraform locals:

```hcl
common_tags = {
  Environment = "Dev"
  Project     = "FinOps"
  CostCenter  = "CC-FINOPS-001"
  Owner       = "DevOps"
  ManagedBy   = "Terraform"
}
```

The Resource Group also contains the common tags along with the lab-specific `Purpose` tag.

### Governance Flow

```text
              Resource Group
                    │
                    │
             Environment = Dev
                    │
                    ▼
              Azure Policy
                    │
             ┌──────┴──────┐
             │             │
             ▼             ▼
          Inherit       Require
       Environment     CostCenter
```

This provides a simple foundation for **cost allocation, ownership and governance**.

---

## 🛡️ Azure Policy

Two policies are used:

### 1. Inherit Environment

Automatically inherits:

```text
Environment = Dev
```

from the Resource Group to supported resources.

### 2. Require CostCenter

Requires resources to have:

```text
CostCenter = CC-FINOPS-001
```

This helps maintain consistent cost attribution.

---

## 💻 Compute

### Windows VM

```text
Name       : finops-dev-win
OS         : Windows Server 2022
SKU        : Standard_D2s_v5
Priority   : Regular
AHB        : Enabled
Disk       : Premium_LRS
```

### Linux Spot VM

```text
Name       : finops-dev-spot
OS         : Ubuntu 22.04
SKU        : Standard_D2s_v5
Priority   : Spot
Eviction   : Deallocate
Disk       : Standard_LRS
```

### Why Spot?

Azure Spot VMs are useful for workloads that can tolerate interruption.

Typical examples:

- Batch workloads
- Dev/Test workloads
- CI/CD workers
- Interruptible processing

> ⚡ Spot is a cost-optimization technique, not a replacement for reliable production compute.

---

## ♻️ Windows Azure Hybrid Benefit

The Windows VM is configured with:

```hcl
license_type = "Windows_Server"
```

This enables the Azure Hybrid Benefit configuration.

> ⚠️ Actual savings depend on having eligible Windows Server licenses/entitlements.

---

## 💰 Budget & Alerts

A monthly budget is configured:

```text
Budget = $50 / month
```

Notifications include:

```text
🟡 50% Actual
🟠 80% Actual
🔴 100% Forecast
```

The budget is connected to an Azure Monitor Action Group for email notifications.

---

## 📧 Action Group

```text
Action Group
     │
     ▼
Email Receiver
     │
     ▼
FinOps Cost Notification
```

Common Alert Schema is enabled to keep alert payloads consistent.

---

## 🔍 Cost Anomaly Alert

The project also configures an Azure Cost Anomaly Alert.

```text
Unexpected Cost
       │
       ▼
Cost Anomaly Detection
       │
       ▼
📧 Email Notification
```

This provides an additional layer of protection beyond threshold-based budgets.

---

## 📤 Daily Cost Export

Actual cost data is exported daily to Azure Storage.

```text
Frequency       : Daily
Format          : CSV
Cost Type       : Actual Cost
Time Frame      : Month-to-Date
Destination     : Azure Storage
```

Flow:

```text
Azure Cost Management
          │
          ▼
    Daily Export
          │
          ▼
   Storage Account
          │
          ▼
      Blob Container
          │
          ▼
         CSV
```

---

## 🧮 Cost Estimation with Infracost

Before deployment, infrastructure cost can be estimated using **Infracost**.

Example estimate:

```text
Monthly Estimate ≈ $154.43
Hourly Estimate  ≈ $0.21
```

For a short practice session:

```text
~1 hour ≈ ~$0.21
```

> ⚠️ This is an estimate. Actual Azure charges can vary based on region, pricing, usage, Spot pricing, disk operations, taxes and other factors.

### Cost Optimization Strategy

For this practice lab:

```text
terraform apply
       ↓
Validate Azure resources
       ↓
Practice FinOps features
       ↓
Review configuration
       ↓
terraform destroy
```

💡 **Don't leave the lab running unnecessarily.**

---

## 🚀 Deployment

Navigate to the development environment:

```powershell
cd environments/dev
```

### 1. Initialize Terraform

```powershell
terraform init
```

### 2. Validate Configuration

```powershell
terraform validate
```

Expected:

```text
Success! The configuration is valid.
```

### 3. Format Terraform

```powershell
terraform fmt -recursive
```

### 4. Generate Plan

```powershell
terraform plan -out=finops-dev.tfplan
```

### 5. Estimate Cost

```powershell
infracost breakdown --path .
```

### 6. Apply

```powershell
terraform apply finops-dev.tfplan
```

---

## 🔎 Validation Checklist

After deployment, verify the following:

```text
☑ Resource Group created
☑ Common tags applied
☑ Environment tag inherited
☑ CostCenter policy assigned
☑ Windows VM created
☑ Windows AHB configured
☑ Linux Spot VM created
☑ Budget created
☑ 50% Actual alert
☑ 80% Actual alert
☑ 100% Forecast alert
☑ Action Group created
☑ Email notification configured
☑ Cost Anomaly Alert created
☑ Daily Cost Export configured
☑ Storage destination configured
```

---

## 📊 Cost Analysis

After sufficient cost data is available, open:

```text
Azure Portal
    ↓
Cost Management
    ↓
Cost Analysis
```

Review:

```text
📊 Group by → Tag
📊 Group by → Resource
```

Validate that resources can be associated with their respective cost dimensions.

> ⏳ Cost data may not be immediately available after resource creation.

---

## 💡 Azure Advisor

Open:

```text
Azure Portal
    ↓
Advisor
    ↓
Cost
```

Review available recommendations for:

- 💰 Cost reduction
- 💤 Idle resources
- 📉 Right-sizing
- ⚡ Optimization opportunities

> Advisor recommendations depend on available workload/usage data and may not appear immediately in a short-lived lab.

---

## 🧹 Cleanup

Once the lab is complete:

```powershell
terraform destroy
```

Confirm the destroy operation.

Then verify the Resource Group and lab resources are removed from Azure.

### 🧹 The Golden Rule

```text
        🧪 Build
          │
          ▼
        🔍 Test
          │
          ▼
        📊 Analyze
          │
          ▼
        💡 Learn
          │
          ▼
        🧹 Destroy
          │
          ▼
     💰 Save Money
```

---

## 🧰 Tools & Technologies

```text
☁️ Microsoft Azure
🏗️ Terraform
💰 Infracost
🛡️ Azure Policy
📊 Azure Cost Management
🚨 Azure Monitor
📧 Action Groups
🔍 Cost Anomaly Detection
🗄️ Azure Storage
💡 Azure Advisor
```

---

## 📌 FinOps Concepts Demonstrated

```text
                    FINOPS
                      │
       ┌──────────────┼──────────────┐
       │              │              │
       ▼              ▼              ▼
   GOVERNANCE      VISIBILITY    OPTIMIZATION
       │              │              │
       ▼              ▼              ▼
    Policies       Budgets        Spot VM
    Tagging        Exports        AHB
    CostCenter     Alerts         Advisor
                   Anomaly
```

The lab demonstrates the practical relationship between:

**Infrastructure → Governance → Cost Visibility → Accountability → Optimization**

---

## 🎓 Learning Outcome

By completing this lab, you should be able to understand:

- How Terraform can automate FinOps controls
- How Azure tags enable cost allocation
- How Azure Policy enforces governance
- How budgets and alerts provide financial guardrails
- How anomaly detection helps identify unexpected spending
- How Cost Management exports support reporting
- How Spot VMs can reduce compute costs
- How Azure Hybrid Benefit can optimize Windows licensing costs
- How Azure Advisor identifies optimization opportunities
- Why infrastructure cleanup is essential for cloud cost control

---

## ⚡ Quick Command Reference

```powershell
# Initialize
terraform init

# Format
terraform fmt -recursive

# Validate
terraform validate

# Plan
terraform plan -out=finops-dev.tfplan

# Estimate cost
infracost breakdown --path .

# Deploy
terraform apply finops-dev.tfplan

# Inspect state
terraform state list

# Destroy
terraform destroy
```

---

## 🚀 FinOps Lifecycle

```text
             🏗️ BUILD
                │
                ▼
          🏷️ GOVERN
                │
                ▼
          📊 MEASURE
                │
                ▼
           💰 ANALYZE
                │
                ▼
          ⚡ OPTIMIZE
                │
                ▼
          🔄 REPEAT
                │
                ▼
             🧹 CLEAN
```

---

<p align="center">

### 💰 FinOps is not just about reducing cost.

<i>It's about making cloud cost visible, accountable and continuously optimizable.</i>

<br/><br/>

🚀 <b>Build Smart • Measure Everything • Optimize Continuously</b> 🚀

<br/><br/>

⭐ <b>Azure + Terraform + FinOps</b> ⭐

</p>
