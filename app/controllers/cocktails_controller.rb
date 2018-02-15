class CocktailsController < ApplicationController
  def index
    @cocktails = Cocktail.all
  end

  def show
    @cocktail = Cocktail.find(params[:id])
  end

  def new
    @cocktail = Cocktail.new
  end

  def create
    begin
      @cocktail = Cocktail.create(cocktail_params)
      redirect_to cocktail_path(@cocktail)
    rescue
      redirect_to new_cocktail_path
    end
  end

  def cocktail_params
    params.require(:cocktail).permit(:name)
  end
end
