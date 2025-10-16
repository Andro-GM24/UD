--search all the client, show the name and the email, have to be organized by alphabethic

SELECT name, email FROM client ORDER BY name;

-- get the loans with high increase tax 
-- ID del préstamo, monto,tasa,el nombre del cliente asociado.
--have to be greater or equal to 0.12

SELECT

id_loan, loan, interest, client.name 

from loan 

INNER JOIN

client ON client.client_ID= loan.client_ID

WHERE interest >= 0.12;



