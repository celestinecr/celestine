# Celestine ![Crystal CI](https://github.com/celestinecr/celestine/workflows/Crystal%20CI/badge.svg) ![Development Crystal CI](https://github.com/celestinecr/celestine/workflows/Development%20Crystal%20CI/badge.svg) [![Documentation badge](https://img.shields.io/badge/docs-latest-green.svg?style=flat-square)](https://docs.celestine.dev)


[![Celestine Logo](https://raw.githubusercontent.com/celestinecr/celestine/master/logo/logo.svg)](https://github.com/celestinecr/celestine/blob/master/src/make_logo.cr)


A neat library and DSL for creating graphics using SVG

## Installation

Add to shards.yml

```yaml
dependencies:
  celestine:
    github: celestinecr/celestine
```

## Docs

Documentation is cool, you can view the docs for Celestine at:
 * [**docs.celestine.dev**](https://docs.celestine.dev/)

## SVG Stuff It Can Do

A full list is [here](https://docs.celestine.dev/svg_element_checklist.html).

 *TODO*
 * Full SVG support for all [elements](https://developer.mozilla.org/en-US/docs/Web/SVG/Element) and [attributes](https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute)
 * Finish adding all filters
 * Add pattern
 * Add gradients

## Examples

If you'd like to see how the logo was made, check out [make_logo](https://github.com/redcodefinal/celestine/blob/master/src/make_logo.cr)

Here are some more intricate examples. [procedural_art](https://github.com/redcodefinal/procedural_art)

Real world examples made with Celestine. All of these are flat SVG files with no JS inside, using only functions built into Celestine.

 * [Inward](https://www.sol.vin/art/live/inward/)
 * [Mineshift](https://www.sol.vin/art/live/mineshift/)
 * [Hypnos1](https://cdpn.io/redcodefinal/fullpage/ZEOgzXX)
 * [Hypnos2](https://cdpn.io/redcodefinal/fullpage/WNxqYMy)
 * [Pschyoflower](https://codepen.io/redcodefinal/pen/mdrJeGZ)
 * [Semicircle Patchwork 1](https://codepen.io/redcodefinal/pen/WNGwdxe)
 * [Semicircle Patchwork 2](https://codepen.io/redcodefinal/pen/yLaOpae)
 * [Chromatic Aberration](https://codepen.io/redcodefinal/pen/zYKqpBZ)
 * [Polar Spins](https://codepen.io/redcodefinal/pen/RwGaxRY)
 * [Genuary 01 2021](https://codepen.io/redcodefinal/pen/RwGQdVN)
 * [Genuary 02 2021 (10)](https://codepen.io/redcodefinal/pen/bGwvrNo)
 * [Genuary 02 2021 (20)](https://codepen.io/redcodefinal/pen/jOMzLEz)
 * [Genuary 02 2021 (40)](https://codepen.io/redcodefinal/pen/MWjVovO)
 
## Community Examples

These are some examples of cool stuff other people have done with Celestine!

 * [sunrise](https://sunrise.sugarfi.dev) @ [github](https://github.com/sugarfi/sunrise) by [SugarFi](https://sugarfi.dev)
   * Uses the very strong Turbulence and DisplacementMap filters to create a very neat water effect.

## Development

HMU via issues or make a pull request or something I don't know.

## Contributing

1. Fork it (<https://github.com/celestinecr/celestine/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request to the `development` branch at celestinecr/celestine

## Contributors

- [Ian Rash](https://github.com/redcodefinal) - creator and maintainer
- [sugarfi](https://github.com/sugarfi) - contributor
