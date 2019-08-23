class CreateFeeds < ActiveRecord::Migration[6.0]
  def change
    create_table :feeds do |t|
      t.string :title
      t.string :subtitle
      t.string :author
      t.string :iid

      t.timestamps
    end
  end
end
