DO $$
DECLARE
    datatableId integer := (
        SELECT
            datatable_id
        FROM
            camdaux.datatable
        WHERE
            dataset_cd = 'TEST_DETAIL'
            AND template_cd = 'APPEHIGAS'
            AND table_order = 12
    );
BEGIN
    UPDATE camdaux.datacolumn
    SET display_name = 'Gas GCV'
    WHERE datatable_id = datatableId
        AND name = 'gasGCV';

    UPDATE camdaux.datacolumn
    SET display_name = 'Gas Volume'
    WHERE datatable_id = datatableId
        AND name = 'gasVolume';

    UPDATE camdaux.datacolumn
    SET display_name = 'Reported Gas HI'
    WHERE datatable_id = datatableId
        AND name = 'gasHI';

    UPDATE camdaux.datacolumn
    SET display_name = 'Recalculated Gas HI'
    WHERE datatable_id = datatableId
        AND name = 'calculatedGasHI';
END
$$ LANGUAGE plpgsql;
