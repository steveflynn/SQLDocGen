/*Entended Properties Generator.  Usage Instructions
This is a 3 step process to generate a default set of extended properties and values
for database documentation purposes.  The documentation can be made as lightweight or 
as comprehensive as required, depending on data governance requirements by choosing more or
fewer properties to be included (see the table variable section below on how to do this).

Step 1. Prepare and execute this script
Step 2. Select and copy the data generated and paste in the Excel workbook
	 	Optionally make any changes to the propery value column in the workbook to customise the default values generated
Step 3. Copy the code from the Add (or Delete or Update) column in the workbook 
		and paste into a query windows and execute to add (update or delete) the extended properties

Repeat Steps 1 - 3 for each object type: SCHEMAS, TABLES AND VIEWS, PROCEDURES, COLUMNS

The script should be used together with the ExtendedPropertiesGenerator Excel workbook
The script generates a list of db objects (tables/view/procs/columns,etc) with properties and default values
that will be added to the db as extended properties in step 3.
The script can also be used to add additional documentation properties to a database which currently uses 
extended properties for documentation
*/

------------------------------------------------------------------------------------------------------------------
--LIST OF PROPERTIES AND DEFAULT VALUES
---------------------------------------
/*Use this table variable to choose which properties are required for documentation.
The query that retrieves the metadata about the db objects does a CROSS JOIN
on this table variable, so each Insert statement that is uncommented will add that property and its default value
to each object in the db (table/view/proc/column, etc)
*/
DECLARE @tListOfProps TABLE (prop sysname, value sysname)
INSERT @tListOfProps (prop, value) VALUES('Description', 'Describe what the function or stored procedure does.')
--INSERT @tListOfProps (prop, value) VALUES('Display Name', 'Display name for front end forms, client screens, etc')
--INSERT @tListOfProps (prop, value) VALUES('Example Values', 'Example max, min and typical values')
--INSERT @tListOfProps (prop, value) VALUES('SCD Type', 'Used for slowly changing dimensions')
--INSERT @tListOfProps (prop, value) VALUES('Source System Field Name','Data Lineage: The field name in the source system. Knowing this can be very useful!')
--INSERT @tListOfProps (prop, value) VALUES('Source System Schema','Data Lineage: Schema from the source system')
--INSERT @tListOfProps (prop, value) VALUES('Source System','Data Lineage: The Source System Name')
--INSERT @tListOfProps (prop, value) VALUES('Source System Owner','Data Lineage: Name and Contact details for the source system owner')
--INSERT @tListOfProps (prop, value) VALUES('Source System Table','Data Lineage: The source table name')
INSERT @tListOfProps (prop, value) VALUES('Version','1.0')
--INSERT @tListOfProps (prop, value) VALUES('Data Owner','The name and contact details for the owner of the data')
--INSERT @tListOfProps (prop, value) VALUES('Business Rule','If this is computed or derived column, add the business logic on how the value is derived.  Very useful info to have here!')
----Add additional Insert statements here to add extra extended properties.  These are just my default suggestions.
--------------------------------------------------------------------------------------------------------------------
---- COLUMNS
------------
--SELECT CASE WHEN t.TABLE_TYPE = 'BASE TABLE' THEN 'TABLE' ELSE TABLE_TYPE END AS TABLE_TYPE, t.TABLE_SCHEMA, c.table_name, c.COLUMN_NAME, data_type 
--,prop, value
--FROM INFORMATION_SCHEMA.columns c
--INNER JOIN INFORMATION_SCHEMA.tables t ON c.table_name = t.table_name
--CROSS JOIN @tListOfProps

--------------------------------------------------------------------------------------------------------------------
--SCHEMAS
---------

--SELECT SCHEMA_NAME, prop, value FROM INFORMATION_SCHEMA.SCHEMATA
--	CROSS JOIN @tListOfProps
--	WHERE SCHEMA_NAME NOT LIKE 'db__%' 
--	AND SCHEMA_NAME NOT IN('GUEST','INFORMATION_SCHEMA','sys')

--------------------------------------------------------------------------------------------------------------------	
--TABLES AND VIEWS
------------------
--SELECT CASE WHEN TABLE_TYPE = 'BASE TABLE' THEN 'TABLE' ELSE TABLE_TYPE END AS TABLE_TYPE, TABLE_SCHEMA, TABLE_NAME
--	,prop,value
--	FROM INFORMATION_SCHEMA.tables 
--	CROSS JOIN @tListOfProps


---------------------------------------------------------------------------------------------------------------------
--STORED PROCS AND FUNCTIONS
----------------------------
SELECT ROUTINE_TYPE, SPECIFIC_SCHEMA, SPECIFIC_NAME  
	,prop,value
	
	FROM INFORMATION_SCHEMA.ROUTINES
	CROSS JOIN @tListOfProps
	WHERE SPECIFIC_NAME NOT LIKE 'dt__%'
	
---------------------------------------------------------------------------------------------------------------------