class AddPermalinkToPages < ActiveRecord::Migration[6.0]
  def change
    add_column :pages, :permalink, :string
  end
end
