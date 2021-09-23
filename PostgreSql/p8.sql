create or replace function p8(vn char(5), acc char(5), amt numeric(10,2)) 
		returns table(A_Tno char(5), A_Vno char(5), A_Account char(5), A_Date date, A_Amount numeric(10,2), A_Cname char(20), A_Cbalance numeric(10,2), A_Vname char(20), A_Vbalance numeric(10,2)) as $$
        
    DECLARE 
        chk int;
        chk2 int;
        new char(1000);
        x char(5);
    BEGIN
        Select count(*) into chk from vendor where Vno = vn;
        Select count(*) into chk2 from customer where Account = acc;
        if chk > 0 and chk2 > 0 then
            x = 'T'||nextval('tid');
            INSERT INTO transactions VALUES (x, vn, acc, CURRENT_DATE, amt);
            UPDATE vendor set Vbalance = Vbalance + amt where Vno = vn;
            UPDATE customer set Cbalance = Cbalance + amt where Account = acc;
            raise notice 'Successfully Added';
        else
            raise notice 'Invalid Vno or Account';
        END if;
        
        return query Select Tno, transactions.Vno, transactions.Account, T_date, Amount, Cname, Cbalance, Vname, Vbalance From vendor, customer, transactions Where transactions.Tno = x and customer.Account = transactions.Account and vendor.Vno = transactions.Vno;
                    
    END;
    $$ language plpgsql;