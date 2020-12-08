### Legend
 * ✘ - Not Implemented (But it can be discussed if this is of any real value)
 * = - Will Not Be Implemented
 * ^ - Planned To Be Implemented
 * / - Partially Implemented
 * ✓ - Is Implemented 

| Status | Tag | How  | Notes | 
|--------|-----|------|-------|
| ✓ | a | [anchor](https://docs.celestine.dev/Celestine/Meta/Context.html#anchor(define=false,&block:Celestine::Anchor-%3ECelestine::Anchor):Celestine::Anchor-instance-method)||
| ✓ | animate |[animate](https://docs.celestine.dev/Celestine/Modules/Animate.html#animate(&block:Proc(Celestine::Animate,Nil))-instance-method)||
| ✓ | animateMotion |[animate_motion](https://docs.celestine.dev/Celestine/Modules/Animate/Motion.html#animate_motion(&block:Celestine::Animate::Motion-%3ECelestine::Animate::Motion)-instance-method)||
| / | animateTransform |[animate_transform_{type}](https://docs.celestine.dev/Celestine/Modules/Animate/Transform.html)||
| ✓ | circle |[circle](https://docs.celestine.dev/Celestine/Meta/Context.html#circle(define=false,&block:Celestine::Circle-%3ECelestine::Circle):Celestine::Circle-instance-method)||
| ^ | clipPath |||
| ✓ | defs |[define](https://docs.celestine.dev/Celestine/Meta/Context.html#define(drawable:Celestine::Drawable)-instance-method)||
| ^ | desc |||
| = | discard ||Doesn't seem implemented by browsers|
| ✓ | ellipse |[ellipse](https://docs.celestine.dev/Celestine/Meta/Context.html#ellipse(define=false,&block:Celestine::Ellipse-%3ECelestine::Ellipse):Celestine::Ellipse-instance-method)||
| ✓ | feBlend |[Celestine::Filter#blend](https://docs.celestine.dev/Celestine/Filter.html#blend(&block:Celestine::Filter::Blend-%3ECelestine::Filter::Blend)-instance-method)||
| ✓ | feColorMatrix |[Celestine::Filter#color_matrix](https://docs.celestine.dev/Celestine/Filter.html#color_matrix(&block:Celestine::Filter::ColorMatrix-%3ECelestine::Filter::ColorMatrix)-instance-method)||
| ✓ | feComponentTransfer |[Celestine::Filter#component_transfer](https://docs.celestine.dev/Celestine/Filter.html#component_transfer(&block:Celestine::Filter::ComponentTransfer-%3ECelestine::Filter::ComponentTransfer)-instance-method)||
| ✓ | feComposite |[Celestine::Filter#composite](https://docs.celestine.dev/Celestine/Filter.html#composite(&block:Celestine::Filter::Composite-%3ECelestine::Filter::Composite)-instance-method)||
| ^ | feConvolveMatrix |||
| ^ | feDiffuseLighting |||
| ✓ | feDisplacementMap |[Celestine::Filter#displacement_map](https://docs.celestine.dev/Celestine/Filter.html#displacement_map(&block:Celestine::Filter::DisplacementMap-%3ECelestine::Filter::DisplacementMap)-instance-method)||
| / | feDistantLight |||
| ^ | feDropShadow ||
| ✓ | feFlood |[Celestine::Filter#flood](https://docs.celestine.dev/Celestine/Filter.html#flood(&block:Celestine::Filter::Flood-%3ECelestine::Filter::Flood)-instance-method)||
| ✓ | feFuncA |[see](https://docs.celestine.dev/Celestine/Filter/ComponentTransfer.html)||
| ✓ | feFuncB |[see](https://docs.celestine.dev/Celestine/Filter/ComponentTransfer.html)||
| ✓ | feFuncG |[see](https://docs.celestine.dev/Celestine/Filter/ComponentTransfer.html)||
| ✓ | feFuncR |[see](https://docs.celestine.dev/Celestine/Filter/ComponentTransfer.html)||
| ✓ | feGaussianBlur |[Celestine::Filter#blur](https://docs.celestine.dev/Celestine/Filter.html#blur(&block:Celestine::Filter::Blur-%3ECelestine::Filter::Blur)-instance-method)||
| ✓ | feImage |[Celestine::Filter#image](https://docs.celestine.dev/Celestine/Filter.html#image(&block:Celestine::Filter::Image-%3ECelestine::Filter::Image)-instance-method)||
| ✓ | feMerge |[Celestine::Filter#merge](https://docs.celestine.dev/Celestine/Filter.html#merge(&block:Celestine::Filter::Merge-%3ECelestine::Filter::Merge)-instance-method)||
| ✓ | feMergeNode |[Celestine::Merge#add_node](https://docs.celestine.dev/Celestine/Filter/Merge.html#add_node(filter_name)-instance-method)||
| ✓ | feMorphology |[Celestine::Filter#morphology](https://docs.celestine.dev/Celestine/Filter.html#morphology(&block:Celestine::Filter::Morphology-%3ECelestine::Filter::Morphology)-instance-method)||
| ✓ | feOffset |[Celestine::Filter#offset](https://docs.celestine.dev/Celestine/Filter.html#offset(&block:Celestine::Filter::Offset-%3ECelestine::Filter::Offset)-instance-method)||
| / | fePointLight |||
| ✓ | feSpecularLighting |[Celestine::Filter#specular_lighting](https://docs.celestine.dev/Celestine/Filter.html#specular_lighting(&block:Celestine::Filter::SpecularLighting-%3ECelestine::Filter::SpecularLighting)-instance-method)||
| / | feSpotLight |||
| ✓ | feTile |[Celestine::Filter#tile](https://docs.celestine.dev/Celestine/Filter.html#tile(&block:Celestine::Filter::Tile-%3ECelestine::Filter::Tile)-instance-method)||
| ✓ | feTurbulence |[Celestine::Filter#turbulence](https://docs.celestine.dev/Celestine/Filter.html#turbulence(&block:Celestine::Filter::Turbulence-%3ECelestine::Filter::Turbulence)-instance-method)|
| ✓ | filter |[filter](https://docs.celestine.dev/Celestine/Meta/Context.html#filter(&block:Celestine::Filter-%3ECelestine::Filter)-instance-method)|
| ✘ | foreignObject |||
| ✓ | g |[group](https://docs.celestine.dev/Celestine/Meta/Context.html#group(define=false,&block:Celestine::Group-%3ECelestine::Group):Celestine::Group-instance-method)||
| = | hatch ||Doesn't seem implemented by browsers|
| = | hatchpath ||Doesn't seem implemented by browsers|
| ✓ | image |[image](https://docs.celestine.dev/Celestine/Meta/Context.html#image(define=false,&block:Celestine::Image-%3ECelestine::Image):Celestine::Image-instance-method)||
| ✘ | line ||Seems covered by path....|
| ^ | linearGradient |||
| / | marker |[marker](https://docs.celestine.dev/Celestine/Meta/Context.html#marker(&block:Celestine::Marker-%3ECelestine::Marker)-instance-method)||
| ✓ | mask |[mask](https://docs.celestine.dev/Celestine/Meta/Context.html#mask(&block:Celestine::Mask-%3ECelestine::Mask)-instance-method)||
| ^ | linearGradient ||
| ^ | metadata ||
| ✓ | mpath |[Celestine::Animate::Motion#mpath](https://docs.celestine.dev/Celestine/Animate/Motion.html#mpath(&block:Proc(Celestine::Path,Nil))-instance-method)||
| ✓ | path |[path](https://docs.celestine.dev/Celestine/Meta/Context.html#path(define=false,&block:Celestine::Path-%3ECelestine::Path):Celestine::Path-instance-method)||
| ^ | pattern |||
| ✘ | polygon ||Seems covered by path|
| ✘ | polyline ||Seems covered by path|
| ^ | radialGradient ||
| ✓ | rect |[rectangle](https://docs.celestine.dev/Celestine/Meta/Context.html#rectangle(define=false,&block:Celestine::Rectangle-%3ECelestine::Rectangle):Celestine::Rectangle-instance-method)||
| ✘ | script ||Not sure if this should be implemented...|
| ^ | set ||This seems useful for simple interactivity|
| ^ | stop ||Part of gradient|
| ✘ | style ||Not sure if this should be implemented...|
| / | svg ||Implemented for main usage but, should allow for nested SVG|
| ^ | switch ||Would allow local dialect switching for text|
| ✘ | symbol ||Is this any different than group?|
| ✓ | text |[text](https://docs.celestine.dev/Celestine/Meta/Context.html#text(define=false,&block:Celestine::Text-%3ECelestine::Text):Celestine::Text-instance-method)||
| ^ | textPath ||Part of text|
| ^ | title ||Rendered as a tooltip when hovering the object|
| ^ | tspan ||Part of text|
| ✓ | use |[use](https://docs.celestine.dev/Celestine/Meta/Context/Methods.html#use(id:String)-instance-method)||
| ✘ | view ||Doesn't seem to be implemented, even mozillas example doesn't work|
