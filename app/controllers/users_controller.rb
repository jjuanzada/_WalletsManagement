class UsersController < ApplicationController
  before_action :authenticate_employee!
  before_action :set_user, only: %i[ show edit update destroy ]

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params_with_formatted_cpf)

    respond_to do |format|
      if @user.save
        format.html { redirect_to user_url(@user), notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params_with_formatted_cpf)
        format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def extract
    @user = User.find(params[:id])
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params_with_formatted_cpf
      # Format CPF before create or update user
      params[:user][:cpf] = format_cpf(params[:user][:cpf])
      params.require(:user).permit(:first_name, :last_name, :email, :phone, :current_balance, :cpf)
    end
  
    def format_cpf(cpf)
      # Remove non-numeric characters from CPF
      cpf = cpf.gsub(/\D/, '')
  
      # Format CPF xxx.xxx.xxx-xx
      cpf = "#{cpf[0..2]}.#{cpf[3..5]}.#{cpf[6..8]}-#{cpf[9..10]}"
    end

end
