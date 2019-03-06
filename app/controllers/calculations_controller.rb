class CalculationsController < ApplicationController


  # Bring up the form for doing a new calculation
  def new

    @settings = Hash.new
    @crit_categories ||= create_crits_array
    @crit_default = @crit_categories.first
    @damage_categories ||= create_damage_dice_array
    @damage_dice_default = "1d6"

    # even if new, may have stored settings in current user, but default to session
    # if available

    if session[:settings] != nil && !session[:settings].empty?
      @settings = session[:settings]
      logger.debug "Settings from session = #{@settings.inspect}"
    elsif current_user && current_user.settings != nil && current_user.settings != nil
      @settings = current_user.settings
      logger.debug "Taking settings from current user"
    else
      @settings["attacks"] = { "1" => { "bonus" => 5, "damage_dice" => "1d6", "damage_bonus" => 0, "crit" => @crit_default }}
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
    @damage_categories ||= create_damage_dice_array
    @damage_dice_default = "1d6"

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
      logger.debug("settings after calculation = #{@settings}")
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
          logger.debug("settings attacks after calculation = #{@settings["attacks"]}")
          count = 0
          @settings["attacks"].each do
            count += 1
          end
          logger.debug "Count = #{count}, Settings = #{@settings}"
          @settings["attacks"][(count + 1).to_s] = { "bonus" => 0, "damage_dice" => "1d6", "damage_bonus" => 0, "crit" => @crit_default }
          logger.debug "Count = #{count}, Settings = #{@settings}"

        # if want to access key rather than value and match a 30 letter long part of the label
        #when button_key[0..29] === "add_paternal_uncle_male_cousin"
        when button_value === "Remove Attack"
          count = @settings["attacks"].size
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
        damage_dice = params[:calculation]["attack_#{number_attacks.to_s}_damage_dice"]
        damage_bonus = params[:calculation]["attack_#{number_attacks.to_s}_damage_bonus"].to_i
        # Need to change the damage to a d? drop down box, and plus and number box for bonus
        # This is because when there is damage reduciton there may sometimes be positive damage with high roll and soemtimes zero.
        # the mean damage would be prob of each non zero score * the non zero score.
        # If d8 + 3 and DR is 5, = net DR of 2, so 1/8 * 8-2 + 1/8 * 7-2 * 1/8 * 6-2 down to 3-2
        # So could interate 1/damage dice * 1 to (damage dice + bonus - DR)
        # 1..(damage dice + bonus - DR).each do |n|  -here n would go from 1 to 6
        #   damage += n/damage dice
        # end
        # this work out correctly as proper average when the damage reduction is zero

        crit = params[:calculation]["attack_#{number_attacks.to_s}_crit"]
        #logger.debug "Attack count = #{number_attacks}, Bonus = #{bonus}, damage = #{damage_dice}, crit = #{crit}"
        prob_hit = (20 + 1 - armour_class + bonus) / 20.0
        prob_hit = 0.05 if prob_hit < 0.05 # natural 20 always hits
        dice_size = damage_dice[2,3].to_i

        dice_number = damage_dice[0].to_i
        logger.debug "Dice size = #{dice_size}, dice_number = #{dice_number}"
        damage_per_attack = 0

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
          damage_per_attack = prob_hit * damage_calculation(dice_number, dice_size, damage_bonus, damage_reduction) +
                              prob_crit * damage_calculation(dice_number * multiplier, dice_size, damage_bonus, damage_reduction)
        else
          damage_per_attack = prob_hit * damage_calculation(dice_number, dice_size, damage_bonus, damage_reduction)
        end
        total_damage_per_round += damage_per_attack

        if settings["attacks"] == nil
          settings["attacks"] = { number_attacks.to_s => { "bonus" => bonus, "damage_dice" => damage_dice, "damage_bonus" => damage_bonus, "crit" => crit }}
        else
          settings["attacks"][number_attacks.to_s] = { "bonus" => bonus, "damage_dice" => damage_dice, "damage_bonus" => damage_bonus, "crit" => crit }
        end
        number_attacks += 1
        break if params[:calculation]["attack_#{number_attacks.to_s}_bonus"] == nil
      end
      settings["damage_per_round"] = round_value(total_damage_per_round)
      logger.debug("settings after calculation = #{settings}")
      return settings
    end

    def damage_calculation(dice_number, dice_size, damage_bonus, damage_reduction)
      damage_per_attack = 0
      if dice_number < 3
        n = dice_number
        while n <=  dice_number * dice_size
          if dice_number == 1
            combinations = 1
          elsif n <= dice_size + 1
            combinations = n - 1
          else
            combinations = dice_number * dice_size - (n - 1)
          end
          damage = 1.0 * combinations / (dice_size ** dice_number) * (n + damage_bonus - damage_reduction)
          logger.debug "Damage iteration = #{damage}"
          damage = 0.0 if damage < 0.0
          damage_per_attack += damage
          n += 1
        end
      else
        # mean damage approximation assuming always at least 0 damage
        damage_per_attack = (dice_size + 1) / 2 * dice_number + damage_bonus - damage_reduction
      end
      logger.debug "Damage calculation = #{damage_per_attack}"
      return damage_per_attack
    end

    def create_crits_array
      crits_categories = ["20"+ "\u00A0" + "\u00A0" + "\u00A0"+ "\u00A0"+ "\u00A0" + "\u00A0" + "x2", "19-20 x2", "18-20 x2", "17-20 x2",
                          "20"+ "\u00A0" + "\u00A0" + "\u00A0"+ "\u00A0"+ "\u00A0" + "\u00A0" + "x3", "19-20 x3", "18-20 x3", "17-20 x3",
                          "20"+ "\u00A0" + "\u00A0" + "\u00A0"+ "\u00A0"+ "\u00A0" + "\u00A0" + "x4", "19-20 x4", "18-20 x4", "17-20 x4"]
      return crits_categories
    end

    def create_damage_dice_array
      dice_categories = ["1d0", "1d2", "1d3", "1d4", "1d6", "1d8", "1d10", "1d12", "1d20",
                         "2d2", "2d3", "2d4", "2d6", "2d8", "2d10", "2d12", "2d20"]
      return dice_categories
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





