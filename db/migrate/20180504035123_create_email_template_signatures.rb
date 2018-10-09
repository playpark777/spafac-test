class CreateEmailTemplateSignatures < ActiveRecord::Migration[5.1]
  def change
    create_table :email_template_signatures do |t|
      t.text :body, null: false

      t.timestamps
    end
  end
end
