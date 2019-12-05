class CalculationsController < ApplicationController


  # Bring up the form for doing a new calculation
  def new

    @settings = Hash.new
    @dosage_categories ||= create_dosage_array
    @expand_description = get_expand_descriptions

=begin
 # create an array of all the disease names - these are in disease_descriptions
      # ? assigna  number so the diseases can be identified - try assigning the disease id

collection_select:

# 1st parameter is object (calculation) - not needed befause we have the f. version
# 2nd parameter is the method - I think this is the label of the returning parameter, so for a database object it will be the name of the column that we want to put the selected drop down optino into
#    Will be able to access in the create or update controller action with params[:<name of the object][:<name of this parameter>]
# 3rd parameter is the collection - an array of the objects to choose from
# 4th parameter is the value_method - sets the value attribute of each option on the drop down list - could be the id of a possible object, if the options were objects.
#  If we do :id it sets the value to be the id value of each object in the database, the selected value goes into the 2nd parameter, which might be labelled selected_id for example
# 5th parameter is the text_method - a method that returns text eg a string of the selected object - this says which of the object's parameters we wish actually to display in the dropdown menu,
#  so it is liley to be a text parameter such as the object's name eg Disease.name, and because the object is already set we just enter :name


# So we want to select a disease from a list of all the diseases and we actually want the id of the disease to identify it more easily,
# but my object is calculation, not a database model so cannot just do this
# in the dosage example, I have already set an array of the names that I want, so the value to return is just the same string as that selected, and the values to display are the same strings
# so I used :to_s a bit like placeholders.

 #<%= f.collection_select "dosage" , @dosage_categories,:to_s, :to_s,
      # {include_blank: false, selected: dosage},
      # {multiple: false, size: 3, class: "control label  col-xs-12", style: "font-size:30px; color:#808080; padding-left: 0px; padding-right: 0px; text-align:left"} %>

# If I had a hash collection from disease_discriptions, perhaps the key could be the disease_id column and the value could be the name column
# or could have DiseaseDescription.all, and have :disease_id for value_method, and the :name for text_method, since these are both columns of DiseaseDescription class:

f.collection_select "selected_disease_id", DiseaseDescription.all, :disease_id, :name,
      {include_blank: false},
      {multiple: false, size: 10, class: "control label  col-xs-6", style: "font-size:20px; color:#808080; padding-left: 0px; padding-right: 0px; text-align:left"} %>

# to select only certain specialities of disease
# create a subset of activerecord objects using where on the database class, see if can still use the :disease_id and :name

# so I need the DiseaseDescription objects where the disease speciality column is "neurology"
# get all the disease ids where the speciality is neurology

disease_id_array = Disease.find_by(speciality: "neurology") - it might just find the first one
disease_id_array = Disease.where((["speciality = ?" , "neurology"])) - it might return activerecord objects, then I need to take their ids to use

# get all the DiseaseDescription objects where the disease_id matches the array of disease ids


