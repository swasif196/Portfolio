create or replace function p7() 
		returns table (C_Name char(20), C_Balance numeric (10,2)) as $$
        
    BEGIN
 
        UPDATE customer 
        SET Cbalance = (Cbalance - Crlimit) * 1.10
        Where Cbalance > Crlimit;
                    
        return query Select Cname, Cbalance FROM customer;
    END;
    $$ language plpgsql;