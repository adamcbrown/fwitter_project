class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :profile_img_link
      t.integer :day_of_birth
      t.integer :month_of_birth
      t.integer :year_of_birth
    end
  end

  def down
    drop_table :users
  end
end
