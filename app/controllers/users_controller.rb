class UsersController < ApplicationController
    
    helper_method :is_already_added

    def search
        @user = User.search(params[:user])
        @project_id = params[:project_id]
        
        if params[:user].present?
            @users = User.search(params[:user])  
            if @users.length > 0
                render partial: 'users/search'
            else
                flash.now[:danger] = "No record found"
                render partial: 'users/search'
            end
             
        else
            flash.now[:danger] = "Please enter user name or email"
            render partial: 'users/search'
        end
            
    end

    def is_already_added (email , project)
        @user1 = User.where(email: email).first
        @user_project = UserProject.where(user_id: @user1, project_id: project).first
        
    end

    
end