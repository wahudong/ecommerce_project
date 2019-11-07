class CreatePages < ActiveRecord::Migration[6.0]
  def change
    create_table :pages do |t|
      t.text :content
      t.text :about_us

      t.timestamps
    end
  end
end
