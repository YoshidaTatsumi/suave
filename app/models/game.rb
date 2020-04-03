class Game < ApplicationRecord
	has_many :notifications, dependent: :destroy
	has_many :comments, dependent: :destroy
	has_many :screenshots, dependent: :destroy

	belongs_to :user

	#nested_form_fieldsに必要な記述
	accepts_nested_attributes_for :screenshots, allow_destroy: true

	validates :title, presence: true, length: {maximum: 30}
	validates :introduction, presence: true

	#acts-as-taggable-onを使用できるように記述
	acts_as_taggable

	#ファイルを受け取る為定義
	attr_accessor :file

	def rating_avg	#ゲームの評価の平均取得
		comments.where.not(rating: nil).average(:rating)
	end

	def difficulty_avg	#ゲームの難易度の平均取得
		comments.where.not(difficulty: nil).average(:difficulty)
	end


	def create_notification_comment!(current_user, comment_id)
		comment = Comment.find(comment_id)
	    save_notification_comment!(current_user, comment_id, user.id)
    end

    def save_notification_comment!(current_user, comment_id, visited_id)
	    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
	    notification = current_user.active_notifications.new(
			game_id: id,
			comment_id: comment_id,
			visited_id: visited_id,
			action: 'comment'
	    )
	    # 自分で自分の投稿にコメントした場合は、通知済みとする
	    if notification.visitor_id == notification.visited_id
			notification.checked = true
	    end
	    notification.save if notification.valid?
	end
end
