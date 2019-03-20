class TrialsController < ApplicationController
  # Can only see the My Book Reviews if logged in anyway
  before_action :logged_in_user, only: [:show, :destroy, :index]
  before_action :correct_user,   only: :destroy

  def show
    @trials = current_user.trials
    render 'show'
  end

  # this is the action for downloading a table of all saved rounds for user
  def index
    trials = current_user.trials
    logger.debug "Table for index = #{trials.inspect}"
    # do a hash or rounds, where first value of each round is the label, and others are the AC values
    # see if the axlsx does sheet.add_column
    # it seems to prefer adding rows even though there is a command
    # could transpose rows into columns
    #intermediate = [column1, column2, column3]
    #sheet.add_row ['Header1', 'Header2', 'Header3']
    #intermediate.transpose.each do |row|
    #  sheet.add_row row
    #end
    # see if rows or columns graph better in excel
    @rows = Hash.new
    @rows_array = Array.new
    row = Array.new
    @header = ["Round"]
    first_trial = trials.first.table
    first_trial.each do |key, value|
      @header << key
    end
    @header << "Parameters"
    n = 1
    trials.each do |trial|
      table = trial.table
      attacks = trial.attacks
      damage_reduction = trial.damage_reduction
      crit_immune = trial.crit_immune
      label = ""
      attacks.each do |key, value|
        crit = value["crit"]
        crit = "20 x2" if crit == "20"+ "\u00A0" + "\u00A0" + "\u00A0"+ "\u00A0"+ "\u00A0" + "\u00A0" + "x2"
        crit = "20 x3" if crit == "20"+ "\u00A0" + "\u00A0" + "\u00A0"+ "\u00A0"+ "\u00A0" + "\u00A0" + "x3"
        crit = "20 x4" if crit == "20"+ "\u00A0" + "\u00A0" + "\u00A0"+ "\u00A0"+ "\u00A0" + "\u00A0" + "x4"
        label += "Attack #{key}: Bonus #{value["bonus"]}, Damage Dice #{value["damage_dice"]}, Damage Bonus #{value["damage_bonus"]}, Critical Threat #{crit};  "
      end
      if crit_immune == 1
        label += "Opponent: Damage Reduction #{damage_reduction}, Immune to Criticals"
      else
        label += "Opponent: Damage Reduction #{damage_reduction}"
      end
=begin
The xlsx file can accept an array for a row, either explicit [  ] or a variable row
A hash could have key and value listed into an array as [key, value] to give two columns
      if @rows.empty?
        @rows = { n.to_s => {label: label, table: table}}
      else
        @rows[n.to_s] = {label: label, table: table}
      end
=end

      row = [n.to_s]
      table.each do |key, value|
        row << value
      end
      row << label
      @rows_array << row
      n+=1
    end
    logger.debug "Rows = #{@rows_array.inspect}"
    @rounds = n - 1
    # I think below means if xlsx format, as determined by the call from create: redirect_to calculations_index_url(format: :xlsx),
    # then do the xlsx format row and if html format do that row ie jsut render new.
    respond_to do |format|
      format.xlsx {response.headers['Content-Disposition'] = "attachment; filename = dpr_table.xlsx"}
      format.html { render :index }
    end
  end

  def destroy

    @trial = Trial.find(params[:format])
    @trial.destroy
    flash[:success] = "Trial deleted"
    redirect_to request.referrer || trials_url
  end





  private

    def correct_user
      @btrial = current_user.trials.find_by(id: params[:id])
      if @trial.nil? && !current_user.admin?
        redirect_to trials_url
      end
    end
end
