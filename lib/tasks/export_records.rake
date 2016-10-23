require 'csv'
desc 'export records to a csv file export_records[year,type] (eg. 2016, import)'
task :export_records, [:year, :type] => :environment do |t, args|
  year = args[:year]
  type = args[:type]
  # path = "db/records/formatted/#{year}/#{type}.csv"
  path = "db/records/formatted/#{year}/#{type}.csv"


  if type == "import" || type == "export"
    CSV.open(path, 'wb') do |csv|
      import_header = %w[year code country_origin country_consignment net_mass cif_etb cif_usd]
      export_header = %w[year code destination net_mass fob_etb fob_usd]    
      if type == "import"
        csv << import_header
        Import.where(year: year).each do |import|
          row = []
          # Insert records into the row
          row << import.year
          row << import.code
          row << import.country_origin
          row << import.country_consignment
          row << import.net_mass
          row << import.cif_etb
          row << import.cif_usd
          # Add row to csv file
          csv << row
        end
      elsif type == "export"
        csv << export_header
        Export.where(year: year).each do |export|
          row = []
          # Insert records into the row
          row << export.year
          row << export.code
          row << export.destination
          row << export.net_mass       
          row << export.fob_etb
          row << export.fob_usd
          # Add row to csv file
          csv << row
        end
      end # if type
    end # CSV.open
  else
    puts "please input type 'import' or 'export'"
  end
end # task
