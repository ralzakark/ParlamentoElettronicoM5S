local search = param.get("search")

ui.title(_"Committe list")

ui.actions(function()
  ui.link{
    attr = { class = { "admin_only" } },
    text = _"Create new committee",
    module = "admin",
    view = "committee_edit"
  }
end)


ui.form{
  module = "admin", view = "committee_list",
  content = function()
  
    ui.field.text{ label = _"Search for committees", name = "search" }
    
    ui.submit{ value = _"Start search" }
  
  end
}

if not search then
  return
end

local committees_selector = Committee:build_selector{
  admin_search = search,
  order = "name"
}


ui.paginate{
  selector = committees_selector,
  per_page = 30,
  content = function() 
    ui.list{
      records = committees_selector:exec(),
      columns = {
        {
          field_attr = { style = "text-align: right;" },
          label = _"Id",
          name = "id"
        },
        {
          label = _"Name",
          name = "name"
        },
	{
          label = _"Description",
          name = "description"
        },
        {
          content = function(record)
            ui.link{
              attr = { class = "action admin_only" },
              text = _"Edit",
              module = "admin",
              view = "committee_edit",
              id = record.id
            }
          end
        }
      }
    }
  end
}
