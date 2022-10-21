const data = `
(datatableId, 1, 'date_hour', 'Date/Hr'),
(datatableId, 3, 'op_time', 'Op. Time'),
(datatableId, 4, 'unit_load', 'Load'),
(datatableId, 5, 'load_uom', 'Load UOM'),
(datatableId, 6, 'unadj_nox', 'Unadj. NOx (ppm)'),
(datatableId, 7, 'calc_nox_baf', 'Calc. NOx BAF'),
(datatableId, 8, 'rpt_adj_nox', 'Rpt. Adj. NOx (ppm)'),
(datatableId, 9, 'adj_nox_used', 'Adj. NOx (ppm) Used in Calc.'),
(datatableId, 10, 'nox_modc', 'NOx MODC'),
(datatableId, 11, 'nox_pma', 'NOX PMA'),
(datatableId, 12, 'unadj_flow', 'Unadj. Flow (scfh)'),
(datatableId, 13, 'calc_flow_baf', 'Calc. Flow BAF'),
(datatableId, 14, 'rpt_adj_flow', 'Rpt. Adj. Flow (scfh)'),
(datatableId, 15, 'adj_flow_used', 'Adj. Flow (scfh) Used in Calc.'),
(datatableId, 16, 'flow_modc', 'Flow MODC'),
(datatableId, 17, 'flow_pma', 'Flow PMA'),
(datatableId, 18, 'pct_h2o_used', '% H2O Used in Calc.'),
(datatableId, 19, 'source_h2o_value', 'Source of H2O Value'),
(datatableId, 20, 'nox_mass_formula_cd', 'NOx Mass Formula Code'),
(datatableId, 21, 'rpt_nox_mass', 'Rpt. NOx Mass Rate (lbs/hr)'),
(datatableId, 22, 'calc_nox_mass', 'Calc. NOx Mass Rate (lb/hr)'),
(datatableId, 23, 'error_codes', 'Hourly Errors'),
`
const glossary = {
    "cd": "Code",
    "id": "Identifier",
    "ind": "Indicator",
    "ref": "Reference",
    "param": "Parameter",
    "diff": "Difference",
    "adj": "Adjusted",
    "unadj": "Unadjusted",
    "modc": "MODC",
}
const splitLines = data.split('\n');
const sliced = splitLines.slice(1, splitLines.length - 1);
const outputArr = sliced.map((val) => {
    const parts = val.split(",");
    let columnName = parts[2].trim();
    columnName = columnName.replace("\'", "").replace("\'", "");
    let columnNameParts = columnName.split("_");
    for(let i = 0; i < columnNameParts.length; i++){
        let currentChunk = columnNameParts[i];
        if(glossary[currentChunk]){
            columnNameParts[i] = glossary[currentChunk];
        }
        else if(currentChunk.length <= 3){
            columnNameParts[i] = currentChunk.toUpperCase();
        }
        else{
            columnNameParts[i] = currentChunk.charAt(0).toUpperCase() + currentChunk.slice(1);
        }
        if (i === 0){
            columnNameParts[i] = columnNameParts[i].toLowerCase();
        }
    }
    return `${parts[0]},${parts[1]},${parts[2]}, '${columnNameParts.join("")}',${parts[3]},`;
});
for(chunk of outputArr){
    console.log(chunk);
}