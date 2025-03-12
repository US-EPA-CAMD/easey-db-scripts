DO $$
DECLARE vYear smallint;
BEGIN 
  SELECT EXTRACT('year' FROM CURRENT_DATE) into vYear;  
  for counter in 2003..vYear loop
       call camdecmps.create_partitions(counter, 'true');
   end loop;
END $$
