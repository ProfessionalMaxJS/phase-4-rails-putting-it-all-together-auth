class SessionsController < ApplicationController

def create
    # byebug
    user = User.find_by(username: params[:username])
    if user&.authenticate(params[:password])
        session[:user_id] = user.id
        render json: user, status: :created
    else
        render json: { error: "invalid username or password" }, status: :unauthorized
    end
end

def destroy
    # user = User.find(session[:user_id]) 
    if session[:user_id]
        session.delete :user_id
        render json: {}, status: :no_content
    else
        render json: { error: "Not authorized" }, status: :unauthorized
    end
end

end
