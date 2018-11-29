class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email, null: false, unique: true
      t.string :name, null: false

      t.string :password_hash, null: false

      t.datetime :email_verified_at
      t.string   :email_verification_token

      t.timestamps
    end
  end
end
