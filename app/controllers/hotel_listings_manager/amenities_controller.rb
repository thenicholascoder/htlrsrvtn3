class HotelListingsManager::AmenitiesController < ApplicationController
  include LoggedInRestrictions
  include AdminRestrictions

  def new
    @amenity = Amenity.new
  end

  def index
    store_last_page
    # @amenities = Amenity.all
    @amenities = Amenity.paginate(page: params[:page]).per_page(10)
  end


  def show
    @amenity = Amenity.find(params[:id])
  end

  def create
    # check if form image is not nil
    if params[:amenity][:image] != nil
      @amenity = Amenity.new(params.require(:amenity).permit(:name))
      puts @amenity
      puts "25"
      # Upload the image to Cloudinary
      response = Cloudinary::Uploader.upload(params[:amenity][:image])
      puts response
      puts "29"
      # Create a new Photo record and store the link
      @photo = Photo.new(link: response['secure_url'])
      puts @photo
      puts "33"
      @photo.save
      puts @photo.save
      puts "36"
      puts @photo.id
      puts "38"
      @amenity.photo_id = @photo.id
      puts @amenity.photo_id
      puts "41"
      if @amenity.save
        flash[:success] = "Amenity successfully created"
        redirect_to retrieve_last_page_or_default
      else
        flash[:danger] = "Failed to save amenity"
        render :new
      end
    else
      flash[:danger] = "Image is empty"
      redirect_to new_hotel_listings_manager_amenity_path
    end
  end

  def edit
    @amenity = Amenity.find(params[:id])
  end

  def extract_public_id_from_cloudinary_photo_link(url)
    match = url.match(/(?<=\/)([^\/]+?)(?=\.(jpg|jpeg|png|webp|JPG|JPEG|PNG)\z)/)
    match ? match[1] : nil
  end

  def update
    @amenity = Amenity.find(params[:id])

    if params[:amenity][:image] != nil
      response = Cloudinary::Uploader.upload(params[:amenity][:image])

    #   # Create a new Photo record and store the link
      photo = Photo.new(link: response['secure_url'])
      photo.save
      puts "photo id is  #{photo.id} and photo link is #{photo.link}"



      old_photo_id = Photo.find_by(id: @amenity.photo_id).id
      old_photo_link = Photo.find_by(id: @amenity.photo_id).link

      public_id = extract_public_id_from_cloudinary_photo_link(old_photo_link)

    #   # Delete photo from cloudinary
      Cloudinary::Uploader.destroy(public_id)

      # old_photo.destroy
      @amenity.photo_id = photo.id


      if @amenity.update(params.require(:amenity).permit(:name))
        redirect_to retrieve_last_page_or_default
        flash[:success] = "Amenity type was successfully updated."
      else
        render :edit
      end
    end
  end

  def destroy
    @amenity = Amenity.find(params[:id])

    # destory cloudinary record
    public_id = extract_public_id_from_cloudinary_photo_link(@amenity.photo.link)

    # Delete photo from cloudinary
    Cloudinary::Uploader.destroy(public_id)

    # destroy photo record
    current_photo = Photo.find_by(id: @amenity.photo.id)
    current_photo.destroy


    # destroy location and location_photo record
    @amenity.destroy
    redirect_to retrieve_last_page_or_default
    flash[:success] = "Amenity type was successfully destroyed."
  end

  private

  def set_location

  @amenity = Amenity.new

end

end
