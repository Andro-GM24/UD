
## Requirements

The information is naturally organized into different categories (clients, loans, payments) that are closely linked to each other. It should allow for the storage of every transaction made, affecting the corresponding data in each table.
Payments should be recorded according to the agreed installments, based on the agreed interest rates, and all loan details. If the person defaults on payments, they should be penalized with interest and sanctioned based on the level of delinquency.
Each loan must have a co-debtor, who, in case the original client fails to pay, will be responsible for the full debt or the installments. If the client makes all the payments, a debt clearance certificate should be generated. For tax purposes,
a system for generating tax debt certificates should be created.

### user stories
- a client can have various loans

- a client can have various pays of loans

- the loans have a interest that could increase if there isn´t payments in a period

- the loans that have a santioned are based on the level of delinquency

- the co-debtor are obligatory so it have to be a table?(if have to be mandatory is not necesary to create a new table)

- there are a report of the debt

- a client have a diferent period to pay

## diseño por formas

### primera forma normal


| name_client | phone_client | password | address | email | id_loan | co-debtor | pay | loan ($) | interest (%) | date_pay | amount_of_pay ($) | increase_interest_in_percentage |
|:----------|:----------|:----------|:----------|:----------|:----------|:----------|:----------|:----------|:----------|:----------|:----------|:----------|
| Alice Johnson | (555) 123-4567 | ********* | 123 Main St | alice@mail.com | 1001-A | Robert Smith | Monthly | $5,000 | 8.5 | 2025-11-01 | $450.00 | 0.0 |
| Ben Clark | (555) 987-6543 | ********* | 45 Oak Ave | ben@mail.com | 1002-B | N/A | Bi-Weekly | $12,500 | 6.2 | 2025-10-25 | $290.50 | 0.5 |
| Ben Clark | (555) 987-6543 | ********* | 45 Oak Ave | ben@mail.com | 1004-D | **Sarah Miller** | Monthly | $7,000 | 7.5 | 2025-11-10 | $650.00 | 0.0 |
| Cathy Brown | (555) 555-0000 | ********* | 789 Pine Ln | cathy@mail.com | 1003-C | David Lee | Quarterly | $30,000 | 4.9 | 2026-01-15 | $1,500.00 | 0.0 |

in this table repeat the primary key(name_client) because the client have various loans,so is necesary to separate 
this tables

| name_client | phone_client | password | address | email | co-debtor | pay | interest (%) | date_pay | amount_of_pay ($) | increase_interest_in_percentage |
|:----------|:----------|:----------|:----------|:----------|:----------|:----------|:----------|:----------|:----------|:----------|
| Alice Johnson | (555) 123-4567 | ********* | 123 Main St | alice@mail.com | Robert Smith | Monthly | 8.5 | 2025-11-01 | $450.00 | 0.0 |
| Ben Clark | (555) 987-6543 | ********* | 45 Oak Ave | ben@mail.com | N/A | Bi-Weekly | 6.2 | 2025-10-25 | $290.50 | 0.5 |
| Ben Clark | (555) 987-6543 | ********* | 45 Oak Ave | ben@mail.com | Sarah Miller | Monthly | 7.5 | 2025-11-10 | $650.00 | 0.0 |
| Cathy Brown | (555) 555-0000 | ********* | 789 Pine Ln | cathy@mail.com | David Lee | Quarterly | 4.9 | 2026-01-15 | $1,500.00 | 0.0 |

table loans

| name_client | id_loan | loan ($) |
|:----------|:----------|:----------|
| Alice Johnson | 1001-A | $5,000 |
| Ben Clark | 1002-B | $12,500 |
| Ben Clark | 1004-D | $7,000 |
| Cathy Brown | 1003-C | $30,000 |

the foreign key are in the table with the part many to respect the rule of don´t repeat primary key, that in this case are id loan

- the table have a primary key (name_client)
- there aren´t repeated primary keys
- there aren´t cells with multiple data.


### second normal form

in this have into account the functional dependencies

so in the big table we have that pay, interest (%), date_pay, amount_of_pay ($), increase_interest_in_percentage and the co-debtor are not depend of the primary key client, so it´s neccesary to separate it.

| id_client | name_client | phone_client | password | address | email |
|:----------|:----------|:----------|:----------|:----------|:----------|
| 1 | Alice Johnson | (555) 123-4567 | ********* | 123 Main St | alice@mail.com |
| 2 | Ben Clark | (555) 987-6543 | ********* | 45 Oak Ave | ben@mail.com |
| 3 | Cathy Brown | (555) 555-0000 | ********* | 789 Pine Ln | cathy@mail.com |


client table


| id_co_debtor | name_co_debtor | id_loan |
|:----------|:----------|:----------|
| 1 | Robert Smith | 1001-A |
| 2 | Sarah Miller | 1004-D |
| 3 | David Lee | 1003-C |

co_debtor table


| id_loan | pay | loan ($) | interest (%) | date_pay | amount_of_pay ($) | increase_interest_in_percentage | id_client |
|:----------|:----------|:----------|:----------|:----------|:----------|:----------|:----------|
| 1001-A | Monthly | $5,000 | 8.5 | 2025-11-01 | $450.00 | 0.0 | 1 |
| 1002-B | Bi-Weekly | $12,500 | 6.2 | 2025-10-25 | $290.50 | 0.5 | 2 |
| 1004-D | Monthly | $7,000 | 7.5 | 2025-11-10 | $650.00 | 0.0 | 2 |
| 1003-C | Quarterly | $30,000 | 4.9 | 2026-01-15 | $1,500.00 | 0.0 | 3 |

loan table

### thrid  normal form

the atributes not principal have to depend of the primary key not for other atribute, in this case is the loan and the pay, is necesary to separate

| id_loan | loan ($) | interest (%) | increase_interest_in_percentage | id_client (FK) |
|:----------|:----------|:----------|:----------|:----------|
| 1001-A | $5,000 | 8.5 | 0.0 | 1 |
| 1002-B | $12,500 | 6.2 | 0.5 | 2 |
| 1004-D | $7,000 | 7.5 | 0.0 | 2 |
| 1003-C | $30,000 | 4.9 | 0.0 | 3 |

| id_loan (FK) | pay | date_pay | amount_of_pay ($) |
|:----------|:----------|:----------|:----------|
| 1001-A | Monthly | 2025-11-01 | $450.00 |
| 1002-B | Bi-Weekly | 2025-10-25 | $290.50 |
| 1004-D | Monthly | 2025-11-10 | $650.00 |
| 1003-C | Quarterly | 2026-01-15 | $1,500.00 |

now it´s posible to make the model entity relational

now it´s necesary to make the raltions

a client can have many loans

a loans only have one client

a loans have only one co-debt

a loan can have many pays

a pay can only have one client



a codebt can have many loans 

there is something that are important and is the amount of money that are in delinquent debt
,it will add to the table of loan:

delinquent_debt float check ( amount>0)

with this value is posible to calculate the percentage increase of the loan.







