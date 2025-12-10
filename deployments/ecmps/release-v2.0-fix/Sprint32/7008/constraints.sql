ALTER TABLE camdecmps.analyzer_range
    ALTER COLUMN begin_date SET NOT NULL;

ALTER TABLE camdecmps.analyzer_range
    ALTER COLUMN begin_hour SET NOT NULL;

ALTER TABLE camdecmps.system_fuel_flow
    ALTER COLUMN begin_date SET NOT NULL;

ALTER TABLE camdecmps.system_fuel_flow
    ALTER COLUMN begin_hour SET NOT NULL;

ALTER TABLE camdecmps.unit_capacity
    ALTER COLUMN begin_date SET NOT NULL;

ALTER TABLE camdecmpswks.analyzer_range
    ALTER COLUMN begin_date SET NOT NULL;

ALTER TABLE camdecmpswks.analyzer_range
    ALTER COLUMN begin_hour SET NOT NULL;

ALTER TABLE camdecmpswks.system_fuel_flow
    ALTER COLUMN begin_date SET NOT NULL;

ALTER TABLE camdecmpswks.system_fuel_flow
    ALTER COLUMN begin_hour SET NOT NULL;

ALTER TABLE camdecmpswks.unit_capacity
    ALTER COLUMN begin_date SET NOT NULL;

