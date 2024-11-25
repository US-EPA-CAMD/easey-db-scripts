INSERT INTO camdaux.client_config
(client_id, client_name, client_secret, client_passcode, encryption_key, support_email)
VALUES('', 'security-scan-client', '', '', '', null);

/*
 * IMPORTANT: To ensure this functionality operates correctly with security scan requests,
 * the following Github secrets **must** be set in the devops Github repo to be used by the
 * "API Full ZAP Scan with Authentication" workflow:
 *
 * - SCAN_CLIENT_ID
 * - SCAN_CLIENT_SECRET
 *
 * The values of SCAN_CLIENT_ID and SCAN_CLIENT_SECRET **must** match the entries inserted in the
 * 'camdaux.client_config' table within this script, specifically for the columns 'client_id'
 * and 'client_secret'.
 *
 * Entries in the camdaux.client_config table for security scans (for 'security-scan-client') must be made
 * in the environment where the security scan is to be conducted. Currently, security scans
 * are performed in the PERF environment.
 *
 * Failure to properly configure these Github Secrets will prevent security-scan-client
 * from authenticating correctly, leading to potential functionality and authorization issues.
 */
