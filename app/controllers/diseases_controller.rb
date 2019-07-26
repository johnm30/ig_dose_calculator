class DiseasesController < ApplicationController


  # new displays the form for creating a new disease, and also displays index
  # of existing diseases
  def new

    @expand_description = get_expand_descriptions
    @categories ||= create_categories


    # Class method defined in Disease model
    current_page = params[:page] || 1
    per_page = params[:per_page] || 10
    @diseases = Disease.sort_by_description(current_page, per_page)
    @disease_count = Disease.count


    # will_paginate normally only works on Activerecord object rather than array
    # of hashes
    # This WillPaginate creates variables, eg total_pages that are only available
    # to view if in the main code.
=begin
    current_page = params[:page] || 1
    per_page = params[:per_page] || 5
    length = @diseases.length
    @diseases = WillPaginate::Collection.create(current_page, per_page, length) do |pager|
      pager.replace @diseases[pager.offset, pager.per_page].to_a
    end
=end
    # This is the instance variable for the empty new disease to pass into
    # the form.
    @disease = Disease.new
  end

  def index
    @categories ||= create_categories
    @disease = Disease.find(params[:format])
    @disease_description = @disease.disease_description

    @expand_description = get_expand_descriptions

    render 'new'
  end


  # New non standard action to export the diseases database to an excel file
  # Will need to define the route for this action in routes
  def export

    # get a hash of all diseases in database
    # something like diseases = Disease.all
    # but the only parameters are id, incidence and prevalence
    # there is one associated disease description, and several associated features, with sensitivities

    # set the first row as headers, name description, incidence, prevalence, list of all features (where values are strengths of association)
    @header = ["ID", "Name", "Description", "Incidence", "Prevalence"]

    # then append the names of all the features - probably sort by id
    create_feature_categories
    create_time_course_categories
    create_inheritance_categories
    create_age_at_onset_categories

    features = Hash.new
    features = Feature.all


    feature_names = Array.new
    feature_names << "Male:Female"

    #list of ids of the features with the category time course
    feature_names += @time_course_categories
    feature_names += @age_at_onset_categories
    feature_names += @inheritance_categories

    @feature_categories.each do |name|
      # all the features in a particular category
      features_array = Feature.where("category = ?", name)
      features_array.each do |feature|
        feature_names << feature.name
      end
    end

    # this is the way to add multiple elements to an array, concatenate two arrays
    @header += feature_names



    # when I display all the information about diseases, it is done in the new action, right half of the view
    # where if index shows just one disease from a link from diagnose diseases, new shows all diseases and
    # show shows only those matching search criteria
    # just does render @diseases in diseases/new view
    # @diseases is got from:
    @diseases = Disease.sort_by_description_no_paginate

    # the work is done by pointing to _disease.html.erb partial for each disease - this is like a row


    @rows_array = Array.new

    @diseases.each do |disease|
      row = Array.new
      row << disease.id # ?or just row = disease.to_a to get all the parameters into an array
      row << disease.disease_description.name
      row << disease.disease_description.description
      row << disease.incidence
      row << disease.prevalence

      feature = features.find_by(name: "Male")
      row << disease.feature_sensitivity(feature)

      @time_course_categories.each do |name|
        feature = features.find_by(name: name)
        if disease.associated?(feature)
          row << disease.feature_sensitivity(feature)
        else
          row << 0
        end
      end

      @age_at_onset_categories.each do |name|
        feature = features.find_by(name: name)
        if disease.associated?(feature)
          row << disease.feature_sensitivity(feature)
        else
          row << 0
        end
      end

      @inheritance_categories.each do |name|
        feature = features.find_by(name: name)
        if disease.associated?(feature)
          row << disease.feature_sensitivity(feature)
        else
          row << 0
        end
      end

      @feature_categories.each do |name|
        # all the features in a particular category
        features_array = Feature.where("category = ?", name)
        features_array.each do |feature|
          if disease.associated?(feature)
            row << disease.feature_sensitivity(feature)
          else
            row << 0
          end
        end
      end


=begin
      Feature.each do |feature|
        if disease.associated?(feature)
          row << disease.feature_sensitivity(feature)
        else
          row << "No"
        end
      end
