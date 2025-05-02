# `slipwayhq.jsx`

A [Slipway](https://slipway.co/) Component which takes a [JSX definition](https://og-playground.vercel.app/)
as an input and returns a rendered [canvas](https://slipway.co/docs/guides/canvases).

The rendering is performed using the [Satori library](https://github.com/vercel/satori).

## Required Inputs

- `width`: The width of the output.
- `height`: The height of the output.
- `jsx`: The JSX string.

## Optional Inputs

- `data`: Data which the JSX can bind to.
- `fonts`: An array of fonts used by the JSX. If only one font is specified it will be used as the default font.
- `debug`: Whether to draw bounding boxes to help with debugging.
- `embed_font`: True if Satori should embed the fonts in the intermediate SVG as paths, or let the SVG renderer render the fonts.

## Suggested Permissions

### `--allow-registry-components`

This component is a Fragment Component that internally uses `slipwayhq.jsx_transpile` to transpile the JSX to Javascript,
`slipwayhq.jsx_svg` to produce an SVG from the transpiled JSX,
and `slipwayhq.svg` to render the SVG to [a canvas](https://slipway.co/docs/guides/canvases).

### `--allow-fonts`

This component may need to access fonts from the local system.

### `--allow-http`

If the JSX contains images which need to be loaded from the internet, then HTTP access may be required.

## Example Usage

Test the component by running the following command and pasting in the input when prompted:
```
slipway run-component "slipwayhq.jsx.0.5.1" --allow-fonts --allow-registry-components
```

Input:
```json
{
  "width": 400,
  "height": 300,
  "data": {
    "text": "Hello, World"
  },
  "jsx": "<div style={{height: '100%',width: '100%',display: 'flex',flexDirection: 'column',alignItems: 'center',justifyContent: 'center',backgroundColor: '#fff',fontSize: 32,fontWeight: 600}}><svg width=\"75\" viewBox=\"0 0 75 65\" fill=\"#000\" style={{ margin: '0 75px' }}><path d=\"M37.59.25l36.95 64H.64l36.95-64z\"></path></svg><div style={{ marginTop: 40 }}>{data.text}</div></div>"
}
```

Output:
```json
{
  "canvas": {
    "width": 400,
    "height": 300,
    "data": "<encoded_rgba_bytes_omitted>"
  }
}
```