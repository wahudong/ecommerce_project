class RemoveAboutUsFromPages < ActiveRecord::Migration[6.0]
  def change

    remove_column :pages, :about_us, :text
  end
end
