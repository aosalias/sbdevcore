class Contact < ActiveRecord::Base
  attr_accessible :name, :email, :message
  belongs_to :course_price

  after_create :send_email

  def send_email
    Mailer.deliver_message(self)
  end
end
