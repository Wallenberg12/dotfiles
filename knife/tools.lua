-- returns the PID and memory peak of lua process itself
local process_information = function ()
  local result = { memory_peak = 0, PID = nil}
  for lines in io.lines ('/proc/self/status') do
    if (lines:find ("Pid:") == 1) then
      result["PID"] = lines:match ("%d+")
    end
    if (lines:find ("VmPeak:") == 1) then
      result["memory_peak"] = lines:match ("%d+")
    end
  end
  return result
end

return { process_information = process_information }
