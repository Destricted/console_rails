class HomeController < ApplicationController
  def index
  end

  def cmd_exec()
    f_in = "scripts/user_scripts/" + session[:user_id] + ".sh"
    f_out = "scripts/user_output/" + session[:user_id] + ".log"
    data = params[:cmd].gsub("\r", "\n");
    data += "\nrm #{f_in}"
    File.open(f_in, "w+") do |f|
      f.write(data)
    end
  	system("sh #{f_in} 2>&1 | tee #{f_out} &") 
  	render nothing: true
  end

  def log_print()
    f_out = "scripts/user_output/" + session[:user_id] + ".log"
  	data = File.read(f_out)
  	render json: data.gsub("\n", "<br>")
  end
end
