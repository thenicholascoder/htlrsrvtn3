class HotelListingsManager::PhotosController < ApplicationController
  include LoggedInRestrictions
  include AdminRestrictions

  def index
    store_last_page
    # @photos = Photo.all
    @photos = Photo.paginate(page: params[:page]).per_page(10)
  end

  def show
    @photo = Photo.find(params[:id])
  end

  def create
    params[:photo][:images].each do |image|
      next unless image.is_a?(ActionDispatch::Http::UploadedFile)
      cloudinary_upload = Cloudinary::Uploader.upload(image.tempfile, folder: "your_folder_name")
      Photo.create(link: cloudinary_upload['secure_url'])
    end
      redirect_to retrieve_last_page_or_default
      flash[:success] = 'Photo was successfully uploaded.'
  end

  def new
    @photo = Photo.new
  end

  def edit
    @photo = Photo.find(params[:id])
  end

  def extract_public_id_from_cloudinary_photo_link(url)
    match = url.match(/(?<=\/)([^\/]+?)(?=\.(jpg|jpeg|png|webp|JPG|JPEG|PNG)\z)/)
    match ? match[1] : nil
  end

  def update
    @photo = Photo.find(params[:id])

    # Extract public ID from the URL
    public_id = extract_public_id_from_cloudinary_photo_link(@photo.link)

    # Delete photo from cloudinary
    Cloudinary::Uploader.destroy(public_id)

    # Assuming you're using Cloudinary to upload the photo
    uploaded_file = params[:photo][:image]

    # Upload image to Cloudinary
    response = Cloudinary::Uploader.upload(uploaded_file)


    if @photo.update(link: response['secure_url'])
      redirect_to retrieve_last_page_or_default
      flash[:success] = 'Photo was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @photo = Photo.find(params[:id])

    # Extract public ID from the URL
    public_id = extract_public_id_from_cloudinary_photo_link(@photo.link)

    # Delete photo from cloudinary
    Cloudinary::Uploader.destroy(public_id)

    @photo.destroy

    redirect_to retrieve_last_page_or_default
    flash[:success] = "Photo was successfully destroyed."
  end
end