=end

    # even if new, may have stored settings in current user, but default to session
    # if available

    if session[:settings] != nil && !session[:settings].empty?
      @settings = session[:settings]
      #logger.debug "New action settings from session = #{@settings.inspect}"
      @disease_id_array = Array.new
      if @settings["haematology_select"] == "1"

        # in one go selects the active record objects and plucks the column values we want
        @disease_id_array += Disease.where(["speciality = ?" , "Haematology"]).pluck(:id)

      end
      if @settings["immunology_select"] == "1"
        # in one go selects the active record objects and plucks the column values we want
        @disease_id_array += Disease.where(["speciality = ?" , "Immunology"]).pluck(:id)

      end
      if @settings["neurology_select"] == "1"
        # in one go selects the active record objects and plucks the column values we want
        @disease_id_array += Disease.where(["speciality = ?" , "Neurology"]).pluck(:id)

      end
      if @settings["infectious_diseases_select"] == "1"
        # in one go selects the active record objects and plucks the column values we want
        @disease_id_array += Disease.where(["speciality = ?" , "Infectious Diseases"]).pluck(:id)

      end
      if @settings["other_select"] == "1"
        # in one go selects the active record objects and plucks the column values we want
        @disease_id_array += Disease.where(["speciality = ?" , "Other"]).pluck(:id)

      end
      @matching_descriptions =  DiseaseDescription.where({ disease_id: @disease_id_array})
      #logger.debug "matching disease descriptions = #{@matching_descriptions.inspect}"

    end
  end

  def create

    @dosage_categories ||= create_dosage_array
    @expand_description = get_expand_descriptions
    @settings ||= Hash.new
    if session[:settings] != nil && !session[:settings].empty?
      @settings = session[:settings]
    else
      # giving default values otherwise session and @settings may be nil or empty
      @settings["immunology_select"] = "1"
      @settings["haematology_select"] = "1"
      @settings["neurology_select"] = "1"
      @settings["infectious_diseases_select"] = "1"
      @settings["other_select"] = "1"
      session[:settings] = @settings

    end

    # non standard buttons because two of them
    button_value = nil
    params.each do |key, value|
      if value == "Calculate" || value == "Update"
        button_value = value
        #button_key = key
        break
      end
    end

    if button_value != nil && button_value == "Calculate"
      @settings = calculations_params.to_unsafe_hash
      session[:settings] = @settings
      redirect_to calculations_path and return
    else
      logger.debug "Not running calculate"
      @settings = session[:settings]
      @settings.merge!(update_params.to_unsafe_hash)
      session[:settings] = @settings
      #logger.debug "Settings after update merge = #{@settings.inspect}"
      redirect_to calculations_path and return
    end
  end

  # this action expands or contracts the description of the disease indication selected
  def show
    disease_id = params[:format].to_s
    #logger.debug "calculation Session Expand description is #{session[:expand_description].inspect}"
    @expand_description = session[:expand_description]
    ##logger.debug "Disease id is #{disease_id}"
    if @expand_description[disease_id] == 1
      @expand_description[disease_id] = 0
    else
      @expand_description[disease_id] = 1
    end
    #render 'new'
    session[:expand_description] = @expand_description
    #logger.debug "Expand description is #{@expand_description.inspect}"
    #logger.debug "Session Expand description is #{session[:expand_description].inspect}"
    redirect_to request.referrer || calculations_url  # if call from calculations form redirects to that form
  end



  private


    def update_params
      settings = Hash.new
      settings = params.require(:calculation).permit(:sex, :height, :weight,
                                            :immunology_select, :haematology_select, :neurology_select, :infectious_diseases_select, :other_select,
                                            :selected_disease_id, :manual_dosage, :manual_regimen)
      return settings
    end



    def calculations_params
      settings = Hash.new
      settings = params.require(:calculation).permit(:sex, :height, :weight,
                                            :immunology_select, :haematology_select, :neurology_select, :infectious_diseases_select, :other_select,
                                            :selected_disease_id, :manual_dosage, :manual_regimen)
      logger.debug "Settings after params = #{settings}"

      sex = settings["sex"]
      height = settings["height"].to_i
      weight = settings["weight"].to_i
      settings["manual_dose"] = nil

      # The calculation from weight
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

      dose = corrected_weight
      disease_id = settings["selected_disease_id"].to_i
      logger.debug "Disease id = #{disease_id}"

      manual_regimen = settings["manual_regimen"]
      dosage = nil
      if manual_regimen != nil && manual_regimen != ""
        dosage = manual_regimen
      end
      if disease_id > 0 || dosage != nil
        dosage = Disease.find_by(id: disease_id).regimen if disease_id > 0
        #dosage = "1.11 g/kg amount"
        #logger.debug "Selected regimen = #{dosage}"

        # search the string for kg and truncate that part
        unit_position = dosage.rindex('kg') # position of the last kg starting from zero position, index is first
        if unit_position == nil
          logger.debug "No kg expression in regimen"
          if disease_id > 0
            settings["selected_dose"] = dosage
          else
            settings["selected_dose"] = "No kg expression in entered regimen"
          end
        else
          if dosage[unit_position - 3] != " "
            unit_position += 1
          end
          dosage_left = dosage[0..unit_position-4].to_s

          dosage_right = dosage[dosage.rindex('kg')+3..dosage.length-1]
          dosage_right = "dose" if dosage_right == nil
          logger.debug "Dosage right = #{dosage_right}"

          # check that there is really a number in dosage_left
          #dosage_left = "1150.05 to 3.2g"
          dosage_left.downcase!
          logger.debug "Dosage left = #{dosage_left}; length = #{dosage_left.length}"

          # search for a hyphen and deal with that
          hyphen_position = dosage_left.index('-')
          hyphen_position = dosage_left.index(' to ') if hyphen_position == nil
          if hyphen_position != nil
            low_dose = dosage_left.scan(/\d+\.?\d*/).first # /\d+[,.]\d+/ - only matches if a float not an int
            high_dose = dosage_left.scan(/\d+\.?\d*/).second
            # regex is denoted by a / and a / at beginning and end
            # \d or [0-9] means numbers will match
            # \d+ means match a whole row of numbers with at least one number
            # \d* means match a row of numbers or an empty string
            # [a-c] means match any one of these characters and [a-c]+ means match a row of at least one of these
            # [^a-c] means match a row of anything except these characters
            # doing [,.?] to match any of comma period or nothingdidn't work, I don't know why
            # ? denotes match nothing, eg if no decimal point
            # so above means match a substring beginning with at least one digit, and then a period or nothing and then any digits after the period including none
            logger.debug "Low dose = #{low_dose}, high dose = #{high_dose}."
            if (low_dose == nil && high_dose == nil)
              low_dose = dosage_left.scan(/zero/).first
              if low_dose == "zero"
                high_dose = dosage_left.scan(/one/).first
                if high_dose == "one"
                  high_dose = 1
                else
                  high_dose = dosage_left.scan(/two/).first
                  if high_dose == "two"
                    high_dose = 2
                  end
                end
              else
                low_dose = dosage_left.scan(/one/).first
                if low_dose == "one"
                  low_dose = 1
                  high_dose = dosage_left.scan(/two/).first
                  if high_dose == "two"
                    high_dose = 2
                  end
                else
                  low_dose = dosage_left.scan(/two/).first
                  if low_dose == "two"
                    low_dose = 2
                  end
                end
              end
            end


            logger.debug "Low dose = #{low_dose}, high dose = #{high_dose}."
            low_number = low_dose.to_f if low_dose != "zero"
            high_number = high_dose.to_f
            if low_dose == "zero" && high_number != 0
              settings["selected_dose"] = "0 to #{round_to_previous_5(dose * high_number)} g " + dosage_right
            elsif dose * high_number < 10.0
              settings["selected_dose"] = "#{round_to_previous_5(dose * high_number)} g " + dosage_right
            elsif low_number != 0 && high_number != 0
              settings["selected_dose"] = "#{round_to_previous_5(dose * low_number)} to #{round_to_previous_5(dose * high_number)} g " + dosage_right
            elsif low_number != 0
              settings["selected_dose"] = "#{round_to_previous_5(dose * low_number)} g " + dosage_right
            elsif high_number != 0
              settings["selected_dose"] = "#{round_to_previous_5(dose * high_number)} g " + dosage_right
            else
              settings["selected_dose"] = dosage
            end
          else
            logger.debug "Dosage left when no hyphen = #{dosage_left}"
            number = dosage_left.to_f
            if number == 0
              number = dosage_left.scan(/\d+[,.]\d+/).first # (\d+[,.]\d+) the first block of digits commas or points
              logger.debug "Dosage left after parse = #{number}"
              number = dosage_left.to_f
            end
            if number != 0 && number != nil
              settings["selected_dose"] = "#{round_to_previous_5(dose * number)} g " + dosage_right
            else
              number = dosage_left.scan(/one/).first
              if number == "one"
                number = 1
                settings["selected_dose"] = "#{round_to_previous_5(dose * number)} g " + dosage_right
              else
                number = dosage_left.scan(/two/).first
                if number == "two"
                  number = 2
                  settings["selected_dose"] = "#{round_to_previous_5(dose * number)} g " + dosage_right
                else
                  settings["selected_dose"] = dosage
                end
              end
            end
          end
          logger.debug "Number = #{number}; low number = #{low_number}; high number = #{high_number}."
        end




