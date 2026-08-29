-- Changed FUEL_GROUP_CD from 'COAL' to 'OTHER' for:  
        -- CRF (Coal Refuse)  
        -- PTC (Petroleum Coke)  

UPDATE camdecmpsmd.fuel_type_code
SET fuel_group_cd = 'OTHER'
WHERE fuel_type_cd IN ('CRF', 'PTC');