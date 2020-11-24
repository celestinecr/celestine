require "spec"
require "../src/celestine"
require "file_utils"
require "perlin_noise"
require "procedural_art"

macro make_number_attribute_test(drawable_class, attr_name_html, attr_name_cr)
  it "should set attribute {{attr_name_html.id}} via {{attr_name_cr.id}}" do
    (!!(Celestine.draw { |ctx| ctx.{{drawable_class.id.split("::").last.underscore.id}} {|r| r.{{attr_name_cr.id}} = 100; r} } =~ /#{{{attr_name_html}}}\=\"100\"/)).should eq(true)
    (!!(Celestine.draw { |ctx| ctx.{{drawable_class.id.split("::").last.underscore.id}} {|r| r.{{attr_name_cr.id}} = -100; r} } =~ /#{{{attr_name_html}}}\=\"-100\"/)).should eq(true)
  end
end

macro make_color_attribute_test(drawable_class, attr_name_html, attr_name_cr)
  it "should set attribute {{attr_name_html.id}} via {{attr_name_cr.id}}" do
    (!!(Celestine.draw { |ctx| ctx.{{drawable_class.id.split("::").last.underscore.id}} {|r| r.{{attr_name_cr.id}} = "black"; r} } =~ /#{{{attr_name_html}}}\=\"black\"/)).should eq(true)
    (!!(Celestine.draw { |ctx| ctx.{{drawable_class.id.split("::").last.underscore.id}} {|r| r.{{attr_name_cr.id}} = "red"; r} } =~ /#{{{attr_name_html}}}\=\"red\"/)).should eq(true)
    (!!(Celestine.draw { |ctx| ctx.{{drawable_class.id.split("::").last.underscore.id}} {|r| r.{{attr_name_cr.id}} = "#121212"; r} } =~ /#{{{attr_name_html}}}\=\"\#121212\"/)).should eq(true)
    (!!(Celestine.draw { |ctx| ctx.{{drawable_class.id.split("::").last.underscore.id}} {|r| r.{{attr_name_cr.id}} = "#AAAAAA"; r} } =~ /#{{{attr_name_html}}}\=\"\#AAAAAA\"/)).should eq(true)
  end
end