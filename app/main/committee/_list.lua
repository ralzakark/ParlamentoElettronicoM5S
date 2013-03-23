local committees_selector = param.get("committees_selector", "table")

local paginator_name = param.get("paginator_name")

ui.add_partial_param_names{ "committee_list" }

local filter = { name = "committee_list" }

filter[#filter+1] = {
  name = "name",
  label = _"A-Z",
  selector_modifier = function(selector) selector:add_order_by("name") end
}
filter[#filter+1] = {
  name = "name_desc",
  label = _"Z-A",
  selector_modifier = function(selector) selector:add_order_by("name DESC") end
}

local ui_filters = ui.filters

ui_filters{
  label = _"Change order",
  selector = committees_selector,
  filter,
  content = function()
    ui.paginate{
      name = paginator_name,
      anchor = paginator_name,
      selector = committees_selector,
      per_page = 50,
      content = function() 
        ui.container{
          attr = { class = "committee_list" },
          content = function()
            local committees = committees_selector:exec()

            for i, committee in ipairs(committees) do
              execute.view{
                module = "committee",
                view = "_show_thumb",
                params = {
                  committee = committee,
                }
              }
            end


          end
        }
        slot.put('<br style="clear: left;" />')
      end
    }
  end
}
