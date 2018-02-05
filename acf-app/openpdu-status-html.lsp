<% local view, viewlibrary, page_info, session = ... %>
<% htmlviewfunctions = require("htmlviewfunctions") %>
<% html = require("acf.html") %>

<script type="text/javascript">
        if (typeof jQuery == 'undefined') {
                document.write('<script type="text/javascript" src="<%= html.html_escape(page_info.wwwprefix) %>/js/jquery-latest.js"><\/script>');
        }
</script>

<script type="text/javascript">
	if (typeof $.tablesorter == 'undefined') {
		document.write('<script type="text/javascript" src="<%= html.html_escape(page_info.wwwprefix) %>/js/jquery.tablesorter.js"><\/script>');
	}
</script>

<script type="text/javascript">
	$(document).ready(function() {
		$("#list").tablesorter({widgets: ['zebra']});
	});
</script>

<% htmlviewfunctions.displaycommandresults({"edit", "startstop", "poweron", "poweroff"}, session) %>

<% local header_level = htmlviewfunctions.displaysectionstart(view, page_info) %>
<table id="list" class="tablesorter"><thead>
	<tr>
		<th>Socket #</th>
		<th>Status</th>
		<th>Description</th>
    <% if viewlibrary.check_permission("edit") or viewlibrary.check_permission("power") then %>
		<th>Action</th>
		<% end %>
	</tr>
</thead><tbody>
<%
local redir = cfe({type="hidden", value=page_info.orig_action})
for i,item in ipairs(view.value) do %>
	<tr>
    <td><%= html.html_escape(item.socket) %></td>
    <td><%= html.html_escape(item.status) %></td>
    <td><%= html.html_escape(item.description) %></td>
		<% if viewlibrary.check_permission("edit") or viewlibrary.check_permission("power") then %>
		<td>
      <% local socket = cfe({type="hidden", value=item.socket}) %>
  		<% if viewlibrary.check_permission("edit") then
  			htmlviewfunctions.displayitem(cfe({type="link", value={socket=socket, redir=redir}, label="", option="Edit", action="edit" }), page_info, -1)
  		end %>
      <% if viewlibrary.check_permission("poweron") or viewlibrary.check_permission("poweroff") then
        htmlviewfunctions.displayitem(cfe({type="form", value={socket=socket, redir=redir}, label="", option="Power ON", action="poweron" }), page_info, -1)
        htmlviewfunctions.displayitem(cfe({type="form", value={socket=socket, redir=redir}, label="", option="Power OFF", action="poweroff" }), page_info, -1)
  		end %>
		</td>
		<% end %>
	</tr>
<% end %>
</tbody></table>
<% htmlviewfunctions.displaysectionend(header_level) %>
