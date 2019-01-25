class ImagesController < ApplicationController
  # POST /images
  def create
    authorize!

    image = current_user.images.attach(params[:image])

    if image
      render status: 201, json: { url: url_for(image) }
    else
      render status: 400, json: { error: current_user.errors }
    end
  end
end
