class UserProjectsController < ApplicationController

    def create
        @user = User.find(params[:user])
        @project = Project.find(params[:project])
        @user_project = UserProject.create(user: @user, project: @project)
        flash[:success] = "User is Assigned successfully "
        redirect_to project_path(@project)
    end


    def destroy_association
        @user = User.find(params[:user].to_i)
        @project = Project.find(params[:project].to_i)
        @user_project = UserProject.where(user_id: @user.id, project_id: @project.id).first
        @user_project.destroy
        flash[:success] = "User is removed from this project successfully"
        redirect_to project_path(@project)
    end
       
end
