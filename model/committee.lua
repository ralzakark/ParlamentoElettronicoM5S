Committee = mondelefant.new_class()
Committee.table = 'committee'

function Committee:build_selector(args)
  local selector = self:new_selector()
  if args.admin_search then
    local search_string = "%" .. args.admin_search .. "%"
    selector:add_where{ "committee.name ILIKE ?", search_string, search_string }
  end
  if args.order then
    if args.order == "id" then
      selector:add_order_by("id")
    elseif args.order == "name" then
      selector:add_order_by("name")
    else
      error("invalid order")
    end
  end
  return selector
end

--function Committee:by_name(name)
--  local selector = self:new_selector()
--  selector:add_where{'"name" = ?', name }
--  selector:optional_object_mode()
--  return selector:exec()
--end

function Committee:get_search_selector(search_string)
  return self:new_selector()
    :add_field( {'"highlight"("committee"."name", ?)', search_string }, "name_highlighted")
    :add_where{ '"committee"."text_search_data" @@ "text_search_query"(?)', search_string }
end
