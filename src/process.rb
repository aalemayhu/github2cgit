def runInBackground(cmd)
  pid = spawn(cmd)
  Process.detach(pid)
end
