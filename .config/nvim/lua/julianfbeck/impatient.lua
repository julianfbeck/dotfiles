
local status_ok, impatient = pcall(require, "impatient")
print("impatient status_ok: " .. tostring(status_ok))
if not status_ok then
  return
end
impatient.enable_profile()