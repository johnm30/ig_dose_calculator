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
end
