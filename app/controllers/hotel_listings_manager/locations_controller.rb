class HotelListingsManager::LocationsController < ApplicationController
  before_action :set_location, only: [:new, :create]
  include LoggedInRestrictions
  include AdminRestrictions

  def new
    @location = Location.new
  end

  def index
    store_last_page
    # @locations = Location.all
    @locations = Location.paginate(page: params[:page]).per_page(10)
  end


  def show
    @location = Location.find(params[:id])
  end

  def create
    if params[:location][:image] != nil
      @location = Location.new(params.require(:location).permit(:name, :city, :address, :country))
      if @location.save
          # Upload the image to Cloudinary
          response = Cloudinary::Uploader.upload(params[:location][:image])
          # Create a new Photo record and store the link
          @photo = Photo.new(link: response['secure_url'])
          @photo.save
          puts @photo
          puts "photo available above"
          puts @location
          puts "location available above"
        if @photo.present?
          @location_photo = LocationPhoto.new(location_id: @location.id, photo_id: @photo.id)
          if @location_photo.save
            flash[:success] = "Location successfully created"
            redirect_to retrieve_last_page_or_default
          else
            flash[:danger] = "Failed to save location"
            render :new
          end
        else
          flash[:danger] = "Failed to save location"
          render :new
        end
      else
        flash[:danger] = "Failed to save location"
        render :new
      end
    else
      flash[:danger] = "Image is empty"
      redirect_to new_hotel_listings_manager_location_path
    end
  end

  def edit
    @location = Location.find(params[:id])
  end

  def extract_public_id_from_cloudinary_photo_link(url)
    match = url.match(/(?<=\/)([^\/]+?)(?=\.(jpg|jpeg|png|webp|JPG|JPEG|PNG)\z)/)
    match ? match[1] : nil
  end

  def update
    @location = Location.find(params[:id])
    puts @location.id
    puts @location.photo.id

    if params[:location][:image] != nil
      # if image is new, upload phohto
        response = Cloudinary::Uploader.upload(params[:location][:image])
        puts response
        puts "70"
        # Create a new Photo record and store the link
        @photo = Photo.new(link: response['secure_url'])
        puts @photo
        puts "74"
        @photo.save
        puts @photo.save
        puts "77"
        current_photo = Photo.find_by(id: @location.photo.id)
        puts current_photo
        puts "87"

        # update LocationPhoto
        puts @location.id
        puts "81"
        puts @location.photo.id
        puts "83"
        current_location_photo = LocationPhoto.find_by(location_id: @location.id, photo_id: @location.photo.id)
        puts current_location_photo
        puts "86"
        current_location_photo.update(location_id: @location.id, photo_id: @photo.id)
        puts current_location_photo
        puts "89"


        # destroy first in cloudinary
        # Extract public ID from the URL
        puts @location.photo.link
        puts "104 ATTENTION"
        public_id = extract_public_id_from_cloudinary_photo_link(@location.photo.link)
        puts public_id
        puts "106 ATTENTION"

        # Delete photo from cloudinary
        Cloudinary::Uploader.destroy(public_id)
        puts Cloudinary::Uploader.destroy(public_id)
        puts "108"

        # delete photo id if image is new
        puts current_photo
        puts "before destroy photo"
        current_photo.destroy
        puts "after destroy photo"
        # puts current_photo.destroy
        # puts "116"

    end

    if @location.update(params.require(:location).permit(:name, :city, :address, :country))
      redirect_to retrieve_last_page_or_default
      flash[:success] = "Location type was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @location = Location.find(params[:id])

    # destory cloudinary record
    public_id = extract_public_id_from_cloudinary_photo_link(@location.photo.link)

    # Delete photo from cloudinary
    Cloudinary::Uploader.destroy(public_id)

    # destroy photo record
    current_photo = Photo.find_by(id: @location.photo.id)
    current_photo.destroy


    # destroy location and location_photo record
    @location.destroy
    redirect_to retrieve_last_page_or_default
    flash[:success] = "Location type was successfully destroyed."
  end

private

def set_location

  @location = Location.new

end

end
