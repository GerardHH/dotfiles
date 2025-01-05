-- Show YAZI_LEVEL when detected
function Header:yazi_level()
	local yazi_level = os.getenv("YAZI_LEVEL")
	if yazi_level ~= nil then
		return ui.Span(string.format(" Yazi %d", yazi_level)):style({ fg = "blue", bold = true })
	end
end

-- Render the header with the yazi level when applicable
function Header:render(area)
	self.area = area

	local right = ui.Line({ self:yazi_level(), self:count(), self:tabs() })
	local left = ui.Line({ self:cwd(math.max(0, area.w - right:width())) })
	return {
		ui.Paragraph(area, { left }),
		ui.Paragraph(area, { right }):align(ui.Paragraph.RIGHT),
	}
end

-- Return the name of the selected item including the symlink pointer if applicable
function Status:name()
	local h = cx.active.current.hovered
	if not h then
		return ui.Span("")
	end

	local linked = ""
	if h.link_to ~= nil then
		linked = " -> " .. tostring(h.link_to)
	end
	return ui.Span(" " .. h.name .. linked)
end

-- Return the owner/group of the selected item
function Status:owner()
	local h = cx.active.current.hovered
	if h == nil or ya.target_family() ~= "unix" then
		return ui.Line({})
	end

	return ui.Line({
		ui.Span(ya.user_name(h.cha.uid) or tostring(h.cha.uid)):fg("magenta"),
		ui.Span(":"),
		ui.Span(ya.group_name(h.cha.gid) or tostring(h.cha.gid)):fg("magenta"),
		ui.Span(" "),
	})
end

-- Render the whole status bar
function Status:render(area)
	self.area = area

	local left = ui.Line({ self:name() })
	local right = ui.Line({ self:owner(), self:permissions() })
	return {
		ui.Paragraph(area, { left }),
		ui.Paragraph(area, { right }):align(ui.Paragraph.RIGHT),
		table.unpack(Progress:render(area, right:width())),
	}
end
