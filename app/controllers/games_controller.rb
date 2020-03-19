class GamesController < ApplicationController

	def index
		games = Game.all
		@index_games = Game.order("RANDOM()").limit(10)
		@desc_games = games.order(created_at: :desc).page(params[:new_game]).per(10)
		@favorite_games = games.where.not(rating: nil).order(rating: :desc).page(params[:favorite_game]).per(10)
		@difficult_games = games.where.not(difficulty: nil).order(difficulty: :desc).page(params[:difficult_game]).per(10)
		@easy_games = games.where.not(difficulty: nil).order(difficulty: :asc).page(params[:easy_game]).per(10)

		respond_to do |format|
	      format.html
	      format.js
	    end
	end

	def new
		@game = Game.new
		@game.screenshots.build
	end

	def show
		@game = Game.find(params[:id])
		@comment = Comment.new
	end

	def edit
		@game = Game.find(params[:id])
		if @game.user.id != current_user.id
			redirect_to games_path
		end
	end

	def create
		@game = Game.new(game_params)
		@game.user_id = current_user.id

		region = 'ap-northeast-1'
	    bucket = ENV['S3_BUCKET_NAME'] # S3バケット名
	    client = Aws::S3::Client.new(region: region)

	    upload_file = game_params[:file]
	    key = "games/" + upload_file.original_filename	#S3のファイル名

	    client.put_object(bucket: bucket, key: key, body: upload_file.read)

	    @game.file_name = upload_file.original_filename
		if @game.save
			flash[:notice] = "アップロードが完了しました"
			redirect_to game_path(@game)
		else
			render 'new'
		end
	end

	def update
		@game = Game.find(params[:id])
		file_name = @game.file_name
		if @game.update(game_params)
			if game_params[:file].present?
				region = 'ap-northeast-1'
				bucket = ENV['S3_BUCKET_NAME']
				client = Aws::S3::Client.new(region: region)
				file_path = "games/" + file_name
				client.delete_object(bucket: bucket, key: file_path)		#元々のファイル削除

				upload_file = game_params[:file]
		    	key = "games/" + upload_file.original_filename
		    	client.put_object(bucket: bucket, key: key, body: upload_file.read)		#編集したファイル追加

		    	@game.file_name = upload_file.original_filename
		    	@game.save
	    	end

			flash[:notice] = "変更を保存しました"
			redirect_to game_path(@game)
		else
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
		redirect_to root_path
	end

	def more_game
		if params[:place] == "user"
			@games = Game.where(user_id: params[:id_user]).page(params[:page]).per(9)
			@user = User.find(params[:id_user])
		end
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
		params.require(:game).permit(:title, :introduction, :file, :tag_list, screenshots_attributes: [:id, :game_id, :image, :_destroy])
	end

end
