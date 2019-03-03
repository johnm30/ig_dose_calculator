class CalculationsController < ApplicationController

  # Bring up the form and dummy variables. If unlogged user do not save as a
  # patient case
  def new
    create_inheritance_categories
    # In applications controller, this method will load from @settings from
    # current user.settings, or from session[:initial_probabilities] or create
    # default one afresh
    @settings = Hash.new

    # even if new, may have stored settings in current user, but default to session
    # if available

    if session[:relatives] != nil && !session[:relatives].empty?
      logger.debug "Taking relatives from session"
      @settings[:relatives] = session[:relatives]
      @settings[:age] = session[:age]
      @settings[:sex] = session[:sex]
      @settings[:penetrance] = session[:penetrance]
      @settings[:prevalence] = session[:prevalence]
      @settings[:consanguineous] = session[:consanguineous]
      @settings[:viable_homozygote] = session[:viable_homozygote]
      @settings[:males_worse] = session[:males_worse]
      @settings[:familial] = session[:familial]
    elsif current_user && current_user.settings != nil && current_user.settings[:relatives] != nil
      @settings = current_user.settings
      logger.debug "Taking relatives from current user"
    else
      @settings[:relatives] = Hash.new
    end

    # assign inheritance especially as it may just have changed by probability calculation
    if session[:inheritance] != nil
      @settings[:inheritance] = session[:inheritance]
    end
    logger.debug "Inheritance settings in calculations controller new action is: #{session[:inheritance]}"

    initial_frequencies_hash = create_initial_frequencies
    @settings[:initial_frequencies] = initial_frequencies_hash
    #logger.debug "Settings Initial probabilities is #{@settings[:initial_probabilities]}"
  end


  # When submit a form, calculates the probabilities, and renders show to
  # display the page with calculation. Then if press recalculate, it points to
  # create again not update, because the url is the same calculations_path
  def create
    if params[:commit] == "Reset"
      flash[:success] = "Cancelled calculation and reset values."
      if @patient_case != nil
        @patient_case.delete
      end
      reset_settings
      redirect_to root_path and return
    end

    # This is the main line that calls the patient_case_params method
    @settings = patient_case_params
    #logger.debug "Settings after running patient_case_params = #{@settings.inspect}"
    @results ||= Hash.new
    @results = @settings[:results]

    if current_user
      current_user.settings = @settings
      current_user.save
    end
    # try without a local model now, just use the hash instance

    create_inheritance_categories   #I am rendering show at the end of this so needed
    if @settings[:initial_frequencies] == nil
      @settings[:initial_frequencies] = create_initial_frequencies
    end

    sex_error = @settings[:sex_error]
    cousins_error = @settings[:cousins_error]
    males_worse_error = @settings[:males_worse_error]
    if @not_add_up != 0
      flash.now[:warning] = "Initial probabilities add up to #{@not_add_up}% not 100%."
      # renders the new view without actually doing the new action so does not reset
      # the values
      render 'new' and return
    elsif sex_error != nil && sex_error != ""
      flash.now[:warning] = "#{sex_error}"
      render 'new' and return
    elsif cousins_error != nil && cousins_error != ""
      flash.now[:warning] = "#{cousins_error}"
      render 'new' and return
    elsif males_worse_error != nil && males_worse_error != ""
      flash.now[:info] = "#{males_worse_error}"
    elsif params[:commit] == "Go to Probabilities"
      # still save the parameters so do this right at the end
      redirect_to affected_relatives_path and return
    else

      render 'show'
    end
  end
end





