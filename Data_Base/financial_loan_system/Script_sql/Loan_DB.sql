--use database loan_bd;

CREATE TABLE client (

    client_ID integer PRIMARY KEY GENERATED ALWAYS AS IDENTITY ,
    name varchar(40),
    phone varchar(15),
    password varchar(30),
    email varchar(50),
    address varchar(30)

                    );


CREATE TABLE co_debt(

    co_debt_ID integer PRIMARY KEY GENERATED ALWAYS AS IDENTITY ,
    name varchar(40),
    phone varchar(15),
    password varchar(30),
    email varchar(50),
    address varchar(30)
);    

CREATE TABLE loan (

    id_loan integer PRIMARY KEY GENERATED ALWAYS AS IDENTITY ,
    loan float,
    interest float,
    date_creation TIMESTAMP,
    client_ID int references client(client_ID),
    co_debt_ID int references co_debt(co_debt_ID),
    frequency varchar(20),
    delinquent_debt float check ( amount>=0) DEFAULT 0


);





CREATE TABLE  pay(
    pay_ID integer PRIMARY KEY GENERATED ALWAYS AS IDENTITY ,
    pay_date TIMESTAMP,
    amount float check( amount>0),--constraint have to be >0
    id_loan int references loan(id_loan)



);




