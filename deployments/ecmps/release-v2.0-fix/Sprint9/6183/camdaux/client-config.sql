INSERT INTO camdaux.client_config
(client_id, client_name, client_secret, client_passcode, encryption_key, support_email)
VALUES('', 'camd-services', '', '', '', null);


/*
 * IMPORTANT: To ensure this functionality operates correctly in the easey-camd-services
 * application, the following environment variables **must** be set in the
 * easey-camd-services environment:
 *
 * - EASEY_CAMD_SERVICES_CLIENT_ID
 * - EASEY_CAMD_SERVICES_CLIENT_SECRET
 *
 * The values of EASEY_CAMD_SERVICES_CLIENT_ID and EASEY_CAMD_SERVICES_CLIENT_SECRET
 * must match the entries inserted in the 'camdaux.client_config' table within this
 * script, specifically for the columns 'client_id' and 'client_secret'.
 *
 * Failure to properly configure these environment variables will prevent easey-camd-services
 * from authenticating correctly, leading to potential functionality and authorization issues.
 */