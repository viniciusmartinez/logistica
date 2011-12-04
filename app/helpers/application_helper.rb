module ApplicationHelper
  def main_navigation
	menu = ""
    pages = [
       {:controller => "[home]", :path => root_path, :title => t("application.dashboard", :default => "Dashboard"), :thumb => "icons/user.png" },
       {:controller => "[suits]", :path => suits_path, :title => t("application.suits", :default => "Pedidos"), :thumb => "icons/user.png" },       
#"1" => {:controller => "[users]", :path => users_path, :title => t("application.users", :default => "Users"), :thumb => "icons/user.png" },
       {:controller => "[contacts, notes]", :path => contacts_path, :title => t("application.contacts", :default => "Contacts"), :thumb => "icons/user.png" },
       {:controller => "[tasks]", :path => tasks_path, :title => t("application.tasks", :default => "Tasks"), :thumb => "icons/user.png" },
       {:controller => "[calendar]", :path => calendar_path, :title => t("application.calendar", :default => "Calendar"), :thumb => "icons/calendar.png" }
    ]
    pages.each do |page|
      classnames = "current" if page[:controller].include? controller.controller_name
      menu += "<li>#{link_to(page[:title], page[:path], :class => classnames)}</li>"
    end
	menu.html_safe
  end
  
  def inline_ui_icon(css_class = "", options = {:id => "", :style => "", :title => ""})
    "<img src='/images/spacer.gif' class='ui-icon #{css_class}' id='#{options[:id]}' title='#{options[:title]}' style='#{options[:style]}' />".html_safe
  end

  def link_to_new(model)
    link_to inline_ui_icon("add") + t("application.new", :default=> "New") + " " + t("activerecord.models.#{model.to_s.downcase}").downcase, url_for(:action => "new"), :class => "button"
  end

  def submit_button(options = {:back => nil, :label => nil, :icon => nil, :close_class => "", :onclick => nil})
    @label = options[:label] || t("application.save", :default => "Save")
    @icon = options[:icon] || "save"
    @back = options[:back] || :back
    @button = "<button class=\"button\" type=\"submit\" onclick=\"#{options[:onclick]}\">"
    if @icon != :none
      @button += inline_ui_icon(@icon)
    end
    @button += @label + "</button>"
    if @back != :none
      @button += "<span class=\"text_button_padding\">" + t("application.or", :default => "or") + "</span>"
      @button += link_to t("application.cancel", :default => "Cancel"), @back, :class => "#{options[:close_class]} text_button_padding link_button"
    end
    @button.html_safe
  end

  def strip_html(text)
    text.gsub(/<\/?[^>]*>/, "").html_safe
  end

  def distance_of_birthday(from_time, to_time = 0, include_seconds = false, options = {})
    from_time = from_time.to_time if from_time.respond_to?(:to_time)
    to_time = to_time.to_time if to_time.respond_to?(:to_time)
    distance_in_minutes = (((to_time - from_time).abs)/60).round
    distance_in_seconds = ((to_time - from_time).abs).round

    I18n.with_options :locale => options[:locale], :scope => 'datetime.distance_in_words' do |locale|
      case distance_in_minutes
      when 0..2529      then locale.t :x_days,         :count => 1
      when 2530..43199     then locale.t :x_days,         :count => (distance_in_minutes.to_f / 1440.0).round
      when 43200..86399    then locale.t :about_x_months, :count => 1
      when 86400..525599   then locale.t :x_months,       :count => (distance_in_minutes.to_f / 43200.0).round
      else
        distance_in_years           = distance_in_minutes / 525600
        minute_offset_for_leap_year = (distance_in_years / 4) * 1440
        remainder                   = ((distance_in_minutes - minute_offset_for_leap_year) % 525600)
        if remainder < 131400
          locale.t(:about_x_years,  :count => distance_in_years)
        elsif remainder < 394200
          locale.t(:over_x_years,   :count => distance_in_years)
        else
          locale.t(:almost_x_years, :count => distance_in_years + 1)
        end
      end
    end
  end

 def lista_sidebar(links)
	lista = ""
	links.map do |key, value|
		classname = "selected" if value[:path] == request.fullpath
		last = "last" if key.to_i == links.size
		lista += "<li class=\"#{classname} #{last}\">#{link_to(value[:title], value[:path])}</li>"
	end
	lista.to_s.html_safe
  end

  def novo?(objeto)
    not objeto.id?
  end

end
