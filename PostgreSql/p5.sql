create or replace function p5() 
		returns table (A_Vno char(5), A_Vname char(20), V_Balance numeric (10,2)) as $$
        
    DECLARE 
        ttl transactions.Amount%type;
        vnum vendor.Vno%type;
        cur cursor FOR
            SELECT Vno FROM vendor; 
    BEGIN
        OPEN cur; 
        LOOP 
            FETCH cur into vnum;
            EXIT WHEN not found; 
            SELECT COALESCE(SUM(transactions.amount),0) into ttl 
            FROM transactions 
            WHERE transactions.Vno = vnum;
            UPDATE vendor 
            SET Vbalance = Vbalance + ttl
            Where Vno = vnum;
       END LOOP; 
       CLOSE cur; 
       return query Select vendor.Vno, Vname, Vbalance FROM vendor;
    END;
    $$ language plpgsql;