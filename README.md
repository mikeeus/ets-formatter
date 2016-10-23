# README

Formats Ethiopian Revenue and Custom's Authority locally using rake tasks.


* Create database and migrate.
* Add latest records to 'db/records/:year/:type', type being either 'import' or 'export'
* Run import_records[:year,:type] rake task
* Review records in console and ensure they are correct
* Run export_records[:year, :type] to export the records as csv file into 'db/records/formatted/:year/:type'