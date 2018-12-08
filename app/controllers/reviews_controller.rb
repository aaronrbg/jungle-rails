class ReviewsController < ApplicationController

    before_filter :authorize

    def create
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
        review = Review.new ({
            product_id: params[:product_id],
            user_id: @current_user.id,
            description: review_params['description'],
            rating: review_params['rating']
        })
        
        review.save
        redirect_to "/products/#{params[:product_id]}"
    end

    def destroy
        @review = Review.find params[:id]
        @review.destroy
        redirect_to "/products/#{params[:product_id]}"
    end

    private

    def review_params
        params.require(:review).permit(:rating, :description, :id)
    end

end
