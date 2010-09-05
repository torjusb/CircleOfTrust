local myname, ns = ...

ns.f = CreateFrame("frame")
ns.f:SetScript("OnEvent", function(self, event, ...) if ns[event] then return ns[event](ns, event, ...) end end)


function ns:RegisterEvent(...)
	for i = 1, select("#", ...) do
		self.f:RegisterEvent((select(i, ...)))
	end
end
function ns:UnregisterEvent(...)
	for i = 1,select("#", ...) do
		self.f:UnregisterEvent((select(i, ...)))
	end
end
ns.RegisterEvents, ns.UnregisterEvents = ns.RegisterEvent, ns.UnregisterEvent
