class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?

	def after_sign_in_path_for(resource)
		case resource
		when Admin
			 admins_top_path
		when User
			 root_path
		end
	end

	def after_sign_out_path_for(resource)
		if resource == :admin
      		new_admin_session_path
    	elsif  resource == :user
      		root_path
    	end
	end

	#renderer.renderの代替メソッド(Devise使用時は必要)
	def self.render_with_signed_in_user(user, *args)
	   ActionController::Renderer::RACK_KEY_TRANSLATION['warden'] ||= 'warden'
	   proxy = Warden::Proxy.new({}, Warden::Manager.new({})).tap{|i| i.set_user(user, scope: :user) }
	   renderer = self.renderer.new('warden' => proxy)
	   renderer.render(*args)
	 end

	protected
	def configure_permitted_parameters
	  devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :introduction, :image])
	end
end
