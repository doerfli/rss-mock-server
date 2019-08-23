class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :title
      t.string :link
      t.datetime :updated
      t.datetime :published
      t.string :iid
      t.string :summary
      t.string :content
      t.references :feed

      t.timestamps
    end
  end
end
