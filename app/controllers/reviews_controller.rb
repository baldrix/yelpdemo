class ReviewsController < ApplicationController
  before_action :set_review, only: [:edit, :update, :destroy]
  before_action :set_restaurant
  before_action :authenticate_user!
  before_action :check_user,only: [:edit,:update,:destroy]
  respond_to :html


  def new
    @review = Review.new
    respond_with(@review)
  end

  def edit
  end

  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    @review.restaurant_id = @restaurant.id

    respond_with do |format|
    if @review.save
      #format.html {redirect_to restaurant_path(@restaurant), notice:"Review successfully saved"}
      #this is a shortcut to go to restaurant show page this is infered by rails
      format.html {redirect_to @restaurant, notice:"Review successfully saved"}
    else
      format.html {render :new}
    end
  end
   # respond_with(@review)
  end

  def update
    @review.update(review_params)
    respond_with(@review)
  end

  def destroy
    @review.destroy
    respond_to do |format|
    format.html { redirect_to restaurant_path(@restaurant), notice: 'Review was successfully destroyed.' }
    format.json { head :no_content }
  end
  end

  private
    def set_review
      @review = Review.find(params[:id])
    end

    def set_restaurant
      @restaurant = Restaurant.find(params[:restaurant_id])
    end

    def check_user
      unless (@review.user == current_user) || (current_user.admin?)
        redirect_to root_url,alert:"sorry this review belongs to someone else"
      end
    end

    def review_params
      params.require(:review).permit(:rating, :comment)
    end
end
