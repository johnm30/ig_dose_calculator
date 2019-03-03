module ApplicationHelper
   # Returns the full title on a per-page basis.
  def full_title(page_title = '')
    base_title = "DPS Calculator App"
    if page_title.empty?
      base_title
    else
      #should here use concatenation of string ""+"" rather than
      #interpolation #{} because the provide function saves it as some kind
      #of html code so certain characters such as apostrophe don't display
      #properly
      page_title + " | " + base_title
    end
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
