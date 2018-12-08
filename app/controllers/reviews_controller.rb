class ReviewsController < ApplicationController

    def create
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
        review = Review.new ({
            product_id: params[:product_id],
            user_id: @current_user.id,
            description: review_params['description'],
            rating: review_params['rating']
        })
        
        review.save
        byebug
    end

    private

    def review_params
        params.require(:review).permit(:rating, :description)
    end

end
