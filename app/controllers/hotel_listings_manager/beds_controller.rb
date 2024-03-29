class HotelListingsManager::BedsController < ApplicationController
  include LoggedInRestrictions
  include AdminRestrictions

  def index
    store_last_page
    # @beds = Bed.all
    @beds = Bed.paginate(page: params[:page]).per_page(10)
  end


  def show
    @bed = Bed.find(params[:id])
  end

  def create
    @bed = Bed.new(params.require(:bed).permit(:name, :length, :width))
    if @bed.save
      redirect_to retrieve_last_page_or_default
      flash[:success] = "Bed type was successfully created."
    else
      @errors = @bed.errors.full_messages
      render :new
    end
  end

  def new
    @bed = Bed.new
  end

  def edit
    @bed = Bed.find(params[:id])
  end

  def update
    @bed = Bed.find(params[:id])
    if @bed.update(params.require(:bed).permit(:name, :length, :width))
      redirect_to retrieve_last_page_or_default
      flash[:success] = "Bed type was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @bed = Bed.find(params[:id])
    @bed.destroy
    redirect_to retrieve_last_page_or_default
    flash[:success] = "Bed type was successfully destroyed."
  end
end
