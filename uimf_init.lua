local path = "script/uimf/?.lua;"
package.path = path .. package.path

local Log = require("uic/log");
local Text = require("uic/text");
local Image = require("uic/image");
local Button = require("uic/button");
local TextButton = require("uic/text_button");
local TextBox = require("uic/text_box");
local Util = require ("uic/util");
require("uic/components");
local FlowLayout = require("uic/layout/flowlayout");
local Container = require("uic/layout/container");
local Frame = require("uic/frame");
local Dummy = require("uic/dummy");
local ListView = require("uic/list_view");
require("uic/layout/gap");
local EventManager = require("uic/util/event_manager");

_G.UIComponent = UIComponent;
_G.find_uicomponent = find_uicomponent;
_G.print_all_uicomponent_children = print_all_uicomponent_children;
_G.is_uicomponent = is_uicomponent;
_G.out = out;
_G.core = core;
_G.write_log = __write_output_to_logfile;
_G.output_uicomponent = output_uicomponent;

_G.Log = Log;
_G.Text = Text;
_G.Image = Image;
_G.Button = Button;
_G.TextButton = TextButton;
_G.Frame = Frame;
_G.TextBox = TextBox;
_G.ListView = ListView;
_G.Dummy = Dummy;
_G.Util = Util;
_G.FlowLayout = FlowLayout;
_G.Container = Container;
_G.EventManager = EventManager;

core:add_ui_created_callback(
    function()
        Util.init();
    end
);