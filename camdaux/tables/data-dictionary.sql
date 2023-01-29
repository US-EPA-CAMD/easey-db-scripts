CREATE TABLE IF NOT EXISTS camdaux.data_dictionary(
	property_name character varying(50) NOT NULL,
	display_name character varying(75) NOT NULL,
	metadata_key character varying(100) NOT NULL DEFAULT 'default',
	description character varying(1000) NOT NULL,
	example_value character varying(50),
	data_type character varying(50) NOT NULL DEFAULT 'text',
	ADD CONSTRAINT pk_data_dictionary PRIMARY KEY (property_name, metadata_key),
	ADD CONSTRAINT ck_data_dictionary_data_type CHECK(
		data_type = ANY(ARRAY['text', 'date', 'numeric'])
	),
);

INSERT INTO camdaux.data_dictionary(
	property_name, display_name, metadata_key, example_value, description, data_type
) VALUES
	('accountName', 				'Account Name', 					'default', 		'Barry', 								'The name of the account in which allowances are held.', null),
	('accountNumber', 				'Account Number', 					'default', 		'000003FACLTY', 						'The unique identification number of an account.', null),
	('accountType', 				'Account Type', 					'default', 		'Facility Account', 					'Type of allowance account (Facility, General, etc.).', null),
	('accountTypeCode', 			'Account Type Code',				'default', 		'RESERVE', 								'Code for the type of allowance account.', null),
	('accountTypeDescription', 		'Account Type Description', 		'default', 		'EPA Reserve Account', 					'Full description for the type of allowance account.', null),
	('accountTypeGroupCode', 		'Account Type Group Code', 			'default', 		'RESERVE', 								'Code for the group to which the allowance account belongs.', null),
	('accountTypeGroupDescription', 'Account Type Group Description', 	'default', 		'Reserve', 								'Full description for the group to which the allowance account belongs.', null),
	('id', 							'Record Id', 						'default', 		'ff4ac3cd-0960-4370-ad5a-afc3835de17b',	'Primary unique identifier of a record.', null),
	('exclude', 					'Exclude', 							'default', 		null,									'Parameter used to exclude records containg data for the selected values.', null),
	('exclude', 					'Exclude', 							'accountType',	'GENERAL', 								'Parameter used to exclude the selected Account Type codes from the response.', null),
	('exclude', 					'Exclude', 							'program', 		'CAIRNOX', 								'Parameter used to exclude the selected Program codes from the response.', null);
