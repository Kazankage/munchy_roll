class MangasController < ApplicationController
    def new

        @manga = Manga.new
        @manga.build_genre
    end

    def create
        @manga = Manga.new(manga_params)
        @manga.user_id = session[:user_id]
      
        @genre = Genre.all
            if @manga.save
                @manga.picture.purge
                @manga.picture.attach(params[:manga][:picture])
                redirect_to manga_path(@manga)
            else
               #flash[:error] = "Baka! Try again!"
               render :new

            end
    end

    def index
     @mangas = Manga.alphabetical_order
    
    end

    def show
        @user = User.find_by(params[:id])  
        @manga = Manga.find(params[:id])

    end

    def edit
        @manga = Manga.find(params[:id])
    end


    def update   
        @manga = Manga.find(params[:id])
            if @manga.user == current_user 
                @manga.update(manga_params)
                redirect_to manga_path
            else
                flash[:error] = "Baka! You may only edit your own manga!"
                render :edit
            end
    end   

    def destroy
        @manga = Manga.find(params[:id])
            if  @manga.user == current_user
                @manga.destroy
                redirect_to mangas_path
            else
                flash[:error] = "Baka! You may only delete your own manga!"
                redirect_to new_manga_path
                #, method: :get

    
            end
    end

  

    private

    def manga_params
        params.require(:manga).permit(:series, :search, :description, :link, :genre_id, :publishers, :picture, genre_attributes: [:name])
    end

end