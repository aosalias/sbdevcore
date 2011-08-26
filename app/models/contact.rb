class Contact < ActiveRecord::Base
  attr_accessible :name, :email, :message

  after_create :send_email

  validates_presence_of :name, :email, :message

  validates_email :email

  def send_email
    Mailer.message(self).deliver
  end
end
