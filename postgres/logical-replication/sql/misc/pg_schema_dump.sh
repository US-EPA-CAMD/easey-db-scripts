# This script dumps the schema from the camd-pg-db in cloud.gov.  If the publication is changed to add
# or remove schema or table then this needs to be updated.

if [ $# -eq 0 ]
then
    echo "This script is used to dump the schema objects for the publication."
    echo "Before running this command, in a separate window connect to the Cloud.gov"
    echo "database using the service-connect plugin"
    echo
    echo "usage: pg_schema_dump -u <username> -h <host> -p <port> -d <database>"
    exit
fi

while getopts u:h:p:d: flag
do
    case "${flag}" in
        u) PGUSER=${OPTARG};;
        h) PGHOST=${OPTARG};;
        p) PGPORT=${OPTARG};;
        d) PGDATABASE=${OPTARG};;
    esac
done

export PGUSER
export PGHOST
export PGDATABASE
export PGPORT

pg_dump -v -x -f 'camd-schema-dump.sql' -F p -c -s \
--table-and-children=camd.* \
--table-and-children=camdmd.* \
--table-and-children=camddmw_arch.* \
--table-and-children=camdecmps.* \
--table-and-children=camdecmpsmd.* \
--table-and-children=camdaux.bookmark \
--table-and-children=camdecmpsaux.check_log \
--table-and-children=camddmw.account_compliance_dim \
--table-and-children=camddmw.account_fact \
--table-and-children=camddmw.account_owner_dim \
--table-and-children=camddmw.allowance_holding_dim \
--table-and-children=camddmw.annual_unit_data \
--table-and-children=camddmw.control_year_dim \
--table-and-children=camddmw.day_unit_data \
--table-and-children=camddmw.fuel_year_dim \
--table-and-children=camddmw.hour_unit_data \
--table-and-children=camddmw.hour_unit_mats_data \
--table-and-children=camddmw.month_unit_data \
--table-and-children=camddmw.owner_display_fact \
--table-and-children=camddmw.owner_year_dim \
--table-and-children=camddmw.ozone_unit_data \
--table-and-children=camddmw.program_year_dim \
--table-and-children=camddmw.quarter_unit_data \
--table-and-children=camddmw.rep_year_dim \
--table-and-children=camddmw.transaction_block_dim \
--table-and-children=camddmw.transaction_fact \
--table-and-children=camddmw.transaction_owner_dim \
--table-and-children=camddmw.unit_compliance_dim \
--table-and-children=camddmw.unit_fact \
--table-and-children=camddmw.unit_type_year_dim