class ReviewsController < ApplicationController

    def new
        if  @manga = Manga.find_by_id(params[:manga_id])
            @review = @manga.reviews.build
        else
            @review = Review.new
        end

    end

    def index
        if  @manga = Manga.find_by_id(params[:manga_id])
            @reviews = @manga.reviews
        else
            @reviews = Review.popularity
        end
        # @mangas = Manga.find(params[:manga_id]).series
    end

    def create
        @review = current_user.reviews.build(review_params)
        if @review.save
            redirect_to review_path(@review)
        else
        render :new
        end
    end

    def show
       @review = Review.find_by_id(params[:id])
    end

    def edit
        @review = Review.find(params[:id])
    end

    def update   
        @review = Review.find(params[:id])
            if current_user == @review.user
                @review.update(review_params)
                redirect_to review_path
            else
            flash[:error] = "Baka! You may only edit your own reviews!"
            render :edit
        end
    end   

    def destroy
        @review = Review.find(params[:id])
        if current_user == @review.user
        @review.destroy
        else
        flash[:error] = "Baka! You may only delete your own reviews!"
        redirect_to new_review_path
        end
    end

    private

    def review_params
        params.require(:review).permit(:manga_id, :search, :summary, :publishers, :rating, :title)
    end
end