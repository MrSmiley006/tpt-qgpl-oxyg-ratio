function particleInArea(part, x, y, x1, y1)
   for i = x, x1, 1 do
      for j = y, y1, 1 do
	 part_id = sim.partID(i, j)
	 if part_id ~= nil then
	    if sim.partProperty(part_id, "type") == part then
	       return true
	    end
	 end
      end
   end
   return false
end

function countOxygAndQgpl()
   -- count QGPL and OXYG particles
   local qgpl_counter = 0
   local oxyg_counter = 0
   for j in sim.parts() do
      if sim.partProperty(j, "type") == elem.MRSMILEY006_PT_QGPL then
	 qgpl_counter = qgpl_counter + 1
      elseif sim.partProperty(j, "type") == elem.DEFAULT_PT_OXYG then
	 oxyg_counter = oxyg_counter + 1
      end
   end
   -- print the counts of QGPL and OXYG and the ratio of OXYG to QGPL
   print("QGPL: " .. qgpl_counter)
   print("OXYG: " .. oxyg_counter)
   print("OXYG/QGPL ratio: " .. oxyg_counter / qgpl_counter)
end

event.register(event.aftersim, countOxygAndQgpl)

for i = 20, 300, 1 do
   -- initialize environment
   sim.clearSim()
   sim.resetPressure()
   -- create a wall box and fill it with HYGN
   sim.createWallLine(4, 4, i, 4)
   sim.createWallLine(4, 4, 4, i)
   sim.createWallLine(i, 4, i, i)
   sim.createWallLine(4, i, i, i)
   sim.createBox(5, 5, i-1, i-1, elem.DEFAULT_PT_HYGN)
   -- set temperature and pressure to their respecitve maximums, so the HYGN fuses into OXYG
   for j = 5, i, 1 do
      for k = 5, i, 1 do
	 part = sim.partID(j, k)
	 if part ~= nil then
	    sim.partProperty(part, "temp", sim.MAX_TEMP)
	 end
      end
   end
   sim.pressure(0, 0, i-1, i-1, sim.MAX_PRESSURE)
end
