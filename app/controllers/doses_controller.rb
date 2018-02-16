class DosesController < ApplicationController
  def new
    # we need @cocktail in our `simple_form_for`
    @cocktail = Cocktail.find(params[:cocktail_id])
    @ingredients = Ingredient.all
    @dose = Dose.new(cocktail: @cocktail)
  end

  def create
    # we need `cocktail_id` to asssociate dose with corresponding cocktail
    # raise
    @dose = Dose.new
    @dose.description = dose_params[:description]
    @dose.cocktail = Cocktail.find(params[:cocktail_id])
    # raise
    begin
      @dose.ingredient = Ingredient.find(dose_params[:ingredient_id])
    rescue
      @dose.ingredient = Ingredient.where(id: dose_params[:ingredient_id]).first.try(:id)
    end

    if @dose.save
      redirect_to cocktail_path(@dose.cocktail.id)
    else
      render :new
    end
  end

  def destroy
    @dose = Dose.find(params[:id])
    @cocktail = @dose.cocktail
    @dose.delete
    redirect_to cocktail_path(@cocktail)
  end

  def dose_params
    params.require(:dose).permit([:description, :ingredient_id])
  end

end
