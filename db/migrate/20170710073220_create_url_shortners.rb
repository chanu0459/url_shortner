class CreateUrlShortners < ActiveRecord::Migration
  def change
    create_table :url_shortners do |t|
      t.string :url
      t.string :unique_code
      t.integer :clicks
      t.datetime :expires_at

      t.timestamps
    end
    add_index :url_shortners, ["unique_code", "expires_at"], :unique => true, :name => 'url_code'
  end
end
