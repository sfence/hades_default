-- fake some functions


default = {}


default.gui_bg     = ""
default.gui_bg_img = ""
default.gui_slots  = ""

function default.get_hotbar_bg(x,y)
 local out = ""
 for i=0,7,1 do
  out = out .."image["..x+i..","..y..";1,1;gui_hb_bg.png]"
 end
 return out
end
