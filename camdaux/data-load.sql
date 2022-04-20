-- CAMDAUX API
DELETE FROM camdaux.api;
INSERT INTO camdaux.api(api_id, name) OVERRIDING SYSTEM VALUE VALUES (1, 'auth-api');
INSERT INTO camdaux.api(api_id, name) OVERRIDING SYSTEM VALUE VALUES (2, 'facilities-api');
INSERT INTO camdaux.api(api_id, name) OVERRIDING SYSTEM VALUE VALUES (3, 'monitor-plan-api');
INSERT INTO camdaux.api(api_id, name) OVERRIDING SYSTEM VALUE VALUES (4, 'emissions-api');
INSERT INTO camdaux.api(api_id, name) OVERRIDING SYSTEM VALUE VALUES (5, 'account-api');
INSERT INTO camdaux.api(api_id, name) OVERRIDING SYSTEM VALUE VALUES (6, 'master-data-api');

-- CAMDAUX CORS
DELETE FROM camdaux.cors;
INSERT INTO camdaux.cors(cors_id, key, value) OVERRIDING SYSTEM VALUE VALUES (1, 'origin', 'https://campd-dev.app.cloud.gov');
INSERT INTO camdaux.cors(cors_id, key, value) OVERRIDING SYSTEM VALUE VALUES (2, 'origin', 'https://easey-dev.app.cloud.gov');
INSERT INTO camdaux.cors(cors_id, key, value) OVERRIDING SYSTEM VALUE VALUES (3, 'origin', 'https://api-easey-dev.app.cloud.gov');
INSERT INTO camdaux.cors(cors_id, key, value) OVERRIDING SYSTEM VALUE VALUES (4, 'origin', 'https://campd-tst.app.cloud.gov');
INSERT INTO camdaux.cors(cors_id, key, value) OVERRIDING SYSTEM VALUE VALUES (5, 'origin', 'https://easey-tst.app.cloud.gov');
INSERT INTO camdaux.cors(cors_id, key, value) OVERRIDING SYSTEM VALUE VALUES (6, 'origin', 'https://api-easey-tst.app.cloud.gov');
INSERT INTO camdaux.cors(cors_id, key, value) OVERRIDING SYSTEM VALUE VALUES (7, 'origin', 'https://campd-stg.app.cloud.gov');
INSERT INTO camdaux.cors(cors_id, key, value) OVERRIDING SYSTEM VALUE VALUES (8, 'origin', 'https://easey-stg.app.cloud.gov');
INSERT INTO camdaux.cors(cors_id, key, value) OVERRIDING SYSTEM VALUE VALUES (9, 'origin', 'https://api-easey-stg.app.cloud.gov');
INSERT INTO camdaux.cors(cors_id, key, value) OVERRIDING SYSTEM VALUE VALUES (10, 'origin', 'https://campd-beta.app.cloud.gov');
INSERT INTO camdaux.cors(cors_id, key, value) OVERRIDING SYSTEM VALUE VALUES (11, 'origin', 'https://easey-beta.app.cloud.gov');
INSERT INTO camdaux.cors(cors_id, key, value) OVERRIDING SYSTEM VALUE VALUES (12, 'origin', 'https://api-easey-beta.app.cloud.gov');
INSERT INTO camdaux.cors(cors_id, key, value) OVERRIDING SYSTEM VALUE VALUES (13, 'origin', 'https://api-easey.app.cloud.gov');
INSERT INTO camdaux.cors(cors_id, key, value) OVERRIDING SYSTEM VALUE VALUES (14, 'origin', 'https://campd.epa.gov');
INSERT INTO camdaux.cors(cors_id, key, value) OVERRIDING SYSTEM VALUE VALUES (15, 'origin', 'https://easey.epa.gov');
INSERT INTO camdaux.cors(cors_id, key, value) OVERRIDING SYSTEM VALUE VALUES (16, 'origin', 'https://api.epa.gov');
INSERT INTO camdaux.cors(cors_id, key, value) OVERRIDING SYSTEM VALUE VALUES (17, 'header', 'x-excludeable-columns');
INSERT INTO camdaux.cors(cors_id, key, value) OVERRIDING SYSTEM VALUE VALUES (18, 'header', 'x-field-mappings');
INSERT INTO camdaux.cors(cors_id, key, value) OVERRIDING SYSTEM VALUE VALUES (19, 'header', 'x-total-count');
INSERT INTO camdaux.cors(cors_id, key, value) OVERRIDING SYSTEM VALUE VALUES (20, 'header', 'content-type');
INSERT INTO camdaux.cors(cors_id, key, value) OVERRIDING SYSTEM VALUE VALUES (21, 'header', 'content-disposition');
INSERT INTO camdaux.cors(cors_id, key, value) OVERRIDING SYSTEM VALUE VALUES (22, 'method', 'GET');
INSERT INTO camdaux.cors(cors_id, key, value) OVERRIDING SYSTEM VALUE VALUES (23, 'method', 'PUT');
INSERT INTO camdaux.cors(cors_id, key, value) OVERRIDING SYSTEM VALUE VALUES (24, 'method', 'POST');
INSERT INTO camdaux.cors(cors_id, key, value) OVERRIDING SYSTEM VALUE VALUES (25, 'method', 'DELETE');
INSERT INTO camdaux.cors(cors_id, key, value) OVERRIDING SYSTEM VALUE VALUES (26, 'method', 'OPTIONS');
