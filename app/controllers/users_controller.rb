class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    render plain: User.all.map { |u| u.to_s }.join("\n")
  end

  def show
    user = User.find(params[:id])
    render plain: user.to_s
  end

  def create
    u = User.create!(
      name: params[:name],
      email: params[:email],
      password: params[:password],
    )
    render plain: "User Created Successfully.. #{u.id}"
  end
end
