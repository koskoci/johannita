class ImagesController < ApplicationController

  # POST /embedded_image
  def create_embedded
    authorize!

    image = current_user.images.attach(params[:image]).first

    if image
      render status: 201, json: { url: url_for(image) }
    else
      render status: 400, json: { error: current_user.errors }
    end
  end

  # POST /thumbnail
  def create_thumbnail
    authorize!

    image = current_user.images.attach(params[:image]).first
    thumbnail = image.variant(resize: '100x100').processed

    if thumbnail
      render status: 201, json: { url: url_for(thumbnail) }
    else
      render status: 400, json: { error: current_user.errors }
    end
  end
end
