
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

