create or replace function p3(ac char (5), name char(20), prov char(10), lim numeric(10)) 
		returns table (A_Account char(5), A_name char(20), A_Province char (10), A_Balance numeric(10,2), A_Crlimit numeric(10)) as $$
        
    BEGIN
        INSERT INTO customer VALUES (ac, name, prov, 0.00, lim);
        return query Select * FROM customer;
    END;
    $$ language plpgsql;