=begin
          if hyphen_position != nil
            low_position = hyphen_position - 1
            if dosage[low_position] == " "
              low_position -= 1
            end
            low_dose = dosage_left[0..low_position]
            high_position = hyphen_position + 1
            if dosage[high_position] == " "
              high_position += 1
            end
            high_dose = dosage_left[high_position..dosage_left.length-1]
            logger.debug "Low dose = #{low_dose}, high dose = #{high_dose}."
            settings["selected_dose"] = "#{round_to_previous_5(dose * low_dose.to_f)} to #{round_to_previous_5(dose * high_dose.to_f)} g " + dosage_right
          else
            settings["selected_dose"] = "#{round_to_previous_5(dose * dosage_left.to_f)} g " + dosage_right
          end

        end
=end
      elsif settings["manual_dosage"] != nil
        manual_dose = round_to_previous_5(settings["manual_dosage"].to_f * dose)
        logger.debug "Manual dose = #{manual_dose}"
        settings["manual_dose"] = manual_dose
      end

      logger.debug "Disease id = #{disease_id}"
      if disease_id == nil || disease_id == 0
        settings["manual_regimen_dose"] = settings["selected_dose"]
        settings["selected_dose"] = nil
      end

      #logger.debug("settings after calculation = #{settings}")
      return settings
    end





