class HotelListingsManager::RoomsController < ApplicationController
  include LoggedInRestrictions
  include AdminRestrictions
  attr_accessor :amenity_ids

  def index
    store_last_page
    # @rooms = Room.all
    @rooms = Room.paginate(page: params[:page]).per_page(10)
  end

  def show
    @room = Room.find(params[:id])
  end

  def create
    @room = Room.new(params.require(:room).permit(:name, :desc, :section_name, :section_title, :section_desc, :suite_size, :max_guests, :bedroom_count, :price, :location_id, :category_id, amenity_ids: []))
    photo_id_array = []

    params[:room][:images].each do |image|
      next unless image.is_a?(ActionDispatch::Http::UploadedFile)
      cloudinary_upload = Cloudinary::Uploader.upload(image.tempfile, folder: "your_folder_name")
      photo = Photo.create(link: cloudinary_upload['secure_url'])
      photo_id_array.push(photo.id)
    end

    if @room.save
      beds = Bed.all
      beds.each do |bed|
        new_room_bed = RoomBed.new(room_id: @room.id, bed_id: bed.id, count: 0)
        new_room_bed.save
      end

      photo_id_array.each do |photo_id|
        room_photo = RoomPhoto.new(room_id: @room.id, photo_id: photo_id)
        room_photo.save
      end

      if params[:room][:amenity_ids].present?
        params[:room][:amenity_ids].each do |amenity_id|
          new_room_amenity = RoomAmenity.new(amenity_id: amenity_id, room_id: @room.id)
          # new_room_amenity.save
        end
      end

      redirect_to retrieve_last_page_or_default
      flash[:success] = "Room was successfully created."
    else
      @errors = @room.errors.full_messages
      render :new
    end
  end

  def new
    @room = Room.new
    @categories = Category.all
    @locations = Location.all
    @amenities = Amenity.all
    @beds = Bed.all
  end

  def edit
    @room = Room.find(params[:id])
    @categories = Category.all
    @locations = Location.all
    @roombeds = RoomBed.all
    @amenities = Amenity.all
    @room_amenities = RoomAmenity.where(room_id: params[:id])
    @room_amenity_ids = @room_amenities.pluck(:amenity_id)
    @room_photos = RoomPhoto.where(room_id: params[:id])
  end

  def extract_public_id_from_cloudinary_photo_link(url)
    match = url.match(/(?<=\/)([^\/]+?)(?=\.(jpg|jpeg|png|webp|JPG|JPEG|PNG)\z)/)
    match ? match[1] : nil
  end

  def update
    @room = Room.find(params[:id])

    bed_ids_from_form_edit = []

    params[:room].select { |key, _| key.start_with?("bed_id:") }.each do |key, value|
      bed_ids_from_form_edit << "#{key.split(":")[1]}:#{value}"
    end

    bed_ids_from_form_edit.each do |bed_id|
      id, number = bed_id.split(':')
      room_bed_instance = RoomBed.where(room_id: @room.id, bed_id: id)
      room_bed_instance.update(room_id: @room.id, bed_id: id, count: number)
    end

    if params[:room][:amenity_ids].present?
      amenity_ids = params[:room][:amenity_ids].reject { |id| id == "true" }
      RoomAmenity.where(room_id: @room.id).where.not(amenity_id: amenity_ids).destroy_all
      existing_room_amenities = RoomAmenity.where(room_id: @room.id).where(amenity_id: amenity_ids)
      amenity_ids.each do |amenity_id|
        if existing_room_amenities.where(amenity_id: amenity_id).empty?
          new_room_amenity = RoomAmenity.create(room_id: @room.id, amenity_id: amenity_id)
          new_room_amenity.save
        end
      end
    else
      RoomAmenity.where(room_id: @room.id).delete_all
    end

    unless params[:room][:images]==[""]
      # delete current room photos
        room_photos = RoomPhoto.where(room_id: @room.id)
        room_photos.each do |room_photo|
        room_photo.photo_id
        public_id = extract_public_id_from_cloudinary_photo_link(room_photo.photo.link)

        # Delete photo from cloudinary
        Cloudinary::Uploader.destroy(public_id)

        # destroy photo record
        current_photo = Photo.find_by(id: room_photo.photo_id)
        current_photo.destroy
      end

        photo_id_array = []

      # add new photos
        params[:room][:images].each do |image|
        next unless image.is_a?(ActionDispatch::Http::UploadedFile)
        cloudinary_upload = Cloudinary::Uploader.upload(image.tempfile, folder: "your_folder_name")
        photo = Photo.create(link: cloudinary_upload['secure_url'])
        photo_id_array.push(photo.id)
      end

        photo_id_array.each do |photo_id|
        room_photo = RoomPhoto.new(room_id: @room.id, photo_id: photo_id)
        room_photo.save
      end
    end

    if @room.update(params.require(:room).permit(:name, :desc, :section_name, :section_title, :section_desc, :suite_size, :max_guests, :bedroom_count, :price, :category_id, :location_id))
      redirect_to retrieve_last_page_or_default
      flash[:success] = "Room was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @room = Room.find(params[:id])

    room_photos = RoomPhoto.where(room_id: @room.id)
    room_photos.each do |room_photo|
      room_photo.photo_id
      public_id = extract_public_id_from_cloudinary_photo_link(room_photo.photo.link)

      # Delete photo from cloudinary
      Cloudinary::Uploader.destroy(public_id)

      # destroy photo record
      current_photo = Photo.find_by(id: room_photo.photo_id)
      current_photo.destroy
    end

    @room.destroy

    redirect_to retrieve_last_page_or_default
    flash[:success] = "Room was successfully destroyed."
  end
end
