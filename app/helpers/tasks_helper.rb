module TasksHelper
  def sidebar_tasks()
    lista = ""
    links = {
      "1" => { :title => t("application.task.incomplete"), :path => tasks_path },
      "2" => { :title => t("application.task.this_week"), :path => week_tasks_path },
      "3" => { :title => t("application.task.next_week"), :path => next_week_tasks_path },
      "4" => { :title => t("application.task.completed"), :path => completed_tasks_path }
    }
    links.map do |key, value|
      classname = "selected" if value[:path] == request.fullpath
      last = "last" if key.to_i == links.size
      lista += "<li class=\"#{classname} #{last}\">#{link_to(value[:title], value[:path])}</li>"
    end
    lista.html_safe
  end
end
