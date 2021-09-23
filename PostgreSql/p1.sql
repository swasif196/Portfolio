create or replace function p1(name char (20)) 
		returns table (Date date, T_Amount numeric(10,2), V_Name char(20)) as $$
        begin
            return query
            SELECT  T_date, Amount, Vname  FROM customer, transactions, vendor  
                WHERE customer.Account = transactions.Account  AND transactions.Vno = vendor.Vno AND customer.Cname = name;
        end; 
        $$ language plpgsql;
