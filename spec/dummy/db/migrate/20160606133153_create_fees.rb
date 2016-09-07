class CreateFees < ActiveRecord::Migration[5.0]
  def change
    create_table :fees do |t|
      t.string :case_title
      t.string :case_reference
      t.string :description
      t.integer :amount
      t.integer :glimr_id
      t.string  :govpay_reference
      t.string  :govpay_payment_id
      t.string  :govpay_payment_status
      t.string  :govpay_payment_message
    end
  end
end
