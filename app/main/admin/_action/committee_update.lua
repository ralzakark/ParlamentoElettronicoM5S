local id = param.get_id()

local committee = Committee:by_id(id) or Committee:new()

param.update(committee, "name", "description")

local name = param.get("name")
if name then
  committee.name = name
end
local description = param.get("description")
if description then
  description = util.trim(description)
  if description == "" then
    description = nil
  end
end
committee.description = description

local err = committee:try_save()

if err then
  slot.put_into("error", (_("Error while updating committee, database reported:<br /><br /> (#{errormessage})"):gsub("#{errormessage}", tostring(err.message))))
  return false
end

if id then
  slot.put_into("notice", _"Committee successfully updated")
else
  slot.put_into("notice", _"Committee successfully registered")
end
