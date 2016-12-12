class AddHttpProxies < ActiveRecord::Migration
  def change
    create_table :foreman_http_proxies_http_proxies do |t|
      t.string :name, :null => false
      t.string :url, :null => false
      t.string :username
      t.string :password
      t.integer :port, :null => false
    end
  end
end
