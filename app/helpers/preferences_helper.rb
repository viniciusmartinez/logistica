module PreferencesHelper
  def sidebar_preferences()
    links = {
      "1" => { :title => t("application.preference.general"), :path => preferences_path },
      "2" => { :title => t("application.dashboard"), :path => dashboard_preferences_path },
      "3" => { :title => t("application.edit_profile"), :path => profile_path }
    }
    @lista = ""
    
    links.map do |key, value|
      classname = "selected" if value[:path] == request.fullpath
      last = "last" if key.to_i == links.size
      @lista += "<li class=\"#{classname} #{last}\">#{link_to(value[:title], value[:path])}</li>"
    end
    @lista.html_safe
  end
end
