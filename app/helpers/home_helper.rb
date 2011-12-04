module HomeHelper
  def sidebar_home()
	lista = ""
    links = {
      "1" => { :title => t("application.general"), :path => root_path },
      "2" => { :title => t("application.home.summary"), :path => summary_path }
    }
    links.map do |key, value|
      classname = "selected" if value[:path] == request.fullpath
      last = "last" if key.to_i == links.size
      lista += "<li class=\"#{classname} #{last}\">#{link_to(value[:title], value[:path])}</li>"
    end
    lista.html_safe
  end
end
