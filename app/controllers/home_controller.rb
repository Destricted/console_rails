class HomeController < ApplicationController
  def index
  end

  def cmd_exec()
    data = params[:cmd].gsub("\r", "\n");

    status = POpen4::popen4( data ) do |stdout, stderr, stdin|  
       stdout.each_line do |line|  
         msg(line.gsub("\n","<br>") )
         end  
       stderr.each_line do |line|  
         msg(line.gsub("\n","<br>") )
         end
     end  
    msg(status.exitstatus)

    render :nothing => true
  end

  def msg(m)
    cmd = "curl http://localhost:9292/faye -d 'message={\"channel\":\"/home/create\", \"data\":{\"text\":\"#{m}\"}}'"
    curl_proc = ChildProcess.build("sh", "-c",  cmd)
    curl_proc.start
  end

end
