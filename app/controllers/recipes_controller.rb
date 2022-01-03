class RecipesController < ApplicationController

    before_action :userify

def index
    if session[:user_id]
        # byebug
        # user = User.find(session[:user_id])
        render json: @user.recipes, status: :created
    else
        render json: {error: "not authorized"}, status: :unauthorized
    end
end

def create
    if session[:user_id]
        # byebug
        new_recipe = @user.recipes.create!(recipe_params)
        render json: new_recipe, status: :created
    else
        render json: {error: "not authorized"}, status: :unauthorized
    end
end

private

def userify
    if session[:user_id]
        @user = User.find(session[:user_id])
    end
end

def recipe_params
    params.permit(:title, :instructions, :minutes_to_complete)
end

end