=begin
 # create an array of all the disease names - these are in disease_descriptions
      # ? assigna  number so the diseases can be identified - try assigning the disease id

collection_select:

# 1st parameter is object (calculation) - not needed befause we have the f. version
# 2nd parameter is the method - I think this is the label of the returning parameter, so for a database object it will be the name of the column that we want to put the selected drop down optino into
#    Will be able to access in the create or update controller action with params[:<name of the object][:<name of this parameter>]
# 3rd parameter is the collection - an array of the objects to choose from
# 4th parameter is the value_method - sets the value attribute of each option on the drop down list - could be the id of a possible object, if the options were objects.
#  If we do :id it sets the value to be the id value of each object in the database, the selected value goes into the 2nd parameter, which might be labelled selected_id for example
# 5th parameter is the text_method - a method that returns text eg a string of the selected object - this says which of the object's parameters we wish actually to display in the dropdown menu,
#  so it is liley to be a text parameter such as the object's name eg Disease.name, and because the object is already set we just enter :name


# So we want to select a disease from a list of all the diseases and we actually want the id of the disease to identify it more easily,
# but my object is calculation, not a database model so cannot just do this
# in the dosage example, I have already set an array of the names that I want, so the value to return is just the same string as that selected, and the values to display are the same strings
# so I used :to_s a bit like placeholders.

 #<%= f.collection_select "dosage" , @dosage_categories,:to_s, :to_s,
      # {include_blank: false, selected: dosage},
      # {multiple: false, size: 3, class: "control label  col-xs-12", style: "font-size:30px; color:#808080; padding-left: 0px; padding-right: 0px; text-align:left"} %>

# If I had a hash collection from disease_discriptions, perhaps the key could be the disease_id column and the value could be the name column
# or could have DiseaseDescription.all, and have :disease_id for value_method, and the :name for text_method, since these are both columns of DiseaseDescription class:

f.collection_select "selected_disease_id", DiseaseDescription.all, :disease_id, :name,
      {include_blank: false},
      {multiple: false, size: 10, class: "control label  col-xs-6", style: "font-size:20px; color:#808080; padding-left: 0px; padding-right: 0px; text-align:left"} %>

=end

    def create_dosage_array
      dosage_categories = ["2 g/kg split over 2-5 days initial dose for most autoimmune indications", "1 g/kg for certain autoimmune indications", "0.5 g/kg/month single doses for immunodeficiency"]
      return dosage_categories
    end

    def round_to_previous_5(value)

      return 5 if value < 5.0

      return value.to_i if value % 5 == 0

      answer = ((value/5).to_int) * 5



      return answer.to_i
    end

end





