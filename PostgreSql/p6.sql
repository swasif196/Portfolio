create table if not exists fee
    (F_Vno char(5), V_Fee numeric (10,2));
create or replace function p6() 
		returns table (V_Name char(20), V_Vfee numeric(10,2), V_Balance numeric (10,2)) as $$
        
    DECLARE 
        old vendor.Vbalance%type;
        new vendor.Vbalance%type;
        vnum vendor.Vno%type;
        cur cursor FOR
            SELECT Vno FROM vendor; 
    BEGIN
        DELETE FROM fee;
        OPEN cur; 
        LOOP 
            FETCH cur into vnum;
            EXIT WHEN not found; 
            SELECT Vbalance into old
            FROM vendor 
            WHERE Vno = vnum;
            
            UPDATE vendor 
            SET Vbalance = Vbalance - Vbalance * 0.04
            Where Vno = vnum;
            
            SELECT Vbalance into new
            FROM vendor 
            WHERE Vno = vnum;
            INSERT INTO fee VALUES(vnum ,old - new);
       END LOOP; 
       CLOSE cur; 
       return query Select Vname, V_Fee, Vbalance FROM vendor, fee where Vno = F_Vno;
    END;
    $$ language plpgsql;