-- Query to monitor the status of the initial table sync.  This is run in the subscriber database
SELECT PC.RELNAME,
	CASE
		WHEN PSR.SRSUBSTATE = 'i' THEN 'initialize'
		WHEN PSR.SRSUBSTATE = 'r' THEN 'ready'
		WHEN PSR.SRSUBSTATE = 'd' THEN 'data is being copied'
		WHEN PSR.SRSUBSTATE = 'f' THEN 'finished table copy'
		WHEN PSR.SRSUBSTATE = 's' THEN 'synchronized'
		ELSE 'unknown'
	END AS SRSUBSTATE
FROM PG_SUBSCRIPTION_REL PSR
LEFT JOIN PG_CLASS PC ON PSR.SRRELID = PC.OID; 