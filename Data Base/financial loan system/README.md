
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

the foreign kay are in the table with the part many to respect the rule of don´t repeat primary key, that in this case are id loan

- the table have a primary key (name_client)
- there aren´t repeated primary keys
- there aren´t cells with multiple data.


### segunda forma normal

en está fase se debe es tener en cuenta las dependencias funcionales,además de que podemos expandir 
