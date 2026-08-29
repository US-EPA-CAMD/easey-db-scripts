CREATE TABLE IF NOT EXISTS camdaux.event_a
(
    event_id numeric NOT NULL,
    fac_id numeric,
    unit_id numeric,
    action varchar(12),
    add_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    mod_type varchar(12),
    userid varchar(160),
    rec_date timestamp without time zone,
    event_status varchar(1) NOT NULL,
    event_code varchar(5),
    ppl_id numeric(38,0),
    event_comment varchar(4000),
    event_type varchar(5),
    prg_code varchar(8),
    sent_date timestamp without time zone,
    account_number varchar(12),
    account_id numeric(38,0),
    trans_id numeric(38,0),
    auction_id numeric(38,0),
    auction_winner_id numeric(38,0),
    submission_id numeric(38,0),
    xml_data sys.xmltype,
    PRIMARY KEY (event_id)
);
COMMENT ON TABLE camdaux.event_a
    IS 'Records the program EVENT or action related to a facility, unit, or other entity.';
COMMENT ON COLUMN camdaux.event_a.event_id
    IS 'A unique, assigned number, used to identify a single EVENT.';
COMMENT ON COLUMN camdaux.event_a.fac_id
    IS 'FACILITY ID identity key.';
COMMENT ON COLUMN camdaux.event_a.unit_id
    IS 'Identity key for UNIT table.';
COMMENT ON COLUMN camdaux.event_a.action
    IS 'Description of event action';
COMMENT ON COLUMN camdaux.event_a.add_date
    IS 'Date the record was created.';
COMMENT ON COLUMN camdaux.event_a.mod_type
    IS 'Identifies specific module  (Cert of Rep, Offer of Information, etc..) with which the event is associated.';
COMMENT ON COLUMN camdaux.event_a.userid
    IS 'The user name of the person or process that created the record if the Update Date is empty.  Otherwise this is the user name of the person or process that made the last update.';
COMMENT ON COLUMN camdaux.event_a.rec_date
    IS 'Data in which APPLICABILITY DETERMINATION request was received.';
COMMENT ON COLUMN camdaux.event_a.event_status
    IS 'Event status code.';
COMMENT ON COLUMN camdaux.event_a.event_code
    IS 'The code characterizing the type of EVENT recorded. ';
COMMENT ON COLUMN camdaux.event_a.ppl_id
    IS 'PEOPLE identity key.';
COMMENT ON COLUMN camdaux.event_a.event_comment
    IS 'Narrative description of EVENT or log action. ';
COMMENT ON COLUMN camdaux.event_a.event_type
    IS 'Type of EVENT code.';
COMMENT ON COLUMN camdaux.event_a.prg_code
    IS 'Code used to identify regulatory PROGRAM applicable to UNIT.  ';
COMMENT ON COLUMN camdaux.event_a.sent_date
    IS 'Date on which email was sent.';
COMMENT ON COLUMN camdaux.event_a.account_number
    IS 'Account number which is associated with this event.';
COMMENT ON COLUMN camdaux.event_a.account_id
    IS 'Identity key for ACCOUNT that is associated with this event.';
COMMENT ON COLUMN camdaux.event_a.trans_id
    IS 'Identity key for TRANSACTION that is associated with this event.';
COMMENT ON COLUMN camdaux.event_a.auction_id
    IS 'Identity key for AUCTION that is associated with this event.';
COMMENT ON COLUMN camdaux.event_a.auction_winner_id
    IS 'Identify key from AUCTION_WINNER.';
COMMENT ON COLUMN camdaux.event_a.submission_id
    IS 'Submission ID for the ECMPS submission that is associated with this event.';
COMMENT ON COLUMN camdaux.event_a.xml_data
    IS 'XML Containing data associated with the raised event.';