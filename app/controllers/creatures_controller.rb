class CreaturesController < ApplicationController
  def index
    @creatures = Creature.all
  end

  def create
    # render plain: params[:creature].inspect
    Creature.create creature_params
    redirect_to creatures_path
  end

  def new
    @creature = Creature.new
  end

  def edit
    @creature = Creature.find params[:id]
  end

  def show
    @creature = Creature.find params[:id]
    if @creature.nil?
      @creatures = Creature.all
      flash.now[:alert] = "Your bog was not found"
      render "index"
    end
    # render json: params
  end

  def update
    @creature = Creature.find params[:id]
    if @creature.update creature_params
      redirect_to creatures_path
    else 
      render :edit
    end
  end

  def destroy
    Creature.find(params[:id]).delete #or destroy
    # flash[:success] = "User deleted"
    redirect_to creatures_path
  end

  private

  def creature_params
    params.require(:creature).permit(:name, :description)
  end
end
