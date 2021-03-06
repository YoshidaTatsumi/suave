class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attr_accessor :old_password, :new_password, :new_password_confirm

  attachment :image

  has_many :games, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :contacts, dependent: :destroy

  # フォロー取得
  has_many :active_relationships, class_name:  "Relationship", foreign_key: "follower_id", dependent: :destroy
  # フォロワー取得
  has_many :passive_relationships, class_name:  "Relationship", foreign_key: "followed_id", dependent: :destroy

  # 自分がフォローしている人
  has_many :following_user, through: :active_relationships, source: :followed
  # 自分をフォローしている人
  has_many :follower_user, through: :passive_relationships, source: :follower

  has_many :chats, dependent: :destroy
  has_many :user_rooms, dependent: :destroy
  has_many :rooms, through: :user_rooms, dependent: :destroy
  # 先にthroughの方を記述しないとユーザー削除と一緒にroomが削除されない
  has_many :rooms, dependent: :destroy

  #自分からの通知
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  #相手からの通知
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy

  validates :name, presence: true, length: {in: 2..20}
  validates :introduction, length: {maximum: 150}

  # ユーザーをフォローする
  def follow(user_id)
    active_relationships.create(followed_id: user_id)
  end

  # ユーザーのフォローを外す
  def unfollow(user_id)
    active_relationships.find_by(followed_id: user_id).destroy
  end

  # フォローしていればtrueを返す
  def following?(user)
    following_user.include?(user)
  end

  #フォローされたら通知が送られる
  def create_notification_follow!(current_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ? ",current_user.id, id, 'follow'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end
end
