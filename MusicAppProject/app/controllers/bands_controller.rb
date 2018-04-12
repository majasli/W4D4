class BandsController < ApplicationController
  def index
    @bands = Band.all
    render :index
  end

  def new
    @band = Band.new
    render :new
  end

  def show
    @band = Band.find(params[:id])
    render :show
  end

  def edit
    @band = Band.find(params[:id])
    render :edit
  end

  def create
    @band = Band.new(band_params)

    if @band.save
      #redirect_to band_url(@band)
      redirect_to bands_url
    else
      flash.now[:errors] = @band.errors.full_messages
      render :new
    end
  end

  def update
    # find the band by looking for the params that are given to us via its :id
    @band = Band.find(params[:id])
    # if we find the band + we can call update_attributes on it with params
    # then goodie redirect to the bands 'show' page --> band_url(@band)
    if @band.update_attributes(band_params)
      #redirect_to band_url(@band)
      redirect_to bands_url 
    else
      flash.now[:errors] = @band.errors.full_messages
      render :edit
    end

  end

  def destroy
    @band = Band.find(params[:id])
    @band.destroy
    redirect_to bands_url
  end

  private
  def band_params
    params.require(:band).permit(:name)
  end

end
