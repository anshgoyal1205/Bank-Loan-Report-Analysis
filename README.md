# 🏦 Bank Loan Report Analysis
> A comprehensive SQL project analysing a real-world bank loan dataset of 39,595 records to monitor lending performance, assess portfolio health, and surface key financial KPIs using MySQL.

![MySQL](https://img.shields.io/badge/MySQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-Analysis-orange?style=for-the-badge)
![Finance](https://img.shields.io/badge/Domain-Banking%20%26%20Finance-blue?style=for-the-badge)
![Status](https://img.shields.io/badge/Status-Completed-brightgreen?style=for-the-badge)

---

## 📌 Project Overview

This project simulates the work a Data Analyst would do at a bank — building a comprehensive loan report to monitor lending activities, track portfolio health, and identify trends over time. The analysis is divided into three sections: **Summary KPIs**, **Overview by Dimensions**, and **Good vs Bad Loan classification**.

**Tool Used:** MySQL Workbench  
**Database:** `financial_db`  
**Table:** `financial_loan`  
**Dataset Size:** 39,595 loan records  
**Total Queries Written:** 25+  

---

## 🗃️ Database Schema

### `financial_loan` Table — 39,595 rows

| Column | Type | Description |
|--------|------|-------------|
| `id` | int | Unique loan identifier |
| `address_state` | varchar(2) | Borrower's state |
| `application_type` | varchar(500) | Individual or joint application |
| `emp_length` | varchar(500) | Employment length of borrower |
| `emp_title` | varchar(500) | Job title of borrower |
| `grade` | varchar(10) | Loan grade (A–G) |
| `sub_grade` | varchar(300) | Loan sub-grade |
| `home_ownership` | varchar(500) | Own / Rent / Mortgage |
| `issue_date` | date | Date loan was issued |
| `last_credit_pull_date` | date | Last credit check date |
| `last_payment_date` | date | Date of last payment |
| `loan_status` | varchar(500) | Fully Paid / Current / Charged Off |
| `next_payment_date` | date | Next payment due date |
| `member_id` | float | Member identifier |
| `purpose` | varchar(500) | Reason for loan |
| `term` | varchar(200) | 36 months / 60 months |
| `verification_status` | varchar(300) | Income verification status |
| `annual_income` | float | Borrower's annual income |
| `dti` | float | Debt-to-Income ratio |
| `installment` | float | Monthly installment amount |
| `int_rate` | float | Interest rate |
| `loan_amount` | float | Total loan amount approved |
| `total_acc` | float | Total credit accounts |
| `total_payment` | float | Total amount repaid by borrower |

---

## 🔍 Business Problems Solved

### 📊 Section A — Summary KPIs

#### 1. Loan Application Metrics
**Problem:** How many loans have been applied for — overall, this month (MTD), and last month (PMTD)?

- **Total Loan Applications** — `COUNT(id)`
- **MTD Applications** — filtered by `MONTH(issue_date) = MONTH(CURDATE())`
- **PMTD Applications** — filtered by previous month using `CURDATE() - INTERVAL 1 MONTH`
- *Insight: Tracks application volume trends — Month-over-Month growth rate monitoring*

#### 2. Funded Amount Metrics
**Problem:** How much money has the bank disbursed — total, MTD, and PMTD?

- **Total Funded Amount** — `SUM(loan_amount)`
- **MTD & PMTD Funded Amount** — same date filters applied
- *Insight: Monitors capital deployment — identifies if lending is accelerating or slowing*

#### 3. Amount Received Metrics
**Problem:** How much has been repaid by borrowers — total, MTD, and PMTD?

- **Total Amount Received** — `SUM(total_payment)`
- **MTD & PMTD Amount Received** — monthly breakdown
- *Insight: Measures cash inflow and repayment health — critical for liquidity analysis*

#### 4. Interest Rate Analysis
**Problem:** What is the average interest rate being charged — overall, MTD, and PMTD?

- `ROUND(AVG(int_rate), 5)` across all three time periods
- *Insight: Tracks cost of lending over time — higher rates may signal riskier borrowers*

#### 5. Debt-to-Income Ratio (DTI)
**Problem:** What is the average financial burden on borrowers?

- `ROUND(AVG(dti), 4)` — overall, MTD, PMTD
- *Insight: High DTI indicates borrower financial stress — key risk indicator for default prediction*

---

### ✅ Section B — Good Loan vs Bad Loan Analysis

**Classification Logic:**
- **Good Loan** = `loan_status IN ('Fully Paid', 'Current')`
- **Bad Loan** = `loan_status = 'Charged Off'`

#### Good Loan KPIs
| Metric | Query Used |
|--------|-----------|
| Good Loan Percentage | `CASE WHEN` + `SUM` / `COUNT(*)` × 100 |
| Good Loan Applications | `COUNT(*)` with status filter |
| Good Loan Funded Amount | `SUM(loan_amount)` with status filter |
| Good Loan Amount Received | `SUM(total_payment)` with status filter |

*Insight: Measures what percentage of the portfolio is performing — healthy portfolio benchmark*

#### Bad Loan KPIs
| Metric | Query Used |
|--------|-----------|
| Bad Loan Percentage | `CASE WHEN loan_status = 'Charged Off'` |
| Bad Loan Applications | `COUNT(*)` with Charged Off filter |
| Bad Loan Funded Amount | `SUM(loan_amount)` — capital at risk |
| Bad Loan Amount Received | `SUM(total_payment)` — partial recovery |

*Insight: Quantifies credit risk exposure — charged off loans represent direct financial loss*

#### Complete Loan Status Summary
- `GROUP BY loan_status` showing Applications, Funded, Received, Avg Interest, Avg DTI per status
- MTD version with date filter applied
- *Insight: Full portfolio health snapshot — compares performance across all loan statuses*

---

### 📈 Section C — Overview by Dimensions

#### a) Monthly Trends
```sql
DATE_FORMAT(issue_date, '%Y-%m') AS Month
GROUP BY Month ORDER BY Month
```
- *Insight: Reveals seasonality in loan applications and disbursements — peak lending periods*

#### b) Regional Analysis by State
```sql
GROUP BY address_state
```
- *Insight: Identifies high-activity states — helps allocate regional sales and risk teams*

#### c) Loan Term Analysis (36 vs 60 months)
```sql
GROUP BY term
```
- *Insight: Shows borrower preference for short vs long term — impacts repayment risk profile*

#### d) Employment Length Analysis
```sql
GROUP BY emp_length ORDER BY emp_length
```
- *Insight: Correlates employment stability with loan volume — longer employment = lower risk*

#### e) Loan Purpose Breakdown
```sql
GROUP BY purpose
```
- *Insight: Reveals why people borrow — debt consolidation, home improvement, education etc.*

#### f) Home Ownership Analysis
```sql
GROUP BY home_ownership
```
- *Insight: Own vs Rent vs Mortgage — homeowners typically show lower default rates*

---

## 🛠️ SQL Concepts Used

| Concept | Used In |
|---------|---------|
| `COUNT`, `SUM`, `AVG`, `ROUND` | All KPI queries |
| `MONTH()`, `CURDATE()` | MTD/PMTD calculations |
| `INTERVAL` date arithmetic | PMTD month filter |
| `CASE WHEN` | Good/Bad loan percentage |
| `DATE_FORMAT()` | Monthly trend grouping |
| `GROUP BY` + `ORDER BY` | All dimension analysis |
| Conditional aggregation | Good vs Bad loan classification |
| Multi-metric single query | Loan status summary |

---

## 💡 Key Business Insights

- 📋 **39,595 loan applications** analysed — large-scale real-world dataset
- ✅ **Good vs Bad loan split** — majority portfolio is performing (Fully Paid + Current)
- ⚠️ **Charged Off loans** represent direct capital loss — Bad Loan % is a critical risk metric
- 📅 **MTD vs PMTD comparison** enables Month-over-Month growth tracking without complex joins
- 🗺️ **State-wise analysis** reveals geographic concentration risk in lending
- 💼 **Employment length** correlates with loan application volume — long-tenured employees borrow more
- 🏠 **Home ownership** breakdown shows mortgage holders are the largest borrower segment
- 🎯 **Debt Consolidation** is consistently the top loan purpose across borrowers
- 📊 **36-month vs 60-month** term split shows borrower risk appetite
- 💰 **DTI tracking** over MTD/PMTD helps catch early signs of borrower stress

---

## 📂 Files in This Repository

| File | Description |
|------|-------------|
| `bank_loan_queries.sql` | All 25+ SQL queries with section comments |
| `financial_loan.csv` | Source dataset (39,595 records) |
| `README.md` | Project documentation |

---

## 🚀 How to Run

1. Open **MySQL Workbench**
2. Create database: `CREATE DATABASE financial_db;`
3. Import `financial_loan.csv` using Table Data Import Wizard
4. Open `bank_loan_queries.sql`
5. Run section by section — A (KPIs) → B (Good/Bad Loans) → C (Overview)

---

## 👤 Author

**Ansh Goyal**  
📧 anshgoyal1205@gmail.com  
🔗 [LinkedIn](https://www.linkedin.com/in/ansh-goyal-180b19212)  
🐙 [GitHub](https://github.com/anshgoyal1205)

