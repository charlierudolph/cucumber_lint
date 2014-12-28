def run command
  result = OpenStruct.new
  command = "PATH=#{BIN_PATH}:$PATH; #{command} 2>&1"

  status = Open4.popen4(command) do |_pid, stdin, stdout, _stderr|
    stdin.close
    result.out = stdout.read
  end

  result.exit_status = status.exitstatus
  result
end
