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
    elsif current_user && current_user.settings != nil
      @settings = current_user.settings
      if @settings["attacks"]  == nil
        @settings["attacks"] = { "1" => { "bonus" => 5, "damage_dice" => "1d6", "damage_bonus" => 0, "crit" => @crit_default }}
      end
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

  def index

      settings = Hash.new
      settings = session[:settings]
      @table = Hash.new
      @table = settings["table"] # or ? change table to symbol
      attacks = settings["attacks"]
      damage_reduction = settings["damage_reduction"]
      crit_immune = settings["crit_immune"]
      @label = Array.new
      attacks.each do |key, value|
        crit = value["crit"]
        crit = "20 x2" if crit == "20"+ "\u00A0" + "\u00A0" + "\u00A0"+ "\u00A0"+ "\u00A0" + "\u00A0" + "x2"
        crit = "20 x3" if crit == "20"+ "\u00A0" + "\u00A0" + "\u00A0"+ "\u00A0"+ "\u00A0" + "\u00A0" + "x3"
        crit = "20 x4" if crit == "20"+ "\u00A0" + "\u00A0" + "\u00A0"+ "\u00A0"+ "\u00A0" + "\u00A0" + "x4"
        @label << "Attack #{key}: Bonus #{value["bonus"]}, Damage Dice #{value["damage_dice"]}, Damage Bonus #{value["damage_bonus"]}, Critical Threat #{crit}"
      end
      if crit_immune == "1"
        @label << "Opponent: Damage Reduction #{damage_reduction}, Immune to Criticals"
      else
        @label << "Opponent: Damage Reduction #{damage_reduction}"
      end

      logger.debug "Table for index = #{@table}"

      # I think below means if xlsx format, as determined by the call from create: redirect_to calculations_index_url(format: :xlsx),
      # then do the xlsx format row and if html format do that row ie jsut render new.
      respond_to do |format|
        format.xlsx {response.headers['Content-Disposition'] = "attachment; filename = dpr_table.xlsx"}
        format.html { render :index }
      end


  end

=begin
Consider having an update action to update teh user.settings model that holds a table of the results
every time saved, as opposed to just calculated. It would be the show action that would then export to a xls file.
Need to do some kind of serialise to save a hash rather tahn separate values - need to check settings when serialsied would work for all the subhashes
and it would be quite big, possible text rather than string format.
Would be cleared by reset button instead of exit button
So save would call to update, and append the AC/DPR table in current_user.settings
Now the current user settings would have a trial number key, with attacks, bonus, opponent parameters (not AC), and a series of AC key, DPR values.

When converting to xls table, want to do teh keys only for the first trial
so headings would be AC, then trial 1, trial 2 etc.
Next row would be blank for AC and an array of strings belonging to each trial describing attack bonuses etc
Then row would be the first AC key for trial 1, then the DPR value for trial 1, then the DPR value for trial 2 etc
Might do an array of rows in the action in this format, so just need to do an .each loop in the actual axlsx view file
[[AC, trial 1 DPR, trial 2 DPR],[next AC, next trial 1 DPR, next trial 2 DPR]]


=end


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



    # Only if not logged in
    if button_value != nil
      if button_value == "Export Table" && !current_user
        @settings = calculations_params
        session[:settings] = @settings
        redirect_to calculations_index_url(format: :xlsx) and return
        #redirect_to calculations_index_url and return

      end

    else
      @settings = calculations_params
      #logger.debug("settings after calculation = #{@settings}")
      button_key = nil
      params.each do |key, value|
        if value[0..2] == "Add" || value[0..5] == "Remove" || value[0..3] == "Exit" || value[0..8] == "Calculate" || value[0..3] == "Show" || value[0..5] == "Export"
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
          render "new" and return
        # if want to access key rather than value and match a 30 letter long part of the label
        #when button_key[0..29] === "add_paternal_uncle_male_cousin"
        when button_value === "Remove Attack"
          logger.debug("settings attacks on remove attack = #{@settings["attacks"]}")
          # @settings is an action controller::parameters object not a hash as of rails 5
          # so functions liek size and length do not work, so use .to_h to make it a normal hash
          # only permitted parameters will get converted this way, so use to_unsafe_hash
          count = @settings["attacks"].to_unsafe_hash.length
          logger.debug "Count = #{count}, Settings = #{@settings.inspect}"
          @settings["attacks"].delete(count.to_s)
          logger.debug "Count = #{count}, Settings = #{@settings.inspect}"
          render "new" and return

        when button_value === "Show Trials"
          #@settings = calculations_params.to_unsafe_hash
          #session[:settings] = @settings
          redirect_to trials_path and return

        when button_value === "Export"
          @settings = calculations_params
          session[:settings] = @settings
          redirect_to calculations_index_url(format: :xlsx) and return

        when button_value === "Calculate"
          @settings = calculations_params.to_unsafe_hash
          session[:settings] = @settings

          if current_user
            # just get from session as saved when calculate
            trial_parameters = Hash.new
            trial_parameters[:attacks] = @settings["attacks"]
            trial_parameters[:damage_reduction] = @settings["damage_reduction"]
            trial_parameters[:crit_immune] = @settings["crit_immune"]
            trial_parameters[:table] = @settings["table"]
            logger.debug "Trial parameters = #{trial_parameters}"

            trial = current_user.trials.build(trial_parameters)
            if trial.save
              flash[:success] = "Round saved!"
            else
              flash[:warning] = "Round not saved!"
            end
            current_user.settings = @settings
            current_user.save
          end
          redirect_to calculations_path and return

        else #ie if exit
          #temporary set to nil
          session[:settings] = nil
          if current_user
            current_user.settings = nil if current_user.settings != nil
            Trial.where(user_id: current_user.id).delete_all
            current_user.save
          end
          redirect_to root_path and return

        end
      end
    end
  end

  private

    def calculations_params
      settings = Hash.new
      settings = params.require(:calculation).permit(:AC, :damage_reduction, :crit_immune)
      logger.debug "Settings after params = #{settings}"
      # iterate for all AC, storing the answer for the actual AC
      table = Hash.new
      armour_class = 10
      damage_reduction = settings["damage_reduction"].to_i
      crit_immune = settings["crit_immune"]
      while armour_class <= 40 do
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
          #logger.debug "Dice size = #{dice_size}, dice_number = #{dice_number}"
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
                              prob_crit * damage_calculation(dice_number * multiplier, dice_size, damage_bonus * multiplier, damage_reduction)
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
        table["AC"+ armour_class.to_s] = round_value(total_damage_per_round)
        if armour_class == settings["AC"].to_i
          settings["damage_per_round"] = round_value(total_damage_per_round)
        end
        armour_class += 1
      end
      settings["table"] = table
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
          #logger.debug "Damage iteration = #{damage}"
          damage = 0.0 if damage < 0.0
          damage_per_attack += damage
          n += 1
        end
      else
        # mean damage approximation assuming always at least 0 damage
        damage_per_attack = (dice_size + 1) / 2 * dice_number + damage_bonus - damage_reduction
      end
      #logger.debug "Damage calculation = #{damage_per_attack}"
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





