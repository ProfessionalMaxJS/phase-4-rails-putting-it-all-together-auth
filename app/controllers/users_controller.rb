class UsersController < ApplicationController
   
    def index
        render json: User.all, status: :ok
    end

    def create
        new_user = User.create!(user_params)
        session[:user_id] = new_user.id
        render json: new_user, status: :created
    end

    def show
        # user = User.find(session[:user_id])
        if session[:user_id]
            user = User.find(session[:user_id])
            render json: user, status: :created
        else
            render json: { error: "Not authorized" }, status: :unauthorized
        end
    end

    private

    def user_params
        params.permit(:username, :password, :password_confirmation, :image_url, :bio)
    end
    
end