=end
      @rows_array << row
    end
    #logger.debug "Rows = #{@rows_array.inspect}"

    # I think below means if xlsx format, as determined by the call from create: redirect_to calculations_index_url(format: :xlsx),
    # then do the xlsx format row and if html format do that row ie just render.

    # If this doesn't work try checking gemfile and bundle install and restarting the server
    respond_to do |format|
      format.xlsx {response.headers['Content-Disposition'] = "attachment; filename = disease_table.xlsx"}
      format.html { render :export }
    end
  end






  # create puts the new Disease in the database based on form params
  def create
    @disease = Disease.new(diseases_params)
    if @disease.save
      # For a has_one association, using the @disease.disease_description.new
      # method is not recognised. Only works when already have a disease
      # description and want to access it ie know the disease and selecting
      # the disease description associated with it.
      new_disease_description = DiseaseDescription.new(disease_description_params)
      # disease_description.disease_id = @disease.id
      # disease_description = @disease.disease_description.new(disease_description_params)
      if new_disease_description.save
        flash[:success] = "#{@disease.disease_description.name} created!"
        #redirect_to diseases_edit_url(@disease) and return
        redirect_to diseases_path(@disease.id) and return
      else
        final_message = "Disease description not saved:" + "<br>"
        new_disease_description.errors.full_messages.each do |message|
          final_message << message + "<br>"
        end
        @disease.destroy
      end
    else
      final_message = "This Disease not saved:" + "<br>"
      @disease.errors.full_messages.each do |message|
        final_message << message + "<br>"
      end
    end
    flash.now[:warning] = final_message.html_safe
    current_page = params[:page] || 1
    per_page = params[:per_page] || 10
    @diseases = Disease.sort_by_description(current_page, per_page)
    @disease_count = Disease.count
    @categories ||= create_categories
    #@disease = Disease.new(temp_diseases_params)
    @expand_description = get_expand_descriptions
    render 'new'

  end


  # create display for changing existing Disease entry
  def edit

    @expand_description = get_expand_descriptions

    @categories ||= create_categories

    # Use the instance and params format to fill form with existing data
    @disease = Disease.find(params[:format])
    @disease_description = @disease.disease_description

    # Need to show existing label values
    # These are attributes defined by attr accesssor that will not be saved to database
    @disease.name = @disease_description.name
    @disease.description = @disease_description.description

    # As for new, this is to do the list of created diseases.
    current_page = params[:page] || 1
    per_page = params[:per_page] || 10
    @diseases = Disease.sort_by_description(current_page, per_page)
    @disease_count = Disease.count
    @disease_descriptions = DiseaseDescription.all

  end

  #updates database according to edit form
  def update
    # when using update, we use params[:id] perhaps because it came from a form
    # rather than from clicking a link
    @disease = Disease.find(params[:id])
    edit_disease_description = @disease.disease_description
    if @disease.update_attributes(diseases_params)
      if edit_disease_description.update_attributes(disease_description_params)
        flash[:success] = "#{@disease.disease_description.name} edited"
        redirect_to diseases_url
      else
        final_message = "Disease description not saved:" + "<br>"
        edit_disease_description.errors.full_messages.each do |message|
          final_message << message + "<br>"
        end
        flash.now[:warning] = final_message.html_safe
        @diseases = Disease.paginate(page: params[:page])
        @disease = Disease.new(temp_diseases_params)
        render 'new'
      end
    else
      final_message = "Disease not saved:" + "<br>"
      @disease.errors.full_messages.each do |message|
        final_message << message + "<br>"
      end
      current_page = params[:page] || 1
      per_page = params[:per_page] || 5
      @diseases = Disease.sort_by_description(current_page, per_page)
      @disease_count = Disease.count
      @disease = Disease.new(temp_diseases_params)
      @expand_description = get_expand_descriptions
      render 'new'
    end
  end

  # removes a disease from database triggered by link from new view
  def destroy
    @disease = Disease.find(params[:format])
    flash[:success] = "#{@disease.disease_description.name} deleted"
    @disease.destroy
    redirect_to request.referrer || diseases_url
  end

  # This is to display diseases that satisfy search criteria
  # The list of diseases is in the new view, which should include search form (for
  # prizes it was on the index page)
  def show

    @categories ||= create_categories
    # The method search(search_string) is defined in the disease_description.rb model file and it
    # knows to look up the description column for ILIKE which is a case insensitive search
    search_term = params[:search][:search_string]
    # @disease_descriptions = DiseaseDescription.search(search_term).paginate(page: params[:page])
    disease_descriptions = DiseaseDescription.search(search_term)
    @disease_count = disease_descriptions.count
    # Need an array of diseases from the disease_ids of the disease_descriptions
    # and then paginate in case many matches

    disease_id_list = disease_descriptions.reorder('name ASC').pluck(:disease_id)
    diseases_unpaginated = Disease.all
    @diseases = []
    disease_id_list.each do |id|
      disease = diseases_unpaginated.find(id)
      @diseases << disease
    end
    # Don't paginate, as when move to second page seems to do a redirect new
    # and loads up all the diseases not the searched ones

    if @disease_count>0
      if @disease_count==1
        flash.now[:success] = "Found a disease description containing '#{search_term}'."
      else
        flash.now[:success] = "Found #{@disease_count} disease descriptions containing '#{search_term}'."
      end
      @disease = Disease.new
      @expand_description = get_expand_descriptions
      session[:search_term] = search_term
      render 'new'
    else
      flash[:warning] = "No disease descriptions containing '#{search_term}'."
      session[:search_term] = nil
      redirect_to diseases_url
    end
  end

  def expander
    disease_id = params[:format].to_s
    #logger.debug "Session Expand description is #{session[:expand_description].inspect}"
    @expand_description = session[:expand_description]
    #logger.debug "Disease id is #{disease_id}"
    if @expand_description[disease_id] == 1
      @expand_description[disease_id] = 0
    else
      @expand_description[disease_id] = 1
    end
    #render 'new'
    session[:expand_description] = @expand_description
    #logger.debug "Expand description is #{@expand_description.inspect}"
    #logger.debug "Session Expand description is #{session[:expand_description].inspect}"
    redirect_to request.referrer || diseases_url
  end

  private

    #now I need separate methods to get the form data that belongs in disease
    # model and the form data that belongs in DiseaseDescription model
    def diseases_params
      params.require(:disease).permit(:category)
    end

    def disease_description_params
      description_hash = {}
      description_hash = params.require(:disease).permit(:name, :description)
      description_hash[:disease_id] = @disease.id
      return description_hash
    end

    #def temp_diseases_params
    #  params.require(:disease).permit(:prevalence, :name, :description)
    #end
end
