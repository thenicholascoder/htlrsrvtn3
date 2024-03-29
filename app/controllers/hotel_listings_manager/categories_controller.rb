class HotelListingsManager::CategoriesController < ApplicationController
  include LoggedInRestrictions
  include AdminRestrictions

  def index
    store_last_page
    # @categories = Category.all
    @categories = Category.paginate(page: params[:page]).per_page(10)
  end

  def create
    @category = Category.new(params.require(:category).permit(:name))
    if @category.save
      redirect_to retrieve_last_page_or_default
      flash[:success] = "Category was successfully created."
    else
      @errors = @category.errors.full_messages
      render :new
    end
  end

  def new
    @category = Category.new
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(params.require(:category).permit(:name))
      redirect_to retrieve_last_page_or_default
      flash[:success] = "Category was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to retrieve_last_page_or_default
    flash[:success] = "Category was successfully destroyed."
  end
end
