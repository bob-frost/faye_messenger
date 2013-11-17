class Message < ActiveRecord::Base
  belongs_to :sender, class_name: 'User'
  belongs_to :recipient, class_name: 'User'

  validates_presence_of :text

  scope :dialog, -> (first_user, second_user) { where('(sender_id = :sender_id AND recipient_id = :recipient_id) OR (sender_id = :recipient_id AND recipient_id = :sender_id)', sender_id: first_user.id, recipient_id: second_user.id) }

  def read?
    read_at.present?
  end

end
