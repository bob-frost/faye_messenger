class User < ActiveRecord::Base

  has_many :sent_messages, class_name: 'Message', foreign_key: :sender_id
  has_many :received_messages, class_name: 'Message', foreign_key: :recipient_id

  devise :database_authenticatable, :registerable, :rememberable, :validatable

  validates :username, presence: true,
                       uniqueness: {case_sensitive: false}

  def role_symbols
    [:registered]
  end

  def messages
    Message.where "sender_id = #{id} OR recipient_id = #{id}"
  end

  def collocutors
    ids = messages.select(:sender_id, :recipient_id).group(:sender_id, :recipient_id)
            .map{ |m| m.sender_id == id ? m.recipient_id : m.sender_id }.uniq
    User.where id: ids
  end

  protected

    def email_required?
      false
    end

    def email_changed?
      false
    end
end
