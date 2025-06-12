# `slipwayhq.jsx`

A [Slipway](https://slipway.co/) Component which takes a [JSX definition](https://og-playground.vercel.app/)
as an input and returns a rendered [canvas](https://slipway.co/docs/guides/canvases).

The rendering is performed using the [Satori library](https://github.com/vercel/satori).

## Required Inputs

- `width`: The width of the output.
- `height`: The height of the output.
- `jsx`: The JSX string.

## Optional Inputs

- `utils_js`: A string containing javascript that adds utility functions to the `utils` object in scope.
- `data`: Data which the JSX can bind to.
- `fonts`: An array of fonts used by the JSX. If only one font is specified it will be used as the default font.
- `debug`: Whether to draw bounding boxes to help with debugging.
- `embed_font`: True if Satori should embed the fonts in the intermediate SVG as paths, or let the SVG renderer render the fonts.
- `background_color`: The background color to set the canvas before the JSX is rendered, in hex format (e.g. `#ccccff`).

## Suggested Permissions

### `--allow-registry-components`

This component is a Fragment Component that internally uses 
[`slipwayhq.jsx__transpile`](https://github.com/slipwayhq/slipway_jsx__transpile) to transpile the JSX to Javascript,
`slipwayhq.jsx__svg` to produce an SVG from the transpiled JSX,
and [`slipwayhq.svg`](https://github.com/slipwayhq/slipway_svg) to render the SVG to [a canvas](https://slipway.co/docs/guides/canvases).

### `--allow-fonts`

This component may need to access fonts from the local system.

### `--allow-http`

If the JSX contains images which need to be loaded from the internet, then HTTP access may be required.

## Example Usage

Test the component by running the following command and pasting in the input when prompted:
```
slipway run-component "slipwayhq.jsx.0.6.1" --allow-fonts --allow-registry-components
```

Input:
```json
{
  "width": 400,
  "height": 300,
  "background_color": "#ccccff",
  "data": {
    "text": "Hello, World"
  },
  "utils_js": "utils.getFill = () => { return \"#00f\"; }",
  "jsx": "<div style={{height: '100%',width: '100%',display: 'flex',flexDirection: 'column',alignItems: 'center',justifyContent: 'center',fontSize: 32,fontWeight: 600}}><svg width=\"75\" viewBox=\"0 0 75 65\" fill={utils.getFill()} style={{ margin: '0 75px' }}><path d=\"M37.59.25l36.95 64H.64l36.95-64z\"></path></svg><div style={{ marginTop: 40 }}>{data.text}</div></div>"
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

![Example Output](example-output.png)

# `slipwayhq.jsx__svg`

A [Slipway](https://slipway.co/) Component which takes a [JSX definition](https://og-playground.vercel.app/)
which has been [transpiled to Javascript](https://github.com/slipwayhq/slipway_jsx__transpile) 
as an input and returns a rendered [canvas](https://slipway.co/docs/guides/canvases).

The rendering is performed using the [Satori library](https://github.com/vercel/satori).

This Component is used by the [`slipwayhq.jsx`](https://github.com/slipwayhq/slipway_jsx) Component and
is not intended to be used directly.

## Required Inputs

- `width`: The width of the output.
- `height`: The height of the output.
- `jsx_js`: The Javascript transpiled JSX string.

## Optional Inputs

- `utils_js`: A string containing javascript that adds utility functions to the `utils` object in scope.
- `data`: Data which the JSX can bind to.
- `fonts`: An array of fonts used by the JSX. If only one font is specified it will be used as the default font.
- `debug`: Whether to draw bounding boxes to help with debugging.
- `embed_font`: True if Satori should embed the fonts in the intermediate SVG as paths, or let the SVG renderer render the fonts.

## Suggested Permissions

### `--allow-fonts`

This component may need to access fonts from the local system.

### `--allow-http`

If the JSX contains images which need to be loaded from the internet, then HTTP access may be required.

## Example Usage

Test the component by running the following command and pasting in the input when prompted:
```
slipway run-component "slipwayhq.jsx__svg.0.6.1" --allow-fonts
```

Input:
```json
{
  "width": 400,
  "height": 300,
  "data": {
    "text": "Hello, World"
  },
  "utils_js": "utils.getFill = () => { return \"#000\"; }",
  "jsx_js": "React.createElement(\"div\", {\n    style: {\n        height: '100%',\n        width: '100%',\n        display: 'flex',\n        flexDirection: 'column',\n        alignItems: 'center',\n        justifyContent: 'center',\n        backgroundColor: '#fff',\n        fontSize: 32,\n        fontWeight: 600\n    }\n}, React.createElement(\"svg\", {\n    width: \"75\",\n    viewBox: \"0 0 75 65\",\n    fill: utils.getFill(),\n    style: {\n        margin: '0 75px'\n    }\n}, React.createElement(\"path\", {\n    d: \"M37.59.25l36.95 64H.64l36.95-64z\"\n})), React.createElement(\"div\", {\n    style: {\n        marginTop: 40\n    }\n}, data.text));\n"
}
```

Output:
```json
{
  "svg": "<svg width=\"400\" height=\"300\" viewBox=\"0 0 400 300\" xmlns=\"http://www.w3.org/2000/svg\"><mask id=\"satori_om-id\"><rect x=\"0\" y=\"0\" width=\"400\" height=\"300\" fill=\"#fff\"/></mask><rect x=\"0\" y=\"0\" width=\"400\" height=\"300\" fill=\"#fff\"/><clipPath id=\"satori_cp-id-0\"><rect x=\"163\" y=\"79\" width=\"75\" height=\"65\"/></clipPath><mask id=\"satori_om-id-0\"><rect x=\"163\" y=\"79\" width=\"75\" height=\"65\" fill=\"#fff\"/></mask><image x=\"163\" y=\"79\" width=\"75\" height=\"65\" href=\"data:image/svg+xml;utf8,%3Csvg  fill=%22%23000%22 xmlns=%22http://www.w3.org/2000/svg%22 width=%22NaN%22 height=%22null%22 viewBox=%220 0 75 65%22%3E%3Cpath d=%22M37.59.25l36.95 64H.64l36.95-64z%22%3E%3C/path%3E%3C/svg%3E\" preserveAspectRatio=\"none\" clip-path=\"url(#satori_cp-id-0)\" mask=\"url(#satori_om-id-0)\"/><mask id=\"satori_om-id-0-0\"><rect x=\"163\" y=\"79\" width=\"0\" height=\"65\" fill=\"#fff\"/></mask><mask id=\"satori_om-id-1\"><rect x=\"114\" y=\"184\" width=\"172\" height=\"37\" fill=\"#fff\"/></mask><path fill=\"black\" d=\"M119.2 200.7L131.5 200.7L131.5 203.2L119.2 203.2L119.2 200.7ZM116.6 190.9L119.7 190.9L119.7 213.7L116.6 213.7L116.6 190.9ZM131.1 190.9L134.1 190.9L134.1 213.7L131.1 213.7L131.1 190.9ZM146.0 214L146.0 214Q144.3 214 142.9 213.4Q141.4 212.8 140.4 211.7Q139.4 210.6 138.8 209.1Q138.3 207.6 138.3 205.8L138.3 205.8L138.3 205.2Q138.3 203.1 138.9 201.5Q139.5 199.9 140.5 198.8Q141.6 197.6 142.9 197.0Q144.3 196.5 145.7 196.5L145.7 196.5Q147.5 196.5 148.8 197.1Q150.1 197.7 151.0 198.8Q151.8 200.0 152.2 201.5Q152.6 203.0 152.6 204.8L152.6 204.8L152.6 206.0L140 206.0L140 203.7L149.7 203.7L149.7 203.5Q149.7 202.3 149.3 201.3Q148.9 200.2 148.0 199.5Q147.2 198.8 145.7 198.8L145.7 198.8Q144.7 198.8 143.9 199.3Q143.0 199.7 142.4 200.5Q141.8 201.3 141.5 202.5Q141.2 203.6 141.2 205.2L141.2 205.2L141.2 205.8Q141.2 207.0 141.5 208.1Q141.9 209.1 142.5 209.9Q143.2 210.7 144.1 211.2Q145.0 211.6 146.2 211.6L146.2 211.6Q147.7 211.6 148.8 211.0Q149.9 210.4 150.7 209.3L150.7 209.3L152.4 210.7Q151.9 211.6 151.0 212.3Q150.2 213.1 148.9 213.5Q147.7 214 146.0 214ZM156.2 189.7L159.1 189.7L159.1 213.7L156.2 213.7L156.2 189.7ZM164.0 189.7L166.9 189.7L166.9 213.7L164.0 213.7L164.0 189.7ZM170.8 205.4L170.8 205.4L170.8 205.1Q170.8 203.2 171.3 201.7Q171.9 200.1 172.9 198.9Q173.9 197.8 175.3 197.1Q176.7 196.5 178.5 196.5L178.5 196.5Q180.3 196.5 181.7 197.1Q183.1 197.8 184.1 198.9Q185.1 200.1 185.7 201.7Q186.2 203.2 186.2 205.1L186.2 205.1L186.2 205.4Q186.2 207.3 185.7 208.8Q185.1 210.4 184.1 211.5Q183.1 212.7 181.7 213.4Q180.3 214 178.5 214L178.5 214Q176.7 214 175.3 213.4Q173.9 212.7 172.9 211.5Q171.9 210.4 171.3 208.8Q170.8 207.3 170.8 205.4ZM173.7 205.1L173.7 205.1L173.7 205.4Q173.7 206.7 174.0 207.8Q174.3 208.9 174.9 209.8Q175.5 210.6 176.4 211.1Q177.3 211.6 178.5 211.6L178.5 211.6Q179.7 211.6 180.6 211.1Q181.5 210.6 182.1 209.8Q182.7 208.9 183.0 207.8Q183.3 206.7 183.3 205.4L183.3 205.4L183.3 205.1Q183.3 203.8 183.0 202.7Q182.7 201.6 182.1 200.7Q181.5 199.8 180.6 199.3Q179.7 198.8 178.5 198.8L178.5 198.8Q177.3 198.8 176.4 199.3Q175.5 199.8 174.9 200.7Q174.3 201.6 174.0 202.7Q173.7 203.8 173.7 205.1ZM189.6 210.3L192.4 210.3L192.4 212.6Q192.4 214 191.7 215.6Q191 217.2 189.7 218.2L189.7 218.2L188.1 217.1Q188.6 216.4 188.9 215.7Q189.3 215.0 189.4 214.2Q189.6 213.5 189.6 212.6L189.6 212.6L189.6 210.3Z M208.9 213.7L210.5 206.8L215.0 190.9L217.2 190.9L215.9 197.1L211.0 213.7L208.9 213.7ZM202.8 190.9L205.8 190.9L209.4 206.5L210.5 213.7L208.3 213.7L202.8 190.9ZM221.9 213.7L223.0 206.5L226.5 190.9L229.5 190.9L224.0 213.7L221.9 213.7ZM215.3 190.9L217.5 190.9L221.9 206.8L223.5 213.7L221.3 213.7L216.6 197.1L215.3 190.9ZM231.7 205.4L231.7 205.4L231.7 205.1Q231.7 203.2 232.2 201.7Q232.7 200.1 233.7 198.9Q234.7 197.8 236.2 197.1Q237.6 196.5 239.3 196.5L239.3 196.5Q241.1 196.5 242.6 197.1Q244.0 197.8 245.0 198.9Q246 200.1 246.5 201.7Q247.1 203.2 247.1 205.1L247.1 205.1L247.1 205.4Q247.1 207.3 246.5 208.8Q246 210.4 245.0 211.5Q244.0 212.7 242.6 213.4Q241.2 214 239.4 214L239.4 214Q237.6 214 236.2 213.4Q234.8 212.7 233.7 211.5Q232.7 210.4 232.2 208.8Q231.7 207.3 231.7 205.4ZM234.6 205.1L234.6 205.1L234.6 205.4Q234.6 206.7 234.9 207.8Q235.2 208.9 235.8 209.8Q236.4 210.6 237.3 211.1Q238.2 211.6 239.4 211.6L239.4 211.6Q240.6 211.6 241.5 211.1Q242.4 210.6 243.0 209.8Q243.5 208.9 243.9 207.8Q244.2 206.7 244.2 205.4L244.2 205.4L244.2 205.1Q244.2 203.8 243.9 202.7Q243.5 201.6 242.9 200.7Q242.3 199.8 241.4 199.3Q240.5 198.8 239.3 198.8L239.3 198.8Q238.2 198.8 237.3 199.3Q236.4 199.8 235.8 200.7Q235.2 201.6 234.9 202.7Q234.6 203.8 234.6 205.1ZM253.5 196.8L253.6 199.4L253.6 213.7L250.7 213.7L250.7 196.8L253.5 196.8ZM258.9 196.7L258.9 196.7L258.8 199.4Q258.5 199.3 258.2 199.3Q257.8 199.3 257.4 199.3L257.4 199.3Q256.4 199.3 255.7 199.6Q254.9 199.9 254.4 200.4Q253.8 201 253.5 201.8Q253.2 202.5 253.1 203.5L253.1 203.5L252.3 203.9Q252.3 202.4 252.6 201.1Q252.9 199.7 253.6 198.7Q254.2 197.6 255.2 197.1Q256.2 196.5 257.6 196.5L257.6 196.5Q257.9 196.5 258.3 196.5Q258.7 196.6 258.9 196.7ZM261.8 189.7L264.7 189.7L264.7 213.7L261.8 213.7L261.8 189.7ZM280.2 213.7L280.0 210.4L280.0 189.7L282.9 189.7L282.9 213.7L280.2 213.7ZM268.6 205.4L268.6 205.4L268.6 205.1Q268.6 203.2 269.1 201.6Q269.5 200.0 270.4 198.8Q271.3 197.7 272.5 197.1Q273.8 196.5 275.3 196.5L275.3 196.5Q276.9 196.5 278.1 197.0Q279.3 197.6 280.1 198.6Q280.9 199.7 281.4 201.2Q281.9 202.7 282.1 204.5L282.1 204.5L282.1 206.0Q281.9 207.8 281.4 209.3Q280.9 210.8 280.1 211.8Q279.3 212.9 278.1 213.4Q276.9 214 275.3 214L275.3 214Q273.8 214 272.5 213.4Q271.3 212.7 270.4 211.6Q269.5 210.4 269.1 208.8Q268.6 207.3 268.6 205.4ZM271.5 205.1L271.5 205.1L271.5 205.4Q271.5 206.7 271.8 207.8Q272.0 208.9 272.6 209.8Q273.1 210.6 274.0 211.1Q274.8 211.5 276.0 211.5L276.0 211.5Q277.4 211.5 278.3 210.9Q279.3 210.3 279.8 209.3Q280.4 208.3 280.7 207.2L280.7 207.2L280.7 203.4Q280.5 202.5 280.2 201.7Q279.8 200.9 279.3 200.3Q278.7 199.7 277.9 199.3Q277.1 198.9 276 198.9L276 198.9Q274.8 198.9 274.0 199.4Q273.1 199.9 272.6 200.7Q272.0 201.6 271.8 202.7Q271.5 203.8 271.5 205.1Z \"/></svg>"
}
```

## Developer Notes

The bundled OpenType.js in Satori has been changed as follows:

In `parseFvarAxis`, change:
```
    axis.name = names[p.parseUShort()] || {};
```
to
```
    axis.name = (names && names[p.parseUShort()]) || {};
```

In `parseFvarInstance`, change:
```
    inst.name = names[p.parseUShort()] || {};
```
to
```
    inst.name = (names && names[p.parseUShort()]) || {};
```

Without this we get the error:
```
"cannot convert 'null' or 'undefined' to object"
```

When the above lines are executed for some fonts.


# `slipwayhq.jsx__transpile`

A [Slipway](https://slipway.co/) Component which takes a [JSX definition](https://og-playground.vercel.app/)
as an input and returns a transpiled Javascript version of the JSX.

This Component is used by the [`slipwayhq.jsx`](https://github.com/slipwayhq/slipway_jsx) Component and
is not intended to be used directly.

This Component uses [Speedy Web Compiler](https://swc.rs/) internally.

## Required Inputs

- `jsx`: The JSX string.

## Suggested Permissions

None.

## Example Usage

Test the component by running the following command and pasting in the input when prompted:
```
slipway run-component "slipwayhq.jsx__transpile.0.6.1"
```

Input:
```json
{
  "jsx": "<div style={{height: '100%',width: '100%',display: 'flex',flexDirection: 'column',alignItems: 'center',justifyContent: 'center',backgroundColor: '#fff',fontSize: 32,fontWeight: 600}}><svg width=\"75\" viewBox=\"0 0 75 65\" fill=\"#000\" style={{ margin: '0 75px' }}><path d=\"M37.59.25l36.95 64H.64l36.95-64z\"></path></svg><div style={{ marginTop: 40 }}>{data.text}</div></div>"
}
```

Output:
```json
{
  "js": "React.createElement(\"div\", {\n    style: {\n        height: '100%',\n        width: '100%',\n        display: 'flex',\n        flexDirection: 'column',\n        alignItems: 'center',\n        justifyContent: 'center',\n        backgroundColor: '#fff',\n        fontSize: 32,\n        fontWeight: 600\n    }\n}, React.createElement(\"svg\", {\n    width: \"75\",\n    viewBox: \"0 0 75 65\",\n    fill: \"#000\",\n    style: {\n        margin: '0 75px'\n    }\n}, React.createElement(\"path\", {\n    d: \"M37.59.25l36.95 64H.64l36.95-64z\"\n})), React.createElement(\"div\", {\n    style: {\n        marginTop: 40\n    }\n}, data.text));\n"
}
```
