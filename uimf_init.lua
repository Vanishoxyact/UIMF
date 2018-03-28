local Log = require("uic/log");
local Text = require("uic/text");
local Image = require("uic/image");
local Button = require("uic/button");
local TextButton = require("uic/text_button");
local Frame = require("uic/frame");
local TextBox = require("uic/text_box");
local Util = require ("uic/util");
require("uic/components");
local FlowLayout = require("uic/layout/flowlayout");
local Container = require("uic/layout/container");
local ListView = require("uic/list_view");
require("uic/layout/gap");

_G.UIComponent = UIComponent;
_G.find_uicomponent = find_uicomponent;
_G.print_all_uicomponent_children = print_all_uicomponent_children;
_G.is_uicomponent = is_uicomponent;
_G.output = output;
_G.core = core;
_G.write_log = __write_output_to_logfile;

_G.Log = Log;
_G.Text = Text;
_G.Image = Image;
_G.Button = Button;
_G.TextButton = TextButton;
_G.Frame = Frame;
_G.TextBox = TextBox;
_G.ListView = ListView;
_G.Util = Util;
_G.FlowLayout = FlowLayout;
_G.Container = Container;

core:add_ui_created_callback(
    function()
        Util.init();
    end
);