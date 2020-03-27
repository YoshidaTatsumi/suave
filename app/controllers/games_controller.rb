class GamesController < ApplicationController
	before_action :authenticate_user!, except: [:index, :show, :more_game, :download]

	def index
		games = Game.all
		@random = Game.offset(rand(games.count)).limit(1)
		@index_games = Game.offset(rand(games.count)).limit(10)
		@new_games = games.order(created_at: :desc).page(params[:new_game]).per(8)
		@favorite_games = games.where.not(rating: nil).order(rating: :desc).page(params[:favorite_game]).per(8)
		@difficult_games = games.where.not(difficulty: nil).order(difficulty: :desc).page(params[:difficult_game]).per(8)
		@easy_games = games.where.not(difficulty: nil).order(difficulty: :asc).page(params[:easy_game]).per(8)

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
		@random = Game.offset(rand(Game.all.count)).limit(1)
		@comment = Comment.new
		if params[:place] == "notifications"
			notification = Notification.find(params[:notification])
			notification.update_attributes(checked: true)
		end
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

		if game_params[:file].present?	#ファイルが選択されているか？
			region = 'ap-northeast-1'
		    bucket = ENV['S3_BUCKET_NAME'] # S3バケット名
		    client = Aws::S3::Client.new(region: region)

		    upload_file = game_params[:file]
		    key = "games/" + upload_file.original_filename	#S3のファイル名

		    saved_s3_game = Game.find_by(file_name: upload_file.original_filename)

		    if saved_s3_game.present?	#同じファイル名がある場合。S3に同じファイル名で保存されるのを防ぐ為。
		    	flash[:danger] ="同じファイル名のゲームがあります。ファイル名を変更してアップロードしてください。"
		    	render 'new'
		    else
			    @game.file_name = upload_file.original_filename
				if @game.save
					client.put_object(bucket: bucket, key: key, body: upload_file.read)		#S3へアップロード
					flash[:notice] = "アップロードが完了しました"
					redirect_to game_path(@game)
				else
					flash[:danger] ="入力ミスがあります"
					render 'new'
				end
			end
		else
			flash[:danger] ="ゲームファイルを選択してください"
			render 'new'
		end
	end

	def update
		@game = Game.find(params[:id])
		file_name = @game.file_name
		if @game.update(game_params)
			if game_params[:file].present?		#ゲームファイルがある場合
				upload_file = game_params[:file]
				saved_s3_game = Game.find_by(file_name: upload_file.original_filename)

			    if saved_s3_game.present?	#同じファイル名のゲームがある場合。S3に同じファイル名で保存されるのを防ぐ為。
			    	flash[:danger] ="同じファイル名のゲームがあります。ファイル名を変更してアップロードしてください。"
			    	render 'new'
			    else
					region = 'ap-northeast-1'
					bucket = ENV['S3_BUCKET_NAME']
					client = Aws::S3::Client.new(region: region)
					file_path = "games/" + file_name
					client.delete_object(bucket: bucket, key: file_path)		#元々のファイル削除

			    	key = "games/" + upload_file.original_filename
			    	client.put_object(bucket: bucket, key: key, body: upload_file.read)		#編集したファイル追加

			    	@game.file_name = upload_file.original_filename
			    	@game.save

			    	flash[:notice] = "変更を保存しました"
					redirect_to game_path(@game)
			    end
			else
				flash[:notice] = "変更を保存しました"
				redirect_to game_path(@game)
			end
		else
			flash[:danger] ="入力ミスがあります"
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
		if params[:place] == "user" && params[:id_user].present?
			@games = Game.where(user_id: params[:id_user]).order(created_at: :desc).page(params[:page]).per(9)
			@user = User.find(params[:id_user])
		else
			redirect_to games_path
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
