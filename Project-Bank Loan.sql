use financial_db;

select *
from financial_loan;

#----A. Bank Loan Report Summary

#----KPI's 

#--1 Number of Applications---------

#---a) TotalLoanApplications
select count(id) as Total_Applications
from financial_loan;

#---b) MTDLoanApplications(Month-To-Datei.e.CurrentMonth)
select count(id) as MTD_Applications
from financial_loan
where month(issue_date) = month(curdate());

#---c) PMTDLoanApplications(PreviousMonth)
select count(id) as PTMD_Applications
from financial_loan
where month(issue_date) = month(curdate() - interval 1 month);

#----2)  FundedAmount(TotalLoanAmountapproved)

#---a) TotalFundedAmount
select sum(loan_amount) as Total_Funded_Amount
from financial_loan;

#---b) MTDTotalFundedAmount
select sum(loan_amount) as MTD_Funded_Amount
from financial_loan
where month(issue_date) = month(curdate());

#---c) PMTDTotalFundedAmount
select sum(loan_amount) as PTMD_Funded_Amount
from financial_loan
where month(issue_date) = month(curdate() - interval 1 month);

#----3) AmountReceived(LoanAmountpaid)

#---a)TotalAmountReceived
select sum(total_payment) as Total_Amount_Received
from financial_loan;

#---b) MTDTotalAmountReceived
select sum(total_payment) as MTD_Amount_Received
from financial_loan
where month(issue_date) = month(curdate());

#---c) PMTDTotalAmountReceived
select sum(total_payment) as PTMD_Amount_Received
from financial_loan
where month(issue_date) = month(curdate() - interval 1 month);

#----4)  InterestRate

#---a)  AverageInterestRate
select round(avg(int_rate),5) as Avg_Interest_Rate
from financial_loan;

#---b) MTDAverageInterest
select round(avg(int_rate),5) as MTD_Avg_Interest
from financial_loan
where month(issue_date) = month(curdate());

#---c) PMTDAverageInterest
select round(avg(int_rate),5) as PTMD_Avg_Interest
from financial_loan
where month(issue_date) = month(curdate() - interval 1 month);

#----5) DTI(Debt to Income ratio)
#---a) AvgDTI
select round(avg(dti),4) as Avg_DTI
from financial_loan;

#---b) MTDAvgDTI
select round(avg(dti),4) as MTD_Avg_DTI
from financial_loan
where month(issue_date) = month(curdate());

#---c) PMTDAvgDTI
select round(avg(dti),4) as PMTD_Avg_DTI
from financial_loan
where month(issue_date) = month(curdate() - interval 1 month);

#----2 Good loan issued
#---a) GoodLoanPercentage
select round(100.0 * sum(case when loan_status in ('Fully Paid', 'Current') then 1 else 0 end) / count(*),2) as Good_Loan_Percentage
from financial_loan;

#---b) GoodLoanApplications
select count(*) as GoodLoan_Applications
from financial_loan
where loan_status in ('Fully Paid', 'Current');

#---c) GoodLoanFundedAmount
select sum(loan_amount) as GoodLoan_Funded_Amount
from financial_loan
where loan_status in ('Fully Paid', 'Current');

#---d) GoodLoanAmountReceived
select sum(total_payment) as GoodLoan_Amount_Received
from financial_loan
where loan_status in ('Fully Paid', 'Current');


#----3. Bad loan issued
#---a) BadLoanPercentage
select round(100.0* sum(case when loan_status in ('Charged Off') then 1 else 0 end)/ count(*),2) as BadLoan_Percentage
from financial_loan;

#---b) BadLoanApplications
select count(*) as BadLoan_Applications
from financial_loan
where loan_status in ('Charged Off');

#---c) BadLoanFunded Amount
select sum(loan_amount) as BadLoan_Funded_Amount
from financial_loan
where loan_status in ('Charged Off');

#---d) BadLoanAmountReceived
select sum(total_payment) as BadLoan_amount_Received
from financial_loan
where loan_status in ('Charged Off');

#----4. Loan Status
#---1) Complete Loan Status Summary
select loan_status,
count(*) as Total_Applications,
sum(loan_amount) as Total_Funded,
sum(total_payment) as Total_Received,
round(avg(int_rate),2) as Avg_Interest,
round(avg(dti),2) as Avg_DTI
from financial_loan
group by loan_status;

#---2) MTDLoanStatus Summary
select loan_status,
count(*) as Total_Applications,
sum(loan_amount) as Total_Funded,
sum(total_payment) as Total_Received,
round(avg(int_rate),2) as Avg_Interest,
round(avg(dti),2) as Avg_DTI
from financial_loan
where month(issue_date) = month(curdate())
group by loan_status;


#----B. Bank Loan Report Overview

#---a) MONTH
 select date_format(issue_date, '%Y-%m') as Month,
 count(*) as Total_Applications,
sum(loan_amount) as Total_Funded,
sum(total_payment) as Total_Received
from financial_loan
group by Month
order by Month;

#---b) STATE
select address_state,
count(*) as Total_Applications,
sum(loan_amount) as Total_Funded,
sum(total_payment) as Total_Received
from financial_loan
group by address_state;

#---c) TERM
select term,
count(*) as Total_Applications,
sum(loan_amount) as Total_Funded,
sum(total_payment) as Total_Received
from financial_loan
group by term;

#---d) EMPLOYEELENGTH
select emp_length,
count(*) as Total_Applications,
sum(loan_amount) as Total_Funded,
sum(total_payment) as Total_Received
from financial_loan
group by emp_length
order by emp_length;

#---e) PURPOSE
select purpose,
count(*) as Total_Applications,
sum(loan_amount) as Total_Funded,
sum(total_payment) as Total_Received
from financial_loan
group by purpose;

#---f) HOMEOWNERSHIP
select home_ownership,
count(*) as Total_Applications,
sum(loan_amount) as Total_Funded,
sum(total_payment) as Total_Received
from financial_loan
group by home_ownership; 

