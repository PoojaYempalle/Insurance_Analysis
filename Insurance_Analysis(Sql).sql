create schema supply_chain;
Create table supply_chain.brokerage(client_name varchar(225),policy_number varchar(100),policy_status varchar(50),
                                    Policy_start_date DATE,policy_end_date Date, product_group varchar(100),
                                    account_exe_id INT,exe_name varchar(100), branch_name varchar(100),
                                    solution_group varchar(200), income_class varchar(50),amount decimal(15,2),
                                    income_due_date date,revenue_transaction_type varchar(50), renewal_status varchar(50),
                                    lapse_reason varchar(225),last_updated_date date);
create table supply_chain.fees(client_name varchar(225),branch_name varchar(100), solution_group varchar(200),account_exe_id INT,
                                account_executive varchar(100),income_class varchar(50), amount decimal(15,2),income_due_date date,
                                revenue_transaction_type varchar(50));
create table supply_chain.individual_budgets(branch varchar(100), account_exe_id INT,employee_name varchar(100), new_role2 varchar(100),
											new_budget Bigint, cross_sell_budget Bigint, renewal_budget Bigint);
create table supply_chain. invoices(invoice_number varchar(50), invoice_date date, revenue_transaction_type varchar(50),branch_name varchar(100),
                                    solution_group varchar(200),  account_exe_id INT,account_executive varchar(100), income_class varchar(50),
                                    client_name varchar(225),policy_number varchar(100), amount decimal(15,2),income_due_date date);
create table supply_chain.meetings( account_exe_id INT,  account_executive varchar(100),branch_name varchar(100), global_attendees varchar(225),
									meeting_date date);
create table supply_chain.opportunities(opportunity_name varchar(200), opportunity_id varchar(50), account_exe_id INT,account_executive varchar(100),
                                        premium_amount decimal(15,2), revenue_amount decimal(15,2), Closing_date date, stage varchar(100), branch varchar(100),
                                        specialty varchar(200), product_group varchar(100), product_sub_group varchar(100), risk_details varchar(200));
create table supply_chain.policy_data(customer_id varchar(50),name varchar(225), gender varchar(20),age int,occupation varchar(100), marital_status varchar(20),
									  address varchar(300));

use supply_chain;


# Q1 No of Invoice by Account Exec;

select * from invoices;
select account_executive,count(invoice_number) as No_of_invoices from invoices group by account_executive;

#Q2-Yearly Meeting Count;

select * from meetings;
select year(meeting_date) as Year,count(*) as meeting_count from meetings group by year(meeting_date) order by year;

#Q3a.Cross Sell--Target, Achieve, new;

select * from individual_budgets;
select account_exe_id,sum(cross_sell_budget)as Total_cross_sell_budget from individual_budgets 
group by account_exe_id;

#Q3b.New-Target,Achive,new;


select account_exe_id,sum(new_budget)as Total_new_budget from individual_budgets 
group by account_exe_id;

#Q3c.Renewal-Target, Achieve , new;

select account_exe_id,sum(renewal_budget)as Total_renewal_budget from individual_budgets 
group by account_exe_id;

select * from opportunities;
#Q4 Stage Funnel by Revenue;
select stage, sum(revenue_amount) as Total_revenue from opportunities group by stage order by total_revenue desc;

select* from meetings;

#Q5 No of meeting By Account Exe;
select account_executive, count(*) as Meeting_count from meetings group by account_executive;


select* from opportunities;
#Q6 Top Open Opportunity;
select opportunity_name,account_exe_id,revenue_amount from opportunities where stage in('Qualify Opportunity', 'Negotiate','Propose Solution')
 order by revenue_amount desc limit 10;