class CreateCurrencies < ActiveRecord::Migration
  def change
    create_table :currencies do |t|
      t.text :uuid
      t.json :rates
      t.text :base

      t.timestamps
    end
  end
end
