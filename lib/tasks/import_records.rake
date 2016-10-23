require 'csv'
desc "type: 'import'||'export', year: eg: 2016"
task :import_records, [:year, :type] => :environment do |t, args|
  
  year = args[:year]
  type = args[:type]
  path = "db/records/#{year}/#{type}.csv"


  if type == "import" || type == "export"

    # Check if records exist
    if type == "import" && Import.count > 0
      puts "Import records exist, please purge records then try again"
    elsif type == "export" && Export.count > 0
      puts "Export records exist, please purge records then try again"
    else

      puts "Starting upload"

      CSV.read(path, headers: true, encoding: 'windows-1251:UTF-8').tap do |csv|

        len = csv.size

        print "Uploading #{type}s: \n"
        
        csv.each_with_index do |row, idx|
          progress = idx.to_f/len.to_f
          # Update the progress bar display for the user.
          print "\r#{progress}"
        
          # IMPORTS ------------------------------------------------------
          if type == "import"
            import_hash = row.to_hash
            code = import_hash['code']
            month = import_hash['month']
            # Look for existing import
            import = Import.find_by(
              year: import_hash['year'],
              code: code,
              country_origin: import_hash['country_origin'],
              country_consignment: import_hash['country_consignment']
            )
            # Look for existin hscode
            hscode = Hscode.find_by(code: code)
            # If an import for this record already exists for this year, sum the values
            if !import.nil?
              import.update_attributes({
                net_mass: (import.cif_etb + import_hash['net_mass'].to_d),
                cif_etb: (import.net_mass + import_hash['cif_etb'].to_d),
                cif_usd: (import.cif_usd + import_hash['cif_usd'].to_d)
              })
            # If no import exists, but an hscode exists:
            elsif import.nil? && !hscode.nil?
              # Use this record to add import record
              import_record = {
                year: import_hash['year'],
                code: code,
                description: hscode.description,
                country_origin: import_hash['country_origin'],
                country_consignment: import_hash['country_consignment'],
                net_mass: import_hash['net_mass'],
                cif_etb: import_hash['cif_etb'],
                cif_usd: import_hash['cif_usd']
              }
              import_build = hscode.imports.build(import_record)
              import_build.save
            # If hscode does not exist:
            elsif import.nil? && hscode.nil?
              hscode = Hscode.find_by(code: 0)
              # Use this record to add import record
              import_record = {
                year: import_hash['year'],
                code: code,
                description: hscode.description,
                country_origin: import_hash['country_origin'],
                country_consignment: import_hash['country_consignment'],
                net_mass: import_hash['net_mass'],
                cif_etb: import_hash['cif_etb'],
                cif_usd: import_hash['cif_usd']
              }
              import_build = hscode.imports.build(import_record)
              import_build.save
            end

          # EXPORTS ------------------------------------------------------
          elsif type == "export" 
            export_hash = row.to_hash
            code = export_hash['code']
            month = export_hash['month']
            # Look for existing import
            export = Export.find_by(
              year: export_hash['year'],
              code: code,
              destination: export_hash['destination']
            )
            # Look for existin hscode
            hscode = Hscode.find_by(code: code)

            # If an export for this record already exists, but doesn't include this month, sum the values
            if !export.nil? 
              export.update_attributes({
                net_mass: (export.net_mass + export_hash['net_mass'].to_d),
                fob_usd: (export.fob_usd + export_hash['fob_usd'].to_d),
                fob_etb: (export.fob_etb + export_hash['fob_etb'].to_d)
              })

            # If no export exists, but an hscode exists:
            elsif export.nil? && !hscode.nil?
              
              # Use this record to add export record
              export_record = {
                year: export_hash['year'],
                code: code,
                description: hscode.description,
                destination: export_hash['destination'],
                net_mass: export_hash['net_mass'],
                fob_etb: export_hash['fob_etb'],
                fob_usd: export_hash['fob_usd']
              }

              export_build = hscode.exports.build(export_record)
              export_build.save
            # If hscode does not exist:
            elsif export.nil? && hscode.nil?
              hscode = Hscode.find_by(code: 0)
              
              # Use this record to add export record
              export_record = {
                year: export_hash['year'],
                code: code,
                description: hscode.description,
                destination: export_hash['destination'],
                net_mass: export_hash['net_mass'],
                fob_etb: export_hash['fob_etb'],
                fob_usd: export_hash['fob_usd']
              }
              export_build = hscode.exports.build(export_record)
              export_build.save
            end
          end # elsif type == "export"
        end # csv.each_with_index

      end # CSV.read
    end # elsif im_count == 0 && ex_count ==0
  else
    puts "please input type 'import' or 'export'"
  end # if type == 'import' || 'export|| else ...

end # task
