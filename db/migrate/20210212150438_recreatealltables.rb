class Recreatealltables < ActiveRecord::Migration[5.2]
  def change
    create_table :customers do |t|
      t.string :first_name
      t.string :last_name

      t.timestamps
    end

    create_table :merchants do |t|
      t.string :name

      t.timestamps
    end

    create_table :invoices do |t|
      t.references :merchant, foreign_key: true
      t.references :customer, foreign_key: true
      t.integer :status, default: 0

      t.timestamps
    end

    create_table :transactions do |t|
      t.references :invoice, foreign_key: true
      t.string :credit_card_number
      t.string :credit_card_expiration_date
      t.integer :result

      t.timestamps
    end

    create_table :items do |t|
      t.string :name
      t.text :description
      t.float :unit_price
      t.references :merchant, foreign_key: true

      t.timestamps
    end

    create_table :invoice_items do |t|
      t.integer :quantity
      t.float :unit_price
      t.references :item, foreign_key: true
      t.references :invoice, foreign_key: true

      t.timestamps
    end
  end
end
