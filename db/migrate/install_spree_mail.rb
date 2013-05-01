class InstallSpreeMail < ActiveRecord::Migration
  def change
    create_table :spree_subscribers do |t|
      t.string     :token
      t.string     :name
      t.string     :email
      t.datetime   :unsubscribed_at
      t.timestamps
    end

    create_table :spree_emails do |t|
      t.string     :token
      t.text       :to
      t.string     :subject
      t.text       :body
      t.timestamps
    end

  end

end
