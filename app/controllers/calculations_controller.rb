class CalculationsController < ApplicationController


  # Bring up the form for doing a new calculation
  def new

    @settings = Hash.new
    @dosage_categories ||= create_dosage_array
    @dosage_default = "2 g/kg split over 2-5 days initial dose for most autoimmune indications"

    # even if new, may have stored settings in current user, but default to session
    # if available


    if session[:settings] != nil && !session[:settings].empty?
      @settings = session[:settings]
      logger.debug "Settings from session = #{@settings.inspect}"
    end



  end

  def create
    @dosage_categories ||= create_dosage_array
    @settings ||= Hash.new
    if session[:settings] != nil && !session[:settings].empty?
      @settings = session[:settings]
    end

    if params[:calculate] == "Calculate"
      @settings = calculations_params.to_unsafe_hash
      session[:settings] = @settings

      redirect_to calculations_path and return
    end
  end

  private

    def calculations_params
      settings = Hash.new
      settings = params.require(:calculation).permit(:sex, :height, :weight)
      logger.debug "Settings after params = #{settings}"
      # iterate for all AC, storing the answer for the actual AC
      sex = settings["sex"]
      height = settings["height"].to_i
      weight = settings["weight"].to_i
      dosage = params[:calculation]["dosage"]

      ibm = 0.0
      if sex == "1"
        if height <= 152
          ibm = 52
        else
          ibm = 52 + 0.75 * (height - 152)
        end
      else
        if height <= 152
          ibm = 49
        else
          ibm = 49 + 0.67 * (height - 152)
        end
      end

      corrected_weight = weight.to_f
      if weight > ibm + ibm / 5.0
        corrected_weight = ibm + 0.4 * (weight - ibm)
      end
      dose = 0.0
      case dosage.first

      when "2"
        dose = corrected_weight * 2.0
      when "1"
        dose = corrected_weight
      when "0"
        dose = corrected_weight * 0.5
      end
      logger.debug "sex = #{sex}, ibm = #{ibm}, corrected_weight = #{corrected_weight}, dose = #{dose}"
      if dosage.first == "2"
        settings["dose"] = "#{round_value(dose)} g split over 2-5 days"
      else
        settings["dose"] = "#{round_value(dose)} g"
      end
      logger.debug("settings after calculation = #{settings}")
      return settings
    end


    def create_dosage_array
      dosage_categories = ["2 g/kg split over 2-5 days initial dose for most autoimmune indications", "1 g/kg for certain autoimmune indications", "0.5 g/kg/month single doses for immunodeficiency"]
      return dosage_categories
    end

    def round_value(value)

      # view files natively support number_with_precision, but controllers don;t
      # so need to specify the path where the method is found
      if value < 0.001 && value > -0.001
        value = 0
      end
      answer = ActionController::Base.helpers.number_with_precision(value,
                            precision: 3,
                            significant: true,
                            strip_insignificant_zeros: true)
      return answer
    end

end





