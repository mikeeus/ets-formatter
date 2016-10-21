class CreateHscodes < ActiveRecord::Migration[5.0]
  def change
    create_table :hscodes do |t|
      t.integer :code,        null: false, index: true
      t.string  :description, null: false, index: true
      t.string  :unit,        null: false, default: "UN"
      t.string  :special_permission, null: false, default: "None"
      t.integer :duty,     null: false, default: 0
      t.integer :excise,   null: false, default: 0
      t.integer :vat,      null: false, default: 0
      t.integer :sur,      null: false, default: 0
      t.integer :withhold, null: false, default: 0
      t.integer :ss1,      null: false, default: 0
      t.integer :ss2,      null: false, default: 0
      
      t.timestamps
    end
  end
end
