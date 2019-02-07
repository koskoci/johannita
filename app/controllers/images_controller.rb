class ImagesController < ApplicationController

  # POST /images
  def create
    authorize!

    image = current_user.images.attach(params[:image]).first

    if image
      render status: 201, json: { url: url_for(image) }
    else
      render status: 400, json: { error: current_user.errors }
    end
  end

  # POST /embedded_images
  def create_embedded
    authorize!

    image = current_user.images.attach(params[:image]).first
    processed = image.variant(resize: '800').processed

    if image
      render status: 201, json: { url: url_for(processed) }
    else
      render status: 400, json: { error: current_user.errors }
    end
  end

  # POST /thumbnails
  def create_thumbnail
    authorize!

    image = current_user.images.attach(params[:image]).first
    thumbnail = image.variant(thumbnail: '100x100').processed

    if thumbnail
      render status: 201, json: { url: url_for(thumbnail) }
    else
      render status: 400, json: { error: current_user.errors }
    end
  end
end
