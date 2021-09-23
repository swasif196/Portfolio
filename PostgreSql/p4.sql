create table if not exists disp2
    (C_Account char(5), C_name char(20), C_Amount numeric(10,2), C_Vendor char(20));

create or replace function p4()
		returns table (A_Account char(5), A_name char(20), A_Amount numeric(10,2), A_Vendor char(20)) as $$
        
    BEGIN
        DELETE FROM disp2;
        INSERT INTO disp2 select c.Account, Cname, Amount, Vname
        From customer as c
        left join transactions As t
        on c.account = t.account
        left join vendor as v
        on t.Vno = v.Vno
        order by T_date desc;
        update disp2
        set C_Vendor = 'no transaction'
        where C_Vendor is null;
        return query Select distinct on (C_Account) C_Account, C_name, C_Amount, C_Vendor FROM disp2;
    END;
    $$ language plpgsql;