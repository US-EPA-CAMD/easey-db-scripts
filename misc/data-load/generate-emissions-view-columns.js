// RUN THIS SQL QUERY ON THE LATEST SQL SERVER ECMPS_AUX DB TO GET COLUMNS FOR THE VIEW NEEDED
/*
declare @id integer = 11
select * from [Emissions].[GridColumn] where grid_id = @id order by column_order
select '(datatableId, ' + cast(column_order as varchar) + ', ''' + lower(column_key) + ''', ''' + column_name + '''),'
from [Emissions].[GridColumn] where grid_id = @id order by column_order
*/
const data = `
(datatableId, 1, 'datehour', 'Date/Hr'),
(datatableId, 3, 'fuel_sys_id', 'Fuel System ID'),
(datatableId, 4, 'fuel_type', 'Fuel Type'),
(datatableId, 5, 'fuel_use_time', 'Fuel Use Time'),
(datatableId, 6, 'unit_load', 'Load'),
(datatableId, 7, 'load_uom', 'Load UOM'),
(datatableId, 8, 'rpt_fuel_flow', 'Rpt. Fuel Flow'),
(datatableId, 9, 'calc_fuel_flow', 'Fuel Flow Used in Calc.'),
(datatableId, 10, 'fuel_flow_uom', 'Fuel Flow Units of Measure'),
(datatableId, 11, 'fuel_flow_sodc', 'Fuel Flow SODC'),
(datatableId, 12, 'gross_calorific_value', 'GCV'),
(datatableId, 13, 'gcv_uom', 'GCV Units of Measure '),
(datatableId, 14, 'gcv_sampling_type', 'GCV Sampling Type'),
(datatableId, 15, 'formula_code', 'Formula Code'),
(datatableId, 16, 'rpt_hi_rate', 'Rpt. HI Rate (mmBtu/hr)'),
(datatableId, 17, 'calc_hi_rate', 'Calc. HI Rate (mmBtu/hr)'),
(datatableId, 18, 'error_codes', 'Hourly Errors'),
`;
const glossary = {
  cd: "Code",
  id: "Identifier",
  ind: "Indicator",
  ref: "Reference",
  param: "Parameter",
  diff: "Difference",
  adj: "Adjusted",
  unadj: "Unadjusted",
  modc: "MODC",
  sys: "System",
  use: "Use",
};
const splitLines = data.split("\n");
const sliced = splitLines.slice(1, splitLines.length - 1);
const outputArr = sliced.map((val) => {
  const parts = val.split(",");
  let columnName = parts[2].trim();
  columnName = columnName.replace("'", "").replace("'", "");
  let columnNameParts = columnName.split("_");
  for (let i = 0; i < columnNameParts.length; i++) {
    let currentChunk = columnNameParts[i];
    if (glossary[currentChunk]) {
      columnNameParts[i] = glossary[currentChunk];
    } else if (currentChunk.length <= 3) {
      columnNameParts[i] = currentChunk.toUpperCase();
    } else {
      columnNameParts[i] =
        currentChunk.charAt(0).toUpperCase() + currentChunk.slice(1);
    }
    if (i === 0) {
      columnNameParts[i] = columnNameParts[i].toLowerCase();
    }
  }
  return `${parts[0]},${parts[1]},${parts[2]}, '${columnNameParts.join("")}',${
    parts[3]
  },`;
});
for (chunk of outputArr) {
  console.log(chunk);
}
