class CreateEmailTemplates < ActiveRecord::Migration[5.1]
  def change
    create_table(:email_templates, id: false)do |t|
      t.integer :email_type, unique: true
      t.string :subject, null: false, unique: true
      t.text :html_body, null: false
      t.text :text_body, null: false

      t.timestamps
    end
    #ロールバックするときは以下の一文を削除してからロールバックしてください
    execute "ALTER TABLE email_templates ADD PRIMARY KEY (email_type);"
  end
end
