function macerator_integration_patch_horizontal()
  return util.sprite_load("__space-age__/graphics/entity/crusher/crusher-horizontal-integration",
  {
    scale = 0.5,
    shift = {0,0}
  })
end

function macerator_integration_patch_vertical()
  return util.sprite_load("__space-age__/graphics/entity/crusher/crusher-vertical-integration",
  {
    scale = 0.5,
    shift = util.by_pixel( 0.0, 8)
  })
end

function macerator_animation_horizontal_main()
  return util.sprite_load("__space-age__/graphics/entity/crusher/crusher-horizontal",
  {
    animation_speed = 0.5,
    frame_count = 48,
    scale = 0.5,
    shift = {0,0},
    tint = { r = 0.7, g = 0.87, b = 0.79, a = 1 }
  })
end

function macerator_animation_horizontal_shadow()
  return util.sprite_load("__space-age__/graphics/entity/crusher/crusher-horizontal-shadow",
  {
    animation_speed = 0.5,
    repeat_count = 48,
    scale = 0.5,
    draw_as_shadow = true,
    shift = {0,0}
  })
end

function macerator_animation_vertical_main()
  return util.sprite_load("__space-age__/graphics/entity/crusher/crusher-vertical",
  {
    animation_speed = 0.5,
    frame_count = 48,
    scale = 0.5,
    shift = util.by_pixel( 0.0, 8),
    tint = { r = 0.7, g = 0.87, b = 0.79, a = 1 }
  })
end

function macerator_animation_vertical_shadow()
  return util.sprite_load("__space-age__/graphics/entity/crusher/crusher-vertical-shadow",
  {
    animation_speed = 0.5,
    repeat_count = 48,
    scale = 0.5,
    draw_as_shadow = true,
    shift = util.by_pixel( 0.0, 8),
  })
end

function macerator_working_visualisations_horizontal()
  return util.sprite_load("__space-age__/graphics/entity/crusher/crusher-horizontal-light",
  {
    animation_speed = 0.5,
    repeat_count = 48,
    scale = 0.5,
    blend_mode = "additive",
    draw_as_glow = true,
    shift = {0,0}
  })
end

function macerator_working_visualisations_vertical()
  return util.sprite_load("__space-age__/graphics/entity/crusher/crusher-vertical-light",
  {
    animation_speed = 0.5,
    repeat_count = 48,
    scale = 0.5,
    blend_mode = "additive",
    draw_as_glow = true,
    shift = util.by_pixel( 0.0, 8),
  })
end

return {
  integration_patch_render_layer = "floor",
  integration_patch = {
    north = macerator_integration_patch_vertical(),
    east = macerator_integration_patch_horizontal(),
    south = macerator_integration_patch_vertical(),
    west = macerator_integration_patch_horizontal()
  },
  animation = {
    north =
    {
      layers = {
        macerator_animation_vertical_main(),
        macerator_animation_vertical_shadow()
      }
    },
    east =
    {
      layers = {
        macerator_animation_horizontal_main(),
        macerator_animation_horizontal_shadow()
      }
    },
    south =
    {
      layers = {
        macerator_animation_vertical_main(),
        macerator_animation_vertical_shadow()
      }
    },
    west =
    {
      layers = {
        macerator_animation_horizontal_main(),
        macerator_animation_horizontal_shadow()
      }
    }
  },
  working_visualisations = {
    {
      fadeout = true,
      north_animation = macerator_working_visualisations_vertical(),
      east_animation = macerator_working_visualisations_horizontal(),
      south_animation = macerator_working_visualisations_vertical(),
      west_animation = macerator_working_visualisations_horizontal()
    }
  }
}