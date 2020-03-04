class ScreenshotsController < ApplicationController
	def destroy
		screenshot = Screenshot.find(params[:id])
		screenshot.destroy
		redirect_to request.referer
	end
end
