class UsersController < ApplicationController
    
    def search
        
        @users = User.search(params[:search_param])  
        render partial: 'users/search'
            
    end
end