class Admins::GamesController < ApplicationController
	def index
		if params[:place] == "user"
			@games = Game.where(user_id: params[:user_id]).page(params[:page]).per(10).reverse_order
		elsif params[:place] == "top"
			@games = Game.where(created_at: Time.now.in_time_zone("Tokyo").beginning_of_day..Time.now.in_time_zone("Tokyo").end_of_day).page(params[:page]).per(10).reverse_order
		else
			@games = Game.all.page(params[:page]).per(10).reverse_order
		end
	end

	def show
		@game = Game.find(params[:id])
	end

	def edit
		@game = Game.find(params[:id])
	end

	def update
		@game = Game.find(params[:id])
		if @game.update(game_params)
			flash[:notice] = "変更を保存しました"
			redirect_to admins_game_path(@game)
		else
			flash[:danger] = "入力ミスがあります"
			render 'edit'
		end
	end

	def destroy
		game = Game.find(params[:id])

		#S3に保存してあるファイルの削除
		region = 'ap-northeast-1'
		bucket = ENV['S3_BUCKET_NAME']
		client = Aws::S3::Client.new(region: region)
		file_path = "games/" + game.file_name
		client.delete_object(bucket: bucket, key: file_path)

		game.destroy
		flash[:notice] = "ゲームを削除しました"
		redirect_to admins_games_path
	end

	def download
		game = Game.find(params[:id])
		region = 'ap-northeast-1'
	    bucket = ENV['S3_BUCKET_NAME'] # S3バケット名
	    key = "games/" + game.file_name

	    client = Aws::S3::Client.new(region: region)
	    data = client.get_object(:bucket => bucket, :key => key).body
	    type = File.extname(game.file_name)		#拡張子取得
	    file_name = game.file_name		#ダウンロード時のファイル名

	    send_data data.read, filename: file_name, disposition: 'attachment',  type: type
	end

	private
	def game_params
		params.require(:game).permit(:title, :introduction, :url, :tag_list, screenshots_attributes: [:id, :game_id, :image, :_destroy])
	end
end
