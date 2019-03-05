class CalculationsController < ApplicationController


  # Bring up the form for doing a new calculation
  def new

    @settings = Hash.new
    @crit_categories ||= create_crits_array
    @crit_default = @crit_categories.first
    logger.debug "Crits = #{@crit_default}"

    # even if new, may have stored settings in current user, but default to session
    # if available

    if session[:settings] != nil && !session[:settings].empty?
      @settings = session[:settings]
      logger.debug "Settings from session = #{@settings.inspect}"
    elsif current_user && current_user.settings != nil && current_user.settings != nil
      @settings = current_user.settings
      logger.debug "Taking settings from current user"
    else
      @settings["attacks"] = { "1" => { "bonus" => 5, "damage" => 0, "crit" => @crit_default }}
      logger.debug "New settings"
    end

    if current_user
      current_user.settings = @settings
      current_user.save
    end

  end

  def create
    @crit_categories ||= create_crits_array
    @crit_default = @crit_categories.first

    button_value = params[:commit]

    # Form will have list of attacks (/round)
    # columns will be attack bonus, modal damage, critical threat range, critical multiplier
    # then an add button to add another attack on same pattern of columns

    # Then defender stats
    # AC, damage reduction



    if button_value != nil
      if button_value == "Calculate"
        @settings = calculations_params

        session[:settings] = @settings

        if current_user
          current_user.settings = @settings
          current_user.save
        end
        # ? either point to new or point to show and do update for subsequent calculations
        # need to add the results parameter to @settings, even if rendering new form
        redirect_to calculations_path and return

      elsif button_value == "Exit"
        #temporary set to nil
        session[:settings] = nil
        redirect_to root_path and return
      end

    else
      @settings = calculations_params
      button_key = nil
      params.each do |key, value|
        if value[0..2] == "Add" || value[0..5] == "Remove"
          button_value = value
          button_key = key
          break
        end
      end
      if button_key != nil
        logger.debug "Key is: #{button_key}; Value is #{params[button_key]}"
        case
        when button_value === "Add Attack"
          count = @settings["attacks"].count
          @settings["attacks"][(count + 1).to_s] = { "bonus" => 0, "damage" => 0, "crit" => @crit_default }


        # if want to access key rather than value and match a 30 letter long part of the label
        #when button_key[0..29] === "add_paternal_uncle_male_cousin"
        when button_value === "Remove Attack"
          count = @settings["attacks"].count
          logger.debug "Count = #{count}, Settings = #{@settings.inspect}"
          @settings["attacks"].delete(count.to_s)
          logger.debug "Count = #{count}, Settings = #{@settings.inspect}"

        end


        if current_user
          current_user.settings = @settings
          current_user.save
        end
        # or render show if a different form for edit
        # perhaps keep the same form as want to update for new form if adding an attack
        # as well as updating an edit form
        logger.debug "Settings before calling form = #{@settings.inspect}"
        render 'new' and return
      end

    end
  end

  private

    def calculations_params
      settings = Hash.new
      settings = params.require(:calculation).permit(:AC, :DR, :crit_immune)
      armour_class = settings["AC"].to_i
      damage_reduction = settings["DR"].to_i
      crit_immune = settings["crit_immune"]
      logger.debug "Settings after params = #{settings}"
      # first need to get number of attacks
      # they are not in a hash now but just stored in labels as the numbers eg attack_1_bonus
      number_attacks = 1
      total_damage_per_round = 0
      loop do
        bonus = params[:calculation]["attack_#{number_attacks.to_s}_bonus"].to_i
        damage = params[:calculation]["attack_#{number_attacks.to_s}_damage"].to_i
        crit = params[:calculation]["attack_#{number_attacks.to_s}_crit"]
        logger.debug "Attack count = #{number_attacks}, Bonus = #{bonus}, damage = #{damage}, crit = #{crit}"
        prob_hit = (20 + 1 - armour_class + bonus) / 20.0
        prob_hit = 0.05 if prob_hit < 0.05 # natural 20 always hits

        if crit_immune == "0"
          # deal with critical hit
          case crit[1]
          when "0"
            prob_crit = 0.05 * prob_hit # threat range * chance of a hit (or crit) on a second roll
          when "9"
            prob_crit = 0.1 * prob_hit
          when "8"
            prob_crit = 0.15 * prob_hit
          else
            prob_crit = 0.2 * prob_hit
          end
          prob_hit -= prob_crit # either critical or normal not both
          multiplier = crit[-1].to_i
          basic_damage_per_round = damage - damage_reduction
          basic_damage_per_round = 0 if basic_damage_per_round < 0
          crit_damage_per_round = (damage * multiplier) - damage_reduction
          crit_damage_per_round = 0 if crit_damage_per_round < 0
          damage_per_round = prob_hit * basic_damage_per_round + prob_crit * crit_damage_per_round
        else
          basic_damage_per_round = damage - damage_reduction # but damage is a mean, so sometimes may be positive even if mean is less than DR
          basic_damage_per_round = 0 if basic_damage_per_round < 0
          damage_per_round = prob_hit * basic_damage_per_round
        end

        total_damage_per_round += damage_per_round

        if settings["attacks"] == nil
          settings["attacks"] = { number_attacks.to_s => { "bonus" => bonus, "damage" => damage, "crit" => crit }}
        else
          settings["attacks"][number_attacks.to_s] = { "bonus" => bonus, "damage" => damage, "crit" => crit }
        end
        settings["damage_per_round"] = total_damage_per_round
        number_attacks += 1
        break if params[:calculation]["attack_#{number_attacks.to_s}_bonus"] == nil
      end
      settings["damage_per_round"] = total_damage_per_round
      return settings
    end

    def create_crits_array
      crits_categories = ["20"+ "\u00A0" + "\u00A0" + "\u00A0"+ "\u00A0"+ "\u00A0" + "\u00A0" + "x2", "19-20 x2", "18-20 x2", "17-20 x2",
                          "20"+ "\u00A0" + "\u00A0" + "\u00A0"+ "\u00A0"+ "\u00A0" + "\u00A0" + "x3", "19-20 x3", "18-20 x3", "17-20 x3",
                          "20"+ "\u00A0" + "\u00A0" + "\u00A0"+ "\u00A0"+ "\u00A0" + "\u00A0" + "x4", "19-20 x4", "18-20 x4", "17-20 x4"]
      return crits_categories
    end

end





