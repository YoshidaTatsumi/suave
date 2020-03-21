class Notification < ApplicationRecord
	#新しい通知から順に取得。Notification.firstで一番新しいデータを取得できる
	default_scope -> { order(created_at: :desc) }

	#optional:true nilを許可する。belongs_toではnilが許可されない為必要。
	belongs_to :game, optional: true
	belongs_to :comment, optional: true

	belongs_to :visitor, class_name: 'User', foreign_key: 'visitor_id', optional: true
	belongs_to :visited, class_name: 'User', foreign_key: 'visited_id', optional: true
end
