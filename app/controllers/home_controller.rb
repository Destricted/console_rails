class HomeController < ApplicationController
  def index
  end

  def cmd_exec()
    f_in = "scripts/user_scripts/" + session[:user_id] + ".sh"
    data = params[:cmd].gsub("\r", "\n");

    File.open(f_in, "w+") do |f|
      f.write(data)
    end

    process = ChildProcess.build("sh","#{f_in}")
    process.io.stdout = File.new('std.out', 'w+')
    process.io.stderr = File.new('std.err', 'w+')

    stdout = File.open('std.out', 'r')
    stderr = File.open('std.err', 'r')

    process.start

    while !process.exited?
      get_out_str(stdout)
    end 

    render :nothing => true
  end

  def msg(m)
    cmd = "curl http://localhost:9292/faye -d 'message={\"channel\":\"/home/create\", \"data\":{\"text\":\"#{m}\"}}'"
    curl_proc = ChildProcess.build("sh", "-c",  cmd)
    curl_proc.start
  end

  def get_out_str(io)
    rStr = ''
    while (rStr[-1..-1] != $/)
      newChunk=nil
      while ((newChunk = io.gets) == nil)
        sleep 0.1
      end
      rStr.concat(newChunk)
      msg(newChunk.gsub("\n","<br>"))
    end
    return rStr
  end

end
