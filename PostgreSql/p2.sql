
create table if not exists disp
    (C_Account char(5), C_name char(20), C_Province char (10));

create or replace function p2(name char (20)) 
		returns table (A_Account char(5), A_name char(20), A_Province char (10)) as $$
        
    DECLARE 
        vnum transactions.Vno%type;
        cur cursor FOR
            SELECT Vno FROM vendor WHERE Vname = name; 
    BEGIN
        DELETE FROM disp;
        OPEN cur; 
        LOOP 
            FETCH cur into vnum;
            raise notice 'Value: %', vnum;
            EXIT WHEN not found; 
            INSERT INTO disp SELECT customer.Account, Cname, Province FROM customer, transactions WHERE transactions.Vno = vnum AND customer.Account = transactions.Account;
       END LOOP; 
       CLOSE cur; 
       return query Select * FROM disp;
    END;
    $$ language plpgsql;