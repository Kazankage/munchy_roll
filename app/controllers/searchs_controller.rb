class SearchsController < ApplicationController

    def index
        @user_id = Manga.popuser
        @user = User.find(@user_id)
        #  @user = Manga.popuser
    end

end
