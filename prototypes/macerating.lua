local function get_prototype(base_type, name)
  for type_name in pairs(defines.prototypes[base_type]) do
    local prototypes = data.raw[type_name]
    if prototypes and prototypes[name] then
      return prototypes[name]
    end
  end
end

local function get_item_localised_name(name)
  local item = get_prototype("item", name)
  if not item then return end
  if item.localised_name then
    return item.localised_name
  end
  local prototype
  local type_name = "item"
  if item.place_result then
    prototype = get_prototype("entity", item.place_result)
    type_name = "entity"
  elseif item.place_as_equipment_result then
    prototype = get_prototype("equipment", item.place_as_equipment_result)
    type_name = "equipment"
  elseif item.place_as_tile then
    -- Tiles with variations don't have a localised name
    local tile_prototype = data.raw.tile[item.place_as_tile.result]
    if tile_prototype and tile_prototype.localised_name then
      prototype = tile_prototype
      type_name = "tile"
    end
  end
  return prototype and prototype.localised_name or {type_name.."-name."..name}
end

function generate_macerating_recipe_icons_from_item(item)
  local icons = {}
  if item.icons == nil then
    icons =
    {
      {
        icon = item.icon,
        icon_size = item.icon_size,
        scale = (0.5 * defines.default_icon_size / (item.icon_size or defines.default_icon_size)) * 0.8,
      },
      {
        icon = "__Paracelsin-Graphics__/graphics/icons/macerating.png",
      },
    }
  else
    icons =
    {
      {
        icon = "__Paracelsin-Graphics__/graphics/icons/macerating.png",
      }
    }
    for i = 1, #item.icons do
      local icon = table.deepcopy(item.icons[i]) -- we are gonna change the scale, so must copy the table
      icon.scale = ((icon.scale == nil) and (0.5 * defines.default_icon_size / (icon.icon_size or defines.default_icon_size)) or icon.scale) * 0.8
      icon.shift = util.mul_shift(icon.shift, 0.8)
      icons[#icons + 1] = icon
    end
    icons[#icons + 1] =
    {
      icon = "__Paracelsin-Graphics__/graphics/icons/macerating.png",
    }
  end
  return icons
end

local function generate_macerating_recipe(item)
  local icons = generate_macerating_recipe_icons_from_item(item)
  local default_machine_tints = {primary = {0.125,0.125,0.125,0.125}, secondary = {0.125,0.125,0.125,0.125}, tertiary = {0.125,0.125,0.125,0.125}, quaternary = {0.125,0.125,0.125,0.125}}
  local crafting_machine_tint = data.raw.recipe[item.name] and data.raw.recipe[item.name].crafting_machine_tint or default_machine_tints
  data:extend({
    {
      type = "recipe",
      name = item.name .. "-macerating",
      localised_name = {"recipe-name.macerating", get_item_localised_name(item.name)},
      icon = nil,
      icons = icons,
      subgroup = item.subgroup,
      category = "macerating",
      hidden = true,
      enabled = true,
      unlock_results = false,
      ingredients = {{type = "item", name = item.name, amount = 1, ignored_by_stats = 1}},
      results = nil,
      energy_required = 0.1,
      crafting_machine_tint = crafting_machine_tint
    }
  })
end

local lib = {}

lib.generate_macerating_recipe = generate_macerating_recipe

return lib