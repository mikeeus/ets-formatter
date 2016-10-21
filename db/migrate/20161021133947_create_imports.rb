class CreateImports < ActiveRecord::Migration[5.0]
  def change
    create_table :imports do |t|
      t.belongs_to :hscode, foreign_key: true, index: true
      t.integer :year,            null: false, index: true
      t.integer :months, array: true, default: [], null: false, index: true      
      t.integer :code,            null: false, index: true
      t.string  :description,     null: false
      t.string  :country_origin,  null: false, index: true
      t.string  :country_consignment, null: false
      t.decimal :net_mass, precision: 13, scale: 2, 
        null: false
      t.decimal :cif_usd, precision: 13, scale: 2, 
        null: false
      t.decimal :cif_etb, precision: 13, scale: 2, 
        null: false
        
      t.timestamps
    end
  end
end
