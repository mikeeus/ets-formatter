class CreateExports < ActiveRecord::Migration[5.0]
  def change
    create_table :exports do |t|
      t.belongs_to :hscode, foreign_key: true, index: true
      t.integer :year,        null: false, index: true
      t.integer :month,       null: false, index: true      
      t.integer :code,        null: false, index: true
      t.string  :description, null: false
      t.string  :destination, null: false, index: true
      t.decimal :net_mass, precision: 13, scale: 2, 
        null: false
      t.decimal :fob_usd, precision: 13, scale: 2, 
        null: false
      t.decimal :fob_etb, precision: 13, scale: 2, 
        null: false
        
      t.timestamps
    end
  end
end
