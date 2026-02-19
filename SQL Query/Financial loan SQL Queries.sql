create database Bank_loan;
select * from bank_loan_data;

-- while importing issue_date column have text data type i have update to date using this queery
set sql_safe_updates = 0;
UPDATE bank_loan_data
SET issue_date = STR_TO_DATE(issue_date, '%d-%m-%Y');

-- Key Performance Indicators (KPIs) Requirements:

-- problem statment 1.	Total Loan Applications
select count(id) as Total_Application from bank_loan_data;

-- MTD Loan Applications
select count(id) as Total_Application_MTD from bank_loan_data
 where month(issue_date)= 12;
 
-- PMTD Loan Applications (previous month)
select count(id) as Total_Application_PMTD from  bank_loan_data 
where month(issue_date)= 11;

-- Total Funded Amount: Understanding the total amount of funds disbursed as loans is crucial. 
select sum(loan_amount) as Total_funded from bank_loan_data;

-- MTD for Total Funded amount
select sum(loan_amount) as Total_funded_MTD from bank_loan_data 
where month(issue_date) =12;

-- PMTD for Total Funded amount
select sum(loan_amount) as Total_funded_PMTD from bank_loan_data 
where month(issue_date) =11;

-- Total Amount Received: Tracking the total amount received from borrowers is essential for assessing the bank's cash flow and loan repayment. 
select sum(total_payment) as Total_Amt_Received from bank_loan_data;

-- MTD for Total Amount Received
select sum(total_payment) as Total_Amt_Received_MTD from bank_loan_data 
where month(issue_date) = 12;

-- PMTD for Total Amount Received
select sum(total_payment) as Total_Amt_Received_PMTD from bank_loan_data 
where month(issue_date) = 11;

-- Average Interest Rate
select round(avg(int_rate)*100,2) as AVG_RATE from bank_loan_data;

-- MTD Average Interest Rate
select round( avg(int_rate)*100,2) as AVG_RATE_MTD from bank_loan_data 
where month(issue_date)=12;

-- PMTD Average Interest Rate
select round( avg(int_rate)*100,2) as AVG_RATE_MTD from bank_loan_data 
where month(issue_date)=11;


-- Problem Statment: Average Debt-to-Income Ratio (DTI): 
Select round(avg(dti)*100,2) as AVG_DTI from bank_loan_data;

-- MTD AVG DTI
Select round(avg(dti)*100,2) as AVG_DTI from bank_loan_data 
where month(issue_date)= 12;

-- PMT AVG DTI
Select round(avg(dti)*100,2) as AVG_DTI from bank_loan_data 
where month(issue_date)= 11;

-- GOOD LOAN ISSUED 
-- problem 1. GOOD LOAN Percentage
-- by using subquery;
select (select count(id) from bank_loan_data where loan_status = "Fully Paid" or loan_status = "Current")/ count(id) *100 
as Good_Loan_Percent
from bank_loan_data;

-- by using case:
select round(count( case when loan_status = "Fully Paid" or loan_status= "Current" then id end)/count(id) * 100,2) as Good_Loan_Percent
 from bank_loan_data;

-- Good Loan Applications
select count(id) as Good_loan_Application from bank_loan_data 
where loan_status = "Fully Paid" or loan_status = "Current";

-- Good Loan Funded Amount
select sum(loan_amount) as Good_loan_funded from bank_loan_data 
where loan_status = "Fully Paid" or loan_status = "Current";

-- God Loan Amount Received 
select sum(total_payment) as Good_loan_AMT_Received from bank_loan_data 
where loan_status = "Fully Paid" or loan_status = "Current";

-- BAD LOAN ISSUED
-- Bad Loan Percentage 
select round(count( case when loan_status = "charged Off" then id end)/ count(id) * 100,2) as Bad_Loan_Percent 
from bank_loan_data;

-- Bad Loan Application
Select Count(id) as Total_Bad_application from bank_loan_data 
where loan_status = "charged off";

-- Bad loan Funded Amount
select sum(loan_amount) as Bad_loan_funded from bank_loan_data 
where loan_status = "Charged off";

-- Bad loan Amount Received 
select sum(total_payment) as Bad_loan_AMT_Received from bank_loan_data 
where loan_status = "charged off";

-- LOAN STATUS
-- to showcase Status
select loan_status, count(id) as NUM_Application , sum(total_payment)as Loan_paid, sum(loan_amount) as Loan_Issued,
round(avg(int_rate)*100,2) as AVG_Rate, round(AVG(dti)*100,2) as AVG_DTI
 from bank_loan_data group by loan_status;
 
 -- To show MTD Funded Amount and Received Amount
 Select loan_status, sum(total_payment) as Received_AMT_MTD , 
 sum(loan_amount) as Loan_Issued_MTD from bank_loan_data
 where month(issue_date)=12
 group by loan_status ;
 
 
 -- 	BANK LOAN REPORT | OVERVIEW
 -- 1. Monthly Trends by Issue Date :
 select month(issue_date) as Month_num, date_format(issue_date, "%M") as Month_name,
 count(id) as Total_Applicaiton, sum(total_payment) as Received_amount,
 sum(loan_amount) as Loan_Issued
 from bank_loan_data
 group by month(issue_date), Month_name
 order by month(issue_date);
 
-- 2. Regional Analysis by State 
select address_state, count(id) as Total_Applicaiton, 
sum(total_payment) as Received_amount, sum(loan_amount) as Loan_Issued 
 from bank_loan_data 
 group by address_state 
 order by address_state;
 
--  3. Loan Term Analysis 
select term as Term, count(id) as Total_Applicaiton,
 sum(total_payment) as Received_amount, sum(loan_amount) as Loan_Issued 
from bank_loan_data
group by term
order by term;

select * from bank_loan_data;
-- 4. Employee Length Analysis 
select Emp_length as Employee_Length, count(id) as Total_Applicaiton, sum(total_payment) as Received_amount, sum(loan_amount) as Loan_Issued 
from bank_loan_data
group by Emp_length
order by Emp_length;

-- 5. Loan Purpose Breakdown 
select purpose as Loan_Purpose, 
count(id) as Total_Applicaiton, sum(total_payment) as Received_amount, 
sum(loan_amount) as Loan_Issued 
from bank_loan_data
group by purpose
order by purpose;

-- 6. Home Ownership Analysis 
select home_ownership as Own_home, 
count(id) as Total_Applicaiton, sum(total_payment) as Received_amount, 
sum(loan_amount) as Loan_Issued 
from bank_loan_data
group by home_ownership
order by home_ownership;

select * from bank_loan_data;
-- “Comprehensive details of loan disbursement by adding more filters such as By Grade of Employee"
select purpose as Loan_Purpose, Grade, 
count(id) as Total_Applicaiton, sum(total_payment) as Received_amount,
 sum(loan_amount) as Loan_Issued 
from bank_loan_data 
where grade="A"
group by purpose
order by purpose;


