    -- 1.1 SELECT
    -- Task – Select all records from the Employee table.
        SELECT * FROM employee;
    -- Task – Select all records from the Employee table where last name is King.
        SELECT * FROM employee WHERE lastname = 'King';
    -- Task – Select all records from the Employee table where first name is Andrew and REPORTSTO is NULL.
        SELECT * FROM employee WHERE firstname = 'Andrew' AND reportsto IS null;
    -- 
    -- 1.2 ORDER BY
    -- Task – Select all albums in Album table and sort result set in descending order by title.
        SELECT * FROM album ORDER BY title DESC;
    -- Task – Select first name from Customer and sort result set in ascending order by city
        SELECT firstname FROM customer ORDER BY city;
   
    -- 1.3 INSERT INTO
    -- Task – Insert two new records into Genre table
        INSERT INTO genre (genreid, name) VALUES
            (26,'Contemporary'),
            (27,'Soul');
    
    -- Task – Update name of artist in the Artist table “Creedence Clearwater Revival” to “CCR”
        UPDATE artist
            SET name = 'CCR'
            WHERE name = 'Creedence Clearwater Revival';
    
    -- 1.5 LIKE
    -- Task – Select all invoices with a billing address like “T%”
        SELECT * FROM invoice WHERE billingaddress LIKE 'T%';
    
    -- 1.6 BETWEEN
    -- Task – Select all invoices that have a total between 15 and 50
        SELECT * FROM invoice WHERE total >= 15 and total <= 50;
    -- Task – Select all employees hired between 1st of June 2003 and 1st of March 2004
        SELECT * FROM employee WHERE hiredate > '2003-06-01 0:00:00' AND hiredate < '2004-03-01 00:00:00';
    
    -- 1.7 DELETE
    -- Task – Delete a record in Customer table where the name is Robert Walter (There may be constraints that rely on this, find out how to resolve them).
        ALTER TABLE customer --Remove foreign key connecting customer and employee
            DROP CONSTRAINT fk_customersupportrepid;
			
        ALTER TABLE customer --Re-add foreign key connecting customer and employee that adds cascading deletion to delete the records in both tables
            ADD CONSTRAINT fk_customersupportrepid
            FOREIGN KEY (supportrepid)
            REFERENCES employee(employeeid)
            ON DELETE CASCADE;

        ALTER TABLE invoice --Remove foreign key connecting customer and employee
            DROP CONSTRAINT fk_invoicecustomerid;
			
        ALTER TABLE invoice --Re-add foreign key connecting customer and employee that adds cascading deletion to delete the records in both tables
            ADD CONSTRAINT fk_invoicecustomerid
            FOREIGN KEY (customerid)
            REFERENCES customer(customerid)
            ON DELETE CASCADE;

        ALTER TABLE invoiceline --Remove foreign key connecting customer and employee
            DROP CONSTRAINT fk_invoicelineinvoiceid;
			
        ALTER TABLE invoiceline --Re-add foreign key connecting customer and employee that adds cascading deletion to delete the records in both tables
            ADD CONSTRAINT fk_invoicelineinvoiceid
            FOREIGN KEY (invoiceid)
            REFERENCES invoice(invoiceid)
            ON DELETE CASCADE;
        
        DELETE FROM customer
            WHERE firstname = 'Robert' AND lastname = 'Walter';


    -- 2.1 System Defined Functions
    -- Task – Use a function that returns the current time.
        SELECT current_time;
    -- Task – Use a function that returns the length of the name of a mediatype from the mediatype table
        SELECT LENGTH(name) FROM mediatype;
    
    -- 2.2 System Defined Aggregate Functions
    -- Task – Use a function that returns the average total of all invoices
        SELECT AVG(total) FROM invoice;
    -- Task – Use a function that returns the most expensive track
        SELECT MAX(unitprice) FROM track;

    -- 3.0 JOINS
    -- In this section you will be working with combing various tables through the use of joins. You will work with outer, inner, right, left, cross, and self joins.

    -- 3.1 INNER
    -- Task – Create an inner join that joins customers and orders and specifies the name of the customer and the invoiceId.
        SELECT customer.firstname, customer.lastname, invoice.invoiceid FROM customer INNER JOIN invoice ON (customer.customerid = invoice.customerid);

    -- 3.2 OUTER
    -- Task – Create an outer join that joins the customer and invoice table, specifying the CustomerId, firstname, lastname, invoiceId, and total.
        SELECT customer.customerid, customer.firstname, customer.lastname, invoice.invoiceid, invoice.total FROM customer FULL JOIN invoice ON (customer.customerid = invoice.customerid); 
    
    -- 3.3 RIGHT
    -- Task – Create a right join that joins album and artist specifying artist name and title.
        SELECT artist.name, album.title FROM album RIGHT JOIN artist USING (artistid)
    
    -- 3.4 CROSS
    -- Task – Create a cross join that joins album and artist and sorts by artist name in ascending order.
        SELECT * FROM album CROSS JOIN artist
            ORDER BY artist.name;
			
    -- 3.5 SELF
    -- Task – Perform a self-join on the employee table, joining on the reportsto column.
        SELECT * FROM employee E1, employee E2
	        WHERE e1.reportsto = e2.employeeid;
			
		


