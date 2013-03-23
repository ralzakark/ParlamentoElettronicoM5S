slot.put_into("title", _"Committee list")

util.help("committee.list")

local committees_selector = Committee:new_selector()

execute.view{
  module = "committee",
  view = "_list",
  params = { committees_selector = committees_selector }
}
