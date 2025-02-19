DO $$
DECLARE vYear smallint;
BEGIN 
  SELECT EXTRACT('year' FROM CURRENT_DATE) into vYear;  
  for counter in 2024..vYear loop
       call camdecmps.create-partitions(counter, 'true');
   end loop;
END $$