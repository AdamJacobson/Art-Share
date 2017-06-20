class ArtworksController < ApplicationController

  def index
    artwork = Artwork.all
    render json: artwork
  end

  def create
    artwork = Artwork.new(artwork_params)
    if artwork.save
      render json: artwork
    else
      render(
        json: artwork.errors.full_messages, status: :unprocessable_entity # 422
      )
    end
  end

  def show
    artwork = current_artwork
    if artwork
      render json: current_artwork
    else
      render json: "Could not find artwork"
    end
  end

  def update
    artwork = current_artwork
    if artwork
      artwork.update(artwork_params)
      render json: current_artwork
    else
      render json: user.errors.full_messages, status: 422
    end
  end

  def destroy
    artwork = current_artwork
    if artwork
      artwork.destroy
      render json: artwork
    else
      render json: "Could not find artwork"
    end
  end

  private

  def current_artwork
    Artwork.find_by(id: params[:id])
  end

  def artwork_params
    params.require(:artwork).permit(:image_url, :title, :artist_id)
  end

end
