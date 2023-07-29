class WelcomeController < ApplicationController
  def hello
    render json: { msg: "Hello #{params[:name]}" }
  end
end
