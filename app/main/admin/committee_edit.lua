local id = param.get_id()

local committee = Committee:by_id(id)

if committee then
  ui.title(_("Committee: '#{name}'", { name = committee.name }))
else
  ui.title(_"Create new committee")
end

ui.form{
  attr = { class = "vertical" },
  module = "admin",
  action = "committee_update",
  id = committee and committee.id,
  record = committee,
  readonly = not app.session.member.admin,
  routing = {
    default = {
      mode = "redirect",
      modules = "admin",
      view = "committee_list"
    }
  },
  content = function()
    ui.field.text{     label = _"Name", name = "name" }
    ui.field.text{     label = _"Description", name = "description" }
    slot.put("<br />")
    ui.submit{         text  = _"Save" }
  end
